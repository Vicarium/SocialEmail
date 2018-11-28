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
- (void)addContactViewController:(AddContactViewController *)controller didAddContact:(Contact *)contact toGroup:(Group *)group;
@end


@interface AddContactViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource>

- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;
- (IBAction)selectImage:(id)sender;


@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextField;
@property (weak, nonatomic) IBOutlet UIPickerView *groupPicker;
@property (weak, nonatomic) IBOutlet UIButton *imageButton;

@property (nonatomic, weak) id <AddContactViewControllerDelegate> delegate;

@property (nonatomic, strong) NSMutableArray *groups;
@property (nonatomic, strong) NSMutableArray *selectedGroups;
@property (nonatomic, strong) UIImage *contactImage;

@end


NS_ASSUME_NONNULL_END
