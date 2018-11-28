//
//  AddContactViewController.m
//  SocialEmail
//
//  Created by Tyler on 2018-11-27.
//  Copyright © 2018 Michelle and Tyler. All rights reserved.
//

#import "AddContactViewController.h"

@interface AddContactViewController ()

@end

@implementation AddContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/




- (IBAction)cancel:(id)sender {
}

- (IBAction)save:(id)sender {
    
    Contact *contact = [[Contact alloc] init];
    contact.name = self.nameTextField.text;
    contact.date = [NSDate date];
    //    contact.group = TODO, make function that returns the group picker
    
    [self.delegate addContactViewController:self didAddContact:contact];
    
}
@end
