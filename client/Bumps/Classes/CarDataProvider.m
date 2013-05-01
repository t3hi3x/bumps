//
//  CarDataProvider.m
//  Bumps
//
//  Created by Jevin Sweval on 4/1/10.
//  Modified by Alex Breshears on 4/30/13
//

#import "CarDataProvider.h"
#include <signal.h>

@implementation CarDataProvider

@synthesize keySock;
@synthesize serverSock;
@synthesize text;
@synthesize logId;
@synthesize lm;
@synthesize obdDisplayStr, gpsDisplayStr, accelDisplayStr;
@synthesize timer, shouldLogOBD;
@synthesize log_id, server_host, server_port, obdkey_host, obdkey_port;

- (NSString *)readPid:(int)pid len:(int)len
{
   char buf[512] = {0};
   char c;
   char *p;
   const char *s;
   int ret;
   
   s = [[NSString stringWithFormat:@"01%02X", pid]
        cStringUsingEncoding:(NSStringEncoding)NSASCIIStringEncoding];
   
   // send the pid request
   send(keySock, s, strlen(s), 0);
   
   // get the response
   p = buf;
   do {
      ret = recv(keySock, &c, 1, 0);
      if (ret <= 0)
      {
         break;
      }
      
      *(p++) = c;
   } while (c != '>');
   // p is now pointing at the byte after '>'
   // eg: "12 \r\n>"
   // subtract 4 to point to ' ' and replace with a nul terminator
   p -= 4;
   *p = '\0';
   
   // change pointer to point to begining of data
   if (len == 1)
   {
      p -= 2;
   } else if (len == 2) {
      p -= 5;
      // remove the space between the hex bytes
      p[2] = p[3];
      p[3] = p[4];
      p[5] = '\0';
   }
	
	return [NSString stringWithFormat:@"%s", p];
}

- (void)initWithText:(UITextView *)textView logId:(NSString *)logIdentifier
{
   //initialization method called after the GUI has been created
   text = textView;
   logId = logIdentifier;
   //set initial value for all strings to be empty
   obdDisplayStr = @"";
   gpsDisplayStr = @"";
   accelDisplayStr = @"";
   return;
}

- (BOOL)connectObdKey
{
   //return if user picked to not log OBD data
   if (!shouldLogOBD) {
      return TRUE;
   }

   char *p, c;
   char buf[512] = {0};
   int ret;
   
   // try to connect to the key, return False on failure
   if (![self connectSocket:&keySock host:self.obdkey_host port:self.obdkey_port]) {
      return FALSE;
   }
   
   // reset the OBD-Key
   send(keySock, "ATZ\r", strlen("ATZ\r"), 0);
   
   // wait for the key to send its response back
   // TODO: check for actual response
   sleep(1);
   
   // now that the response has been sent we need to clear it from the
   // TCP buffers so that the reponse isnt incorrectly read in as
   // the response to a PID request
   fcntl(keySock, F_SETFL, O_NONBLOCK);
   p = buf;
   do {
      ret = recv(keySock, &c, 1, 0);
      if (ret > 0)
      {
         *(p++) = c;
      }
   } while (ret > 0);
   fcntl(keySock, F_SETFL, 0);
   
   memset(buf, 0, 512);
   
   // turn echo off
   send(keySock, "ATE0\r", strlen("ATE0\r"), 0);
   
   sleep(1);
   
   fcntl(keySock, F_SETFL, O_NONBLOCK);
   p = buf;
   do {
      ret = recv(keySock, &c, 1, 0);
      if (ret > 0)
      {
         *(p++) = c;
      }
   } while (ret > 0);
   fcntl(keySock, F_SETFL, 0);
   
   return TRUE;
}

- (BOOL)connectServer
{
   // try to connect to the server
   if (![self connectSocket:&serverSock host:self.server_host port:self.server_port]) {
      return FALSE;
   }
   
   return TRUE;
}

