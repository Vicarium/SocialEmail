//
//  ContactViewController.h
//  SocialEmail
//
//  Created by Tyler on 2018-11-28.
//  Copyright © 2018 Michelle and Tyler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Accounts/Accounts.h>
#import <MessageUI/MessageUI.h>
#import "Group.h"
#import "Contact.h"
#import "ContactViewController.h"


NS_ASSUME_NONNULL_BEGIN

@class ContactViewController;


@protocol ContactViewControllerDelegate <NSObject>
- (void)contactViewControllerDidCancel:(ContactViewController *)controller;
@end

@interface ContactViewController : UIViewController<MFMailComposeViewControllerDelegate>

// Contact object from tapped cell
@property (nonatomic, strong) Contact *contact;
@property (nonatomic, weak) id <ContactViewControllerDelegate> delegate;

@property (nonatomic, strong) NSMutableArray *contacts;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextField;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)newEmailButton:(id)sender;
- (IBAction)Cancel:(id)sender;



@end

NS_ASSUME_NONNULL_END
