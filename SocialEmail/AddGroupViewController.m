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
    
    // Connect picker data
    self.contactPicker.dataSource = self;
    self.contactPicker.delegate = self;
    
    // Connect table data
    self.contactTable.dataSource = self;
    self.contactTable.delegate = self;
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// Starts with empty table for contacts
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.selectedContacts count];
}

// Sets up the cells for each contact
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ContactCell" forIndexPath:indexPath];

    // Configure the cell...
    Contact *contact = (self.selectedContacts)[indexPath.row];

    // Set UILables
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:100];
    nameLabel.text = contact.name;

    return cell;
}


#pragma mark - Picker
// The number of columns of data
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.contacts.count;
}
// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.contacts[row] name];
}



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
    group.contacts = self.selectedContacts;
    
    [self.delegate addGroupViewController:self didAddGroup:group];
    [self dismissViewControllerAnimated:YES completion:nil];
}



// Creates a group object from input and passes it to delegate


- (IBAction)selectContact:(id)sender {
    
    Contact *contact = self.contacts[ [self.contactPicker selectedRowInComponent:0] ];
    
    [self.selectedContacts addObject:contact];
    [self.contactTable reloadData];
    
}


@end
