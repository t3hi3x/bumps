//
//  SQLiteDataProvider.h
//  Bumps
//
//  Created by Alex Breshears on 4/29/13.
//
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface SQLiteDataProvider : NSObject{
    NSString *database_location;
    NSString *vin;
}

@property (nonatomic, retain) NSString *database_location;
@property (nonatomic, retain) NSString *vin;

+ (SQLiteDataProvider*) initialize:(NSString*)db_path vin:(NSString*)vin;

- (int) writeLog:(NSString*)category value:(NSString*)value;

@end