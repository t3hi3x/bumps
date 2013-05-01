//
//  SQLiteDataProvider.m
//  Bumps
//
//  Created by Alex Breshears on 4/29/13.
//
//

#import "SQLiteDataProvider.h"

@implementation SQLiteDataProvider

@synthesize database_location, vin;

#pragma mark - Public Methods
 
+ (SQLiteDataProvider*) initialize:(NSString*)db_path
{
    return nil;
}

- (int) writeLog:(NSString*)category value:(NSString*)value
{
    return 0;
}

#pragma mark - Private Methods

- (NSString*) genereateInsertLogSQL:(NSString*)category value:(NSString*)value date:(NSString*)date
{
    NSString *toReturn = [NSString stringWithFormat:@"INSERT INTO data (vin, para_id, value, created, updated) VALUES (%1@, %2@, %3@, now(), now())", self.vin, category, value];
    return toReturn;
}

- (int) executeSQL:(NSString*)sql {
    
}

@end