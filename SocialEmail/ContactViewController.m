//
//  ContactViewController.m
//  SocialEmail
//
//  Created by Tyler on 2018-11-28.
//  Copyright © 2018 Michelle and Tyler. All rights reserved.
//

#import "ContactViewController.h"

@interface ContactViewController ()

@end

@implementation ContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageView.image = self.contact.image;
    self.nameLabel.text = self.contact.name;
    self.emailLabel.text = self.contact.email;
    self.descriptionTextField.text = self.contact.notes;
    
}

// dismisses view for modal transition
- (IBAction)cancel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
