//
//  main.m
//  Bumps
//
//  Created by Matt Swanson on 4/1/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sys/signal.h>

void SigPipeHandler(int s);

void SigPipeHandler(int s)
{
    NSLog(@"We Got a Pipe Single :%d____________",s);
}

int main(int argc, char *argv[]) {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    signal(SIGPIPE, SigPipeHandler);
    int retVal = UIApplicationMain(argc, argv, nil, @"BumpsAppDelegate");
    [pool release];
    return retVal;
}
