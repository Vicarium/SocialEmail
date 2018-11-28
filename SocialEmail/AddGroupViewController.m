//
//  AddGroupViewController.m
//  SocialEmail
//
//  Created by Tyler on 2018-11-27.
//  Copyright © 2018 Michelle and Tyler. All rights reserved.
//

#import "AddGroupViewController.h"
#import "Group.h"
#import "Contact.h"


@interface AddGroupViewController ()

@end

@implementation AddGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Fill table with list of contacts - TODO
    
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 1;
//}
//
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return [self.toys count];
//}
//
//// Sets up the cells for each toy
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ToyCell" forIndexPath:indexPath];
//
//    // Configure the cell...
//    Toy *toy = (self.toys)[indexPath.row];
//
//    // Convert NSDate to string
//    NSDateFormatter* df = [[NSDateFormatter alloc]init];
//    [df setDateFormat:@"dd/MM/yyyy"];
//    NSString *result = [df stringFromDate:toy.date];
//
//    // Set UILables
//    UILabel *nameLabel = (UILabel *)[cell viewWithTag:100];
//    nameLabel.text = toy.name;
//
//    UILabel *dateLabel = (UILabel *)[cell viewWithTag:101];
//    dateLabel.text = result;
//
//    UILabel *priceLabel = (UILabel *)[cell viewWithTag:102];
//    priceLabel.text = toy.price;
//
//    // Set UIImage
//    UIImageView *imageView = (UIImageView *)[cell viewWithTag:103];
//    imageView.image = toy.image;
//
//    return cell;
//}



// Calls delegate method to exit modal view
// Just here in case we make this modal
- (IBAction)cancel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save:(id)sender
{
    Group *group = [[Group alloc] init];
    group.name = self.nameTextField.text;
    group.date = [NSDate date];
    //    group.contacts = TODO, make function that returns the contacts from selected cells
    
    [self.delegate addGroupViewController:self didAddGroup:group];
    [self dismissViewControllerAnimated:YES completion:nil];
}



// Creates a group object from input and passes it to delegate


- (IBAction)selectContact:(id)sender {
}


@end
