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

- (IBAction)newEmailButton:(id)sender
{
    //composes view controller
    MFMailComposeViewController *composer = [[MFMailComposeViewController alloc] init];
    [composer setMailComposeDelegate:self];
    
    if ([MFMailComposeViewController canSendMail])
    {
        // Get contact email
        NSMutableArray *toAddresses = [NSMutableArray arrayWithCapacity:10];
        [toAddresses addObject:_contact.email];
        
        // Will get emails from group
        [composer setToRecipients:toAddresses];
        
        // Convert NSDate to string
        NSDateFormatter* df = [[NSDateFormatter alloc]init];
        [df setDateFormat:@"dd/MM/yyyy"];
        NSString *date = [df stringFromDate:self.contact.date];
        
        // Places group name and last data update date in subject
        [composer setSubject:[NSString stringWithFormat: @"%@ - Data last updated: %@", self.contact.name, date] ];
        
        // Save group data to a file for attachment
        NSData *attachment = [self.contact serializeAsJson];
        
        
        // Attaches group data file to the email
        [composer addAttachmentData:attachment
                           mimeType:@"json"
                           fileName:@"GetConnectedContactData.json"];
        
        [self presentViewController:composer animated:YES completion:nil];
    }
    
}

// Exit compose view on cancel
-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)Cancel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
    
@end