- (BOOL)connectSocket:(int *)sock host:(NSString *)host port:(NSString *)port
{
	int ret;
	struct addrinfo *result, hints;
	struct addrinfo *addr;
   struct timeval tv;
   fd_set fds;
	
	int tempsock;
	
	memset(&hints, 0, sizeof hints);
	hints.ai_family = AF_INET;	// set to AF_INET to force ipv4
	hints.ai_socktype = SOCK_STREAM;
	hints.ai_flags = AI_PASSIVE; // use my IP
	
	ret = getaddrinfo([host cStringUsingEncoding:(NSStringEncoding)NSASCIIStringEncoding], 
                     [port cStringUsingEncoding:(NSStringEncoding)NSASCIIStringEncoding],
                     &hints, &result);
	if (ret != 0) return FALSE;
	for(addr = result; addr != NULL; addr = addr->ai_next) {
		if ((tempsock = socket(addr->ai_family, addr->ai_socktype, addr->ai_protocol)) == -1) {
			perror("talker: socket");
         NSLog(@"wtf is this");
			continue;
		}
		
		break;
	}
	
	if (tempsock == -1) {
		return FALSE;
	}
	
   // set the socket to non-blocking in order to short-timeout the connect
   
   //fcntl(tempsock, F_SETFL, O_NONBLOCK);
   
	ret = connect(tempsock, addr->ai_addr, addr->ai_addrlen);
   /*
   // make sure the call returns immediately with "in progress"
   if (ret != -1 && errno != EINPROGRESS)
   {
      return FALSE;
   }
   
   tv.tv_sec = TIMEOUT;
   tv.tv_usec = 0;
   
   FD_ZERO(&fds);
	FD_SET(tempsock, &fds);
   
   ret = select(tempsock+1, &fds, NULL, NULL, &tv);
   if (ret == 0) return FALSE; // timeout!
   if (ret == -1) return FALSE; // error
   
   fcntl(tempsock, F_SETFL, 0);*/
	
   
   if (ret < 0)
   {
      return FALSE;
   }
   
	*sock = tempsock;
	
	return TRUE;
}


