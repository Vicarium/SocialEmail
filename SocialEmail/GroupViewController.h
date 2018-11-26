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

NS_ASSUME_NONNULL_BEGIN

@interface GroupViewController : UIViewController<MFMailComposeViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UILabel *groupNameLabel;
@property (strong, nonatomic) IBOutlet UITextView *contactsField;
@property (strong, nonatomic) IBOutlet UIButton *emailButton;

- (IBAction)newEmailButton:(id)sender;

@end

NS_ASSUME_NONNULL_END
