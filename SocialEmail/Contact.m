//
//  Contact.m
//  ToyRMoi
//  TODO CHANGE THIS
//  Created by Tyler on 2018-11-27.
//  Copyright © 2018 Tyler Vey. All rights reserved.
//

#import "Contact.h"

@implementation Contact


// Likely not needed with plists. TODO change to plist implementation.
- (void)encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:self.name forKey:@"NAME"];
    [encoder encodeObject:self.date forKey:@"DATE"];
    [encoder encodeObject:self.email forKey:@"EMAIL"];
    [encoder encodeObject:self.notes forKey:@"NOTES"];
    [encoder encodeObject:self.image forKey:@"IMAGE"];
    
}

-(id)initWithCoder:(NSCoder *)decoder{
    if(self = [super init]){
        self.name = [decoder decodeObjectForKey:@"NAME"];
        self.date = [decoder decodeObjectForKey:@"DATE"];
        self.email = [decoder decodeObjectForKey:@"EMAIL"];
        self.notes = [decoder decodeObjectForKey:@"NOTES"];
        self.image = [decoder decodeObjectForKey:@"IMAGE"];
        
    }
    return self;
}

@end
