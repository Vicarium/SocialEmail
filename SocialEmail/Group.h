//
//  Group.h
//  ToyRMoi
//
//  Created by Tyler on 2018-11-27.
//  Copyright © 2018 Tyler Vey. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Group : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSArray *contacts;
@property (nonatomic, copy) NSDate *date;

@end

NS_ASSUME_NONNULL_END
