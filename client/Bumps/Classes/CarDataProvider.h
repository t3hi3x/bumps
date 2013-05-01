//
//  CarDataProvider.h
//  Bumps
//
//  Created by Jevin Sweval on 4/1/10.
//  Modified by Alex Breshears on 4/30/13
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

#import <stdint.h>
#include <unistd.h>
#include <errno.h>
#include <string.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <netdb.h>
#include <fcntl.h>

#import "config.h"



@interface CarDataProvider : UIViewController <UIAccelerometerDelegate,CLLocationManagerDelegate> {
	int keySock;
	int serverSock;
   UITextView *text;
   NSString *logId;
   NSTimer *timer;
	CLLocationManager *lm;
	NSString *obdDisplayStr;
	NSString *gpsDisplayStr;
	NSString *accelDisplayStr;
   BOOL  *shouldLogOBD;
}

@property (nonatomic) int keySock;
@property (nonatomic) int serverSock;
@property (nonatomic, retain) NSString *logId;
@property (nonatomic, retain) UITextView *text;
@property (nonatomic, retain) NSTimer *timer;
@property (nonatomic, retain) CLLocationManager *lm;
@property (nonatomic, retain) NSString *obdDisplayStr;
@property (nonatomic, retain) NSString *gpsDisplayStr;
@property (nonatomic, retain) NSString *accelDisplayStr;
@property (nonatomic) BOOL *shouldLogOBD;
@property (nonatomic, retain) NSString *log_id;
@property (nonatomic, retain) NSString *server_host;
@property (nonatomic, retain) NSString *server_port;
@property (nonatomic, retain) NSString *obdkey_host;
@property (nonatomic, retain) NSString *obdkey_port;

- (NSString *)readPid:(int) pid len:(int)len;

- (BOOL)connectServer;
- (BOOL)connectObdKey;

- (void)startLogging;
- (void)stopLogging;

- (void)updateDisplay;

- (void)initWithText:(UITextView *)text logId:(NSString *)logId;

- (BOOL)connectSocket:(int *) sock host:(NSString *)host port:(NSString *)port;

@end
