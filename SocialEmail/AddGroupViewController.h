//
//  AddGroupViewController.h
//  SocialEmail
//
//  Created by Tyler on 2018-11-27.
//  Copyright © 2018 Michelle and Tyler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Group.h"
#import "Contact.h"


NS_ASSUME_NONNULL_BEGIN


@class AddGroupViewController;

@protocol AddGroupViewControllerDelegate <NSObject>
- (void)addGroupViewControllerDidCancel:(AddGroupViewController *)controller;
- (void)addGroupViewController:(AddGroupViewController *)controller didAddGroup:(Group *)group;
@end


@interface AddGroupViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

// No need for a cancel button, the navigation controller will handle it.
- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *addContactButton;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@property (nonatomic, weak) id <AddGroupViewControllerDelegate> delegate;

@property (nonatomic, strong) NSMutableArray *contacts;
@property (nonatomic, strong) NSMutableArray *selectedContacts;

@end


NS_ASSUME_NONNULL_END