//
//  Contact.h
//  ToyRMoi
// TODO CHAnge this
//  Created by Tyler on 2018-11-27.
//  Copyright © 2018 Tyler Vey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface Contact : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *notes;
@property (nonatomic, copy) NSDate *date;
@property (nonatomic, copy) UIImage *image;

-(NSData*) serializeAsJson;
-(NSDictionary*) getAsDictionary;
-(void) updateFromDict:(NSDictionary*) dict;
-(instancetype)initWithDict:(NSDictionary *)dict;


@end

NS_ASSUME_NONNULL_END
