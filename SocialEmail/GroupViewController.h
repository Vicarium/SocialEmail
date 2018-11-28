//
//  GroupViewController.h
//  SocialEmail
//
//  Created by Michelle Mushaninga on 2018-11-25.
//  Copyright © 2018 Michelle and Tyler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Accounts/Accounts.h>
#import <MessageUI/MessageUI.h>
#import "Group.h"
#import "Contact.h"

NS_ASSUME_NONNULL_BEGIN

@class GroupViewController;


@interface GroupViewController : UIViewController<MFMailComposeViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UILabel *groupNameLabel;
@property (weak, nonatomic) IBOutlet UITableView *contactTable;
@property (weak, nonatomic) IBOutlet UIButton *emailButton;

- (IBAction)newEmailButton:(id)sender;
- (IBAction)cancel:(id)sender;

@property (weak,nonatomic) Group * group;

@end

NS_ASSUME_NONNULL_END
