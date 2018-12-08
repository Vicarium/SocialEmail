//
//  Group.h
//  ToyRMoi
//
//  Created by Tyler on 2018-11-27.
//  Copyright © 2018 Tyler Vey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Contact.h"




NS_ASSUME_NONNULL_BEGIN

@interface Group : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, retain) NSMutableArray *contacts;
@property (nonatomic, copy) NSDate *date;

//- (void)writeStringToFile:(NSString*)aString;
//- (void)readStringFromFile:(NSString*)aString;

-(NSData*) serializeAsJson;
-(NSDictionary*) getGroupDictionary;
-(void) updateFromDict:(NSDictionary*) dict;
-(instancetype)initWithDict:(NSDictionary *)dict;


@end

NS_ASSUME_NONNULL_END
