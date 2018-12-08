//
//  Group.m
//  ToyRMoi
//
//  Created by Tyler on 2018-11-27.
//  Copyright © 2018 Tyler Vey. All rights reserved.
//

#import "Group.h"


@implementation Group


// Return group and all its contacts as dictionary
-(NSDictionary*) getGroupDictionary{
    // Convert Date and Image to NSStrings
    NSString* dateString = [self dateToNSString:self.date];
    
    // Get array of contact dictionaries
    Contact* c;
    NSMutableArray *contactDicts = [NSMutableArray arrayWithCapacity:20];
    
    for (c in _contacts){
        
        printf("count me");
        [contactDicts addObject:[c getAsDictionary]];
    }
    NSArray *contactArray = [contactDicts copy];
    
    // Dictionary with of contact data
    NSDictionary* dict = @{@"NAME" : self.name,
                           @"DATE" : dateString,
                           @"CONTACTS" : contactArray};
    
    return dict;
}

-(NSData*) serializeAsJson{
    
    // Convert Date and Image to NSStrings
    NSString* dateString = [self dateToNSString:self.date];
    
    // Get array of contact dictionaries
    Contact* c;
    NSMutableArray *contactDicts = [NSMutableArray arrayWithCapacity:20];
 
    for (c in _contacts){
        
        printf("count me");
        [contactDicts addObject:[c getAsDictionary]];
    }
    NSArray *contactArray = [contactDicts copy];
    
    // Dictionary with of contact data
    NSDictionary* dict = @{@"NAME" : self.name,
                           @"DATE" : dateString,
                           @"CONTACTS" : contactArray};
    
    NSData *json;
    NSError *error = nil;
    
    // Convert dictionary to json
    if ([NSJSONSerialization isValidJSONObject:dict])
    {
        // Serialize the dictionary
        json = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
        
        // If no errors, let's view the JSON
        if (json != nil && error == nil)
        {
            NSString *jsonString = [[NSString alloc] initWithData:json encoding:NSUTF8StringEncoding];
            
            NSLog(@"JSON: %@", jsonString);
        }
    }
    
    return json;
}


// NSDate - NSString  conversion functions
- (NSString *)dateToNSString:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSString *stringDate = [dateFormatter stringFromDate:date];
    NSLog(@"%@", stringDate);
    return stringDate;
}

- (NSDate *)stringToNSDate:(NSString *)dateString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSDate *dateFromString = [dateFormatter dateFromString:dateString];
    return dateFromString;
}


// Update Function
- (void) updateFromDict:(NSDictionary*) dict {
    
    // Convert dateString back to date
    NSDate *updateDate = [self stringToNSDate:[dict valueForKey:@"DATE"]];
    
    // Check if update is newer, pass if not.
    if ([updateDate compare:self.date] == NSOrderedAscending) {
        return;
    }
    self.date = updateDate;

    // Update name
    self.name = [dict valueForKey:@"NAME"];
    
    // Contacts will be handled elsewhere.
}

// Create From Dict Function
-(instancetype)initWithDict:(NSDictionary *)dict{
    self = [super init];
    if(self)
    {
        self.name = [dict valueForKey:@"NAME"];
        self.date = [self stringToNSDate:[dict valueForKey:@"DATE"]];
        self.contacts = [[NSMutableArray alloc] init];
    }
    return self;
}


@end
