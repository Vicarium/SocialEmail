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
    
    self.groupNameLabel.text = _group.name;
    self.emailButton.layer.cornerRadius=5;
    
    _contactTable.delegate = self;
    _contactTable.dataSource = self;
    [_contactTable reloadData];
    
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
        

        NSMutableArray *toAddresses = [NSMutableArray arrayWithCapacity:10];

        Contact *item;
        
        for (item in self.group.contacts){
            
            [toAddresses addObject:item.email];

        }
        
        // Will get emails from group
        [composer setToRecipients:toAddresses];
        
        // Convert NSDate to string
        NSDateFormatter* df = [[NSDateFormatter alloc]init];
        [df setDateFormat:@"dd/MM/yyyy"];
        NSString *date = [df stringFromDate:self.group.date];
        
        // Places group name and last data update date in subject
        [composer setSubject:[NSString stringWithFormat: @"%@ - Data last updated: %@", self.group.name, date] ];
       
        // Save group data to a file for attachment
        NSData *attachment = [self.group serializeAsJson];
        
        
        // Attaches group data file to the email
        [composer addAttachmentData:attachment
                           mimeType:@"json"
                           fileName:@"GetConnectedGroupData.json"];
        
        [self presentViewController:composer animated:YES completion:nil];
        
    }
    
   /*
    // else not needed have another mail alert error set up
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
    */
}


// dismisses view for modal transition
- (IBAction)cancel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


#pragma mark - Table view data source



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.group.contacts count];

}

// Sets up the cells for each group
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ContactCell" forIndexPath:indexPath];

    // Configure the cell...
    Contact *contact = (self.group.contacts)[indexPath.row];

    // Set UILables
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:100];
    nameLabel.text = contact.name;

    // Set UIImage - TODO?
//    UIImageView *imageView = (UIImageView *)[cell viewWithTag:101];
//    imageView.image = contact.image;

    return cell;
}

// Seque method that performs the seque to new scene, selects the tapped contact
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedContact = (self.group.contacts)[indexPath.row];
    [self performSegueWithIdentifier:@"contactDetail" sender:self];
}

//In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if([[segue identifier] isEqualToString:@"contactDetail"])
    {
        ContactViewController *contactView = [segue destinationViewController];
        contactView.contact = self.selectedContact;
        contactView.delegate = self;
    }
    
}


- (void)contactViewControllerDidCancel:(ContactViewController *)controller{
    [controller dismissViewControllerAnimated:YES completion:nil];
}


@end
