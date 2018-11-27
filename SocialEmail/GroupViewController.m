//
//  GroupViewController.m
//  SocialEmail
//
//  Created by Michelle Mushaninga on 2018-11-25.
//  Copyright © 2018 Michelle and Tyler. All rights reserved.
//

#import "GroupViewController.h"

@interface GroupViewController ()

@end

@implementation GroupViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.emailButton.layer.cornerRadius=5;
    
    

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)newEmailButton:(id)sender
{
    //composes view controller
    MFMailComposeViewController *composer = [[MFMailComposeViewController alloc] init];
    [composer setMailComposeDelegate:self];
    
    if ([MFMailComposeViewController canSendMail])
    {
        //will get emails from group
        [composer setToRecipients:NULL];
        
        [composer setSubject:@"New Group Email"];
       
        [self presentViewController:composer animated:YES completion:nil];
        
    }
    
    else
    {
        
        // sets up an alert to notify the user without email accounts set up on their phone
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"ERROR: CANNOT SENT EMAIL" message:@"You don't have an email acccount setup on your phone" preferredStyle:UIAlertControllerStyleAlert];
        
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            [alert dismissViewControllerAnimated:YES completion:nil];
            
        }];
        
        [alert addAction:cancel];
        
        //Presents alert to viewer
        [self presentViewController:alert animated:YES completion:nil];
        
        
    }
    
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