- (void)startLogging
{
    //instantiate location manager and start it
   lm = [[CLLocationManager alloc] init];
	lm.delegate = self; // send loc updates to myself
	[lm startUpdatingLocation];

    //start up accelerometer
	[[UIAccelerometer sharedAccelerometer] setUpdateInterval:0.5];
	[[UIAccelerometer sharedAccelerometer] setDelegate:self];
   
    //start up timer that polls OBDKey for values
    //timer will call read_obd() method every 1.5 seconds
   timer = [NSTimer timerWithTimeInterval:1.5
                                   target:self
                                 selector:@selector(read_obd)
                                 userInfo:nil
                                  repeats:YES];
   [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
}

- (void)stopLogging
{
    //clean up sockets
   close(keySock);
   close(serverSock);

   //stop periodic read_obd() calls
   [timer invalidate];

   //stop GPS and accelerometer
   [lm stopUpdatingLocation];
	[[UIAccelerometer sharedAccelerometer] setUpdateInterval:0];
	[[UIAccelerometer sharedAccelerometer] setDelegate:nil];
	[lm release];
}

- (void)test_log
{
    //FOR DEBUG PURPOSES
   NSString *dispStr = @"";
   char p[25] = "Hello, world!";
   dispStr = [dispStr stringByAppendingFormat:@"Throttle position: %s\n", p];
   obdDisplayStr = dispStr;
   [self updateDisplay];
   //send(serverSock, "test:test:test\r\n", strlen("test:test:test\r\n"), 0);
}

- (void)read_obd {

    //return if we arent reading odb data
   if (!shouldLogOBD) {
      return;
   }
   char c;
   char buf[512] = {0};
   char *p;
   const char *s;
   NSString *dispStr = @"";
   int ret;
   
   // request the throttle position
   send(keySock, "0111\r", 5, 0);
   
   // get the response
   p = buf;
   do {
      ret = recv(keySock, &c, 1, 0);
      if (ret <= 0)
      {
         break;
      }
      
      *(p++) = c;
   } while (c != '>');
   p -= 4;
   *p = '\0';
   
   // change pointer to point to begining of data
   p -= 2;
   
   s = [[NSString stringWithFormat:@"%@:11:%s\r\n", logId, p]
        cStringUsingEncoding:(NSStringEncoding)NSASCIIStringEncoding];
   if (s != nil)
   {
      send(serverSock, s, strlen(s), 0);
   }
   else {
      buf[10] = '\0';
      NSLog(@"s is nil, %s", buf);
   }
   
   dispStr = [dispStr stringByAppendingFormat:@"Throttle position: %s\n", p];
   
   // request the speed
   send(keySock, "010D\r", 5, 0);
   
   // get the response
   p = buf;
   do {
      ret = recv(keySock, &c, 1, 0);
      if (ret <= 0)
      {
         break;
      }
      
      *(p++) = c;
   } while (c != '>');
   p -= 4;
   *p = '\0';
   
   // change pointer to point to begining of data
   p -= 2;
   
   s = [[NSString stringWithFormat:@"%@:0D:%s\r\n", logId, p]
        cStringUsingEncoding:(NSStringEncoding)NSASCIIStringEncoding];
   if (s != nil)
   {
      send(serverSock, s, strlen(s), 0);
   }
   else {
      buf[10] = '\0';
      NSLog(@"s is nil, %s", buf);
   }
   
   dispStr = [dispStr stringByAppendingFormat:@"Speed: %s\n", p];
   
   
   // request the rpm
   send(keySock, "010C\r", 5, 0);
   
   // get the response, note this PID returns 2 bytes so pointer
   // has to be adjusted accordingly
   p = buf;
   do {
      ret = recv(keySock, &c, 1, 0);
      if (ret <= 0)
      {
         break;
      }
      
      *(p++) = c;
   } while (c != '>');
   p -= 4;
   *p = '\0';
   
   // change pointer to point to begining of data
   p -= 5;
   p[2] = p[3];
   p[3] = p[4];
   p[5] = '\0';
   
   s = [[NSString stringWithFormat:@"%@:0C:%s\r\n", logId, p]
        cStringUsingEncoding:(NSStringEncoding)NSASCIIStringEncoding];
   if (s != nil)
   {
      send(serverSock, s, strlen(s), 0);
   }
   else {
      buf[10] = '\0';
      NSLog(@"s is nil, %s", buf);
   }
   
   dispStr = [dispStr stringByAppendingFormat:@"RPM: %s\n", p];
   
   
   // request the engine load
   send(keySock, "0104\r", 5, 0);
   
   // get the response
   p = buf;
   do {
      ret = recv(keySock, &c, 1, 0);
      if (ret <= 0)
      {
         break;
      }
      
      *(p++) = c;
   } while (c != '>');
   p -= 4;
   *p = '\0';
   
   // change pointer to point to begining of data
   p -= 2;
   
   s = [[NSString stringWithFormat:@"%@:04:%s\r\n", logId, p]
        cStringUsingEncoding:(NSStringEncoding)NSASCIIStringEncoding];
   if (s != nil)
   {
      send(serverSock, s, strlen(s), 0);
   }
   else {
      buf[10] = '\0';
      NSLog(@"s is nil, %s", buf);
   }
   
   dispStr = [dispStr stringByAppendingFormat:@"Engine Load: %s\n", p];
   
   
   // request the coolant temp
   send(keySock, "0105\r", 5, 0);
   
   // get the response
   p = buf;
   do {
      ret = recv(keySock, &c, 1, 0);
      if (ret <= 0)
      {
         break;
      }
      
      *(p++) = c;
   } while (c != '>');
   p -= 4;
   *p = '\0';
   
   // change pointer to point to begining of data
   p -= 2;
   
   s = [[NSString stringWithFormat:@"%@:05:%s\r\n", logId, p]
        cStringUsingEncoding:(NSStringEncoding)NSASCIIStringEncoding];
   if (s != nil)
   {
      send(serverSock, s, strlen(s), 0);
   }
   else {
      buf[10] = '\0';
      NSLog(@"s is nil, %s", buf);
   }
   
   dispStr = [dispStr stringByAppendingFormat:@"Coolant temp: %s\n", p];
   
   
   // request the fuel pressure
   send(keySock, "010A\r", 5, 0);
   
   // get the response
   p = buf;
   do {
      ret = recv(keySock, &c, 1, 0);
      if (ret <= 0)
      {
         break;
      }
      
      *(p++) = c;
   } while (c != '>');
   p -= 4;
   *p = '\0';
   
   // change pointer to point to begining of data
   p -= 2;
   
   s = [[NSString stringWithFormat:@"%@:0A:%s\r\n", logId, p]
        cStringUsingEncoding:(NSStringEncoding)NSASCIIStringEncoding];
   if (s != nil)
   {
      send(serverSock, s, strlen(s), 0);
   }
   else {
      buf[10] = '\0';
      NSLog(@"s is nil, %s", buf);
   }
   
   dispStr = [dispStr stringByAppendingFormat:@"Fuel Pressure: %s\n", p];
   
   obdDisplayStr = [[NSString alloc] initWithFormat
                    :@"%@", dispStr];
   
   NSLog(@"the str: %s", obdDisplayStr);
   
   [self updateDisplay];
   
}

- (void)updateDisplay
{
    //refresh display on the phone with current values
   text.text = [[NSString alloc] initWithFormat:@"%@\n%@\n%@",
                gpsDisplayStr, accelDisplayStr, obdDisplayStr];
   return;
}

//standard boilerplate methods for GPS
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
	gpsDisplayStr = [[NSString alloc] initWithFormat:@"Location: %@", [newLocation description]];
   
   [self updateDisplay];
	signal(SIGPIPE, SIG_IGN);
	const char *p;
    @try {
        p = [[NSString stringWithFormat:@"%@:LA:%.10f\r\n", logId, [newLocation coordinate].latitude]
             cStringUsingEncoding:(NSStringEncoding)NSASCIIStringEncoding];
        send(serverSock, p, strlen(p), 0);
    }
    @catch (NSException *exception) {
        NSLog(@"Exception caught: %@", exception);
    }
    @try {
        p = [[NSString stringWithFormat:@"%@:LO:%0.10f\r\n", logId, [newLocation coordinate].longitude]
             cStringUsingEncoding:(NSStringEncoding)NSASCIIStringEncoding];
        send(serverSock, p, strlen(p), 0);
    }
    @catch (NSException *exception) {
        NSLog(@"Exception caught: %@", exception);
    }
    @try {
        p = [[NSString stringWithFormat:@"%@:CO:%.2f\r\n", logId, [newLocation course]]
             cStringUsingEncoding:(NSStringEncoding)NSASCIIStringEncoding];
        send(serverSock, p, strlen(p), 0);
    }
    @catch (NSException *exception) {
        NSLog(@"Exception caught: %@", exception);
    }
    @try {
        p = [[NSString stringWithFormat:@"%@:HA:%.2f\r\n", logId, [newLocation horizontalAccuracy]]
             cStringUsingEncoding:(NSStringEncoding)NSASCIIStringEncoding];
        send(serverSock, p, strlen(p), 0);
    }
    @catch (NSException *exception) {
        NSLog(@"Exception caught: %@", exception);
    }
    @try {
        p = [[NSString stringWithFormat:@"%@:VA:%.2f\r\n", logId, [newLocation verticalAccuracy]]
             cStringUsingEncoding:(NSStringEncoding)NSASCIIStringEncoding];
        send(serverSock, p, strlen(p), 0);
    }
    @catch (NSException *exception) {
        NSLog(@"Exception caught: %@", exception);
    }
    @try {
        p = [[NSString stringWithFormat:@"%@:SP:%.2f\r\n", logId, [newLocation speed]]
             cStringUsingEncoding:(NSStringEncoding)NSASCIIStringEncoding];
        send(serverSock, p, strlen(p), 0);
    }
    @catch (NSException *exception) {
        NSLog(@"Exception caught: %@", exception);
    }	
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
	gpsDisplayStr = [[NSString alloc] initWithFormat:@"Error: %@", [error description]];
   [self updateDisplay];
}

//standard boilerplate methods for accelerometer
- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
	accelDisplayStr = [[NSString alloc] initWithFormat:@"Acceleration: x: %.2f y: %.2f z: %.2f ",
                      acceleration.x, acceleration.y, acceleration.z];
   [self updateDisplay];
	
	const char *p;
	p = [[NSString stringWithFormat:@"%@:AX:%.2f\r\n", logId, acceleration.x]
        cStringUsingEncoding:(NSStringEncoding)NSASCIIStringEncoding];
	send(serverSock, p, strlen(p), 0);
	p = [[NSString stringWithFormat:@"%@:AY:%.2f\r\n", logId, acceleration.y]
        cStringUsingEncoding:(NSStringEncoding)NSASCIIStringEncoding];
	send(serverSock, p, strlen(p), 0);
	p = [[NSString stringWithFormat:@"%@:AZ:%.2f\r\n", logId, acceleration.z]
        cStringUsingEncoding:(NSStringEncoding)NSASCIIStringEncoding];
   send(serverSock, p, strlen(p), 0);
}



@end
