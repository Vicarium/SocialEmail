//
//  Contact.m
//  ToyRMoi
//  TODO CHANGE THIS
//  Created by Tyler on 2018-11-27.
//  Copyright © 2018 Tyler Vey. All rights reserved.
//

#import "Contact.h"

@implementation Contact


-(NSData*) serializeAsJson{
    
    NSDictionary* dict = [self getAsDictionary];
    
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

-(NSDictionary*) getAsDictionary{
    // Convert Date and Image to NSStrings
    NSString* dateString = [self dateToNSString:self.date];
    
    NSString* imageString = [self imageToNSString:self.image];
    
    // Set to blanks if nil value
    if (imageString == nil){ imageString = @"";}
    if (dateString == nil){ dateString = @"";}
    
    // Dictionary with of contact data
    NSDictionary* dict = @{@"NAME" : self.name,
                           @"EMAIL" : self.email,
                           @"NOTES" : self.notes,
                           @"DATE" : dateString,
                           @"IMAGE" : imageString
                           };
    
    return dict;
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


// UIImage - NSString  conversion functions
- (NSString *)imageToNSString:(UIImage *)image
{
    NSData *imageData = UIImagePNGRepresentation(image);
    
    return [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

- (UIImage *)stringToUIImage:(NSString *)string
{
    NSData *data = [[NSData alloc]initWithBase64EncodedString:string
                                                      options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    return [UIImage imageWithData:data];
}


// Update Function
- (void) updateFromDict:(NSDictionary*) dict {
    
    // Convert dateString back to date
    NSDate *updateDate = [self stringToNSDate:[dict valueForKey:@"DATE"]];
    
    // Check if update is newer, pass if not.
    if ([updateDate compare:self.date] == NSOrderedAscending) {
        return;
    }
    self.name = [dict valueForKey:@"NAME"];
    self.notes = [dict valueForKey:@"NOTES"];
    self.date = updateDate;
    self.image = [self stringToUIImage:[dict valueForKey:@"IMAGE"]];
}


// Create From Dict Function
-(instancetype)initWithDict:(NSDictionary *)dict{
    self = [super init];
    if(self)
    {
        self.name = [dict valueForKey:@"NAME"];
        self.email = [dict valueForKey:@"EMAIL"];
        self.notes = [dict valueForKey:@"NAME"];
        self.date = [self stringToNSDate:[dict valueForKey:@"DATE"]];
        self.image = [self stringToUIImage:[dict valueForKey:@"IMAGE"]];
    }
    return self;
}



@end
