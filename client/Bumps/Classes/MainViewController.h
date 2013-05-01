//
//  stalkerViewController.h
//  stalker
//
//  Created by Jevin Sweval on 2/4/10.
//  Modified by Alex Breshears on 4/30/13
//

#import <UIKit/UIKit.h>

#include <unistd.h>
#include <errno.h>
#include <string.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <netdb.h>
#include <fcntl.h>
#include "CarDataProvider.h"


@interface MainViewController : UIViewController <UITextViewDelegate, UITextFieldDelegate> {
	UITextView *textView;
	UIButton *logButton;
	UILabel *label;
	UITextField *logIDField;
   CarDataProvider *car;
   UISwitch *switch1, *switch2;
	
}

@property (strong) NSString *log_id;
@property (strong) NSString *server_host;
@property (strong) NSString *server_port;
@property (strong) NSString *obdkey_host;
@property (strong) NSString *obdkey_port;

@property (nonatomic, retain) UITextView *textView;
@property (nonatomic, retain) UIButton *logButton;
@property (nonatomic, retain) UILabel *label;
@property (nonatomic, retain) UITextField *logIDField;
@property (nonatomic, retain) CarDataProvider *car;
@property (nonatomic, retain) UISwitch *switch1;
@property (nonatomic, retain) UISwitch *switch2;
@end
