//
//  ContactViewController.h
//  SocialEmail
//
//  Created by Tyler on 2018-11-28.
//  Copyright © 2018 Michelle and Tyler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contact.h"

NS_ASSUME_NONNULL_BEGIN

@class ContactViewController;


@protocol ContactViewControllerDelegate <NSObject>
- (void)contactViewControllerDidCancel:(ContactViewController *)controller;
@end

@interface ContactViewController : UIViewController

// Contact object from tapped cell
@property (nonatomic, strong) Contact *contact;
@property (nonatomic, weak) id <ContactViewControllerDelegate> delegate;

@property (nonatomic, strong) NSMutableArray *contacts;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextField;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;



@end

NS_ASSUME_NONNULL_END
