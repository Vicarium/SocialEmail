//
//  AddContactViewController.h
//  SocialEmail
//
//  Created by Tyler on 2018-11-27.
//  Copyright © 2018 Michelle and Tyler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Group.h"
#import "Contact.h"


NS_ASSUME_NONNULL_BEGIN


@class AddContactViewController;

@protocol AddContactViewControllerDelegate <NSObject>
- (void)addContactViewControllerDidCancel:(AddContactViewController *)controller;
- (void)addContactViewController:(AddContactViewController *)controller didAddContact:(Contact *)contact;
@end


@interface AddContactViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

// No need for a cancel button, the navigation controller will handle it.
- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;


@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextField;

@property (nonatomic, weak) id <AddContactViewControllerDelegate> delegate;

@property (nonatomic, strong) NSMutableArray *contacts;
@property (nonatomic, strong) NSMutableArray *selectedContacts;

@end


NS_ASSUME_NONNULL_END
