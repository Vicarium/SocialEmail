//
//  Group.m
//  ToyRMoi
//
//  Created by Tyler on 2018-11-27.
//  Copyright © 2018 Tyler Vey. All rights reserved.
//

#import "Group.h"

@implementation Group

// Likely not needed with plists. TODO change to plist implementation.
- (void)encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:self.name forKey:@"NAME"];
    [encoder encodeObject:self.date forKey:@"DATE"];
    [encoder encodeObject:self.contacts forKey:@"CONTACTS"];
    
}

-(id)initWithCoder:(NSCoder *)decoder{
    if(self = [super init]){
        self.name = [decoder decodeObjectForKey:@"NAME"];
        self.date = [decoder decodeObjectForKey:@"DATE"];
        self.contacts = [decoder decodeObjectForKey:@"CONTACTS"];
        
    }
    return self;
}




@end
