//
//  TableViewController.h
//  SocialEmail
//
//  Created by Michelle Mushaninga on 2018-11-25.
//  Copyright © 2018 Michelle and Tyler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddGroupViewController.h"
#import "Group.h"
#import "GroupViewController.h"
#import "Contact.h"
#import "AddContactViewController.h"


NS_ASSUME_NONNULL_BEGIN

@interface TableViewController : UITableViewController <AddGroupViewControllerDelegate, AddContactViewControllerDelegate>

@property (nonatomic, strong) NSMutableArray *groups;
@property (nonatomic, strong) Group *selectedGroup;

@property (nonatomic, strong) NSMutableArray *contacts;


@end

NS_ASSUME_NONNULL_END
