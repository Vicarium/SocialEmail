//
//  TableViewController.m
//  SocialEmail
//
//  Created by Michelle Mushaninga on 2018-11-25.
//  Copyright © 2018 Michelle and Tyler. All rights reserved.
//

#import "TableViewController.h"
#import "GroupViewController.h"

@interface TableViewController ()

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.groups count];
}

// Sets up the cells for each group
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GroupCell" forIndexPath:indexPath];
    
    // Configure the cell...
    Group *group = (self.groups)[indexPath.row];
    
//    // Convert NSDate to string
//    NSDateFormatter* df = [[NSDateFormatter alloc]init];
//    [df setDateFormat:@"dd/MM/yyyy"];
//    NSString *result = [df stringFromDate:group.date];
//
//    UILabel *dateLabel = (UILabel *)[cell viewWithTag:101];
//    dateLabel.text = result;



    // Set UILables
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:100];
    nameLabel.text = group.name;
    
    return cell;
}


/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - AddGroupViewControllerDelegate

// Delegate method that handles closing is using modal view on cancel
- (void)addGroupViewControllerDidCancel:(AddGroupViewController *)controller
{
    [self.navigationController popViewControllerAnimated:YES ];

}


// Method that adds a group to the group array, saves the array to persistent storage and closes the modal view if applicable
- (void)addGroupViewController:(AddGroupViewController *)controller didAddGroup:(Group *)group
{
    // Adds group to array
    [self.groups addObject:group];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:([self.groups count] - 1) inSection:0];
    
    // Save to persistent storage
    [self saveEverything];
    
    // fancy animation
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    // Dismisses Modal view
    [controller dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - AddContactViewControllerDelegate

// Delegate method that handles closing is using modal view on cancel
- (void)addContactViewControllerDidCancel:(AddContactViewController *)controller
{
    [self.navigationController popViewControllerAnimated:YES ];
    
}


// Method that adds a group to the group array, saves the array to persistent storage and closes the modal view if applicable
- (void)addContactViewController:(AddContactViewController *)controller didAddContact:(Contact *)contact toGroup:(nonnull Group *)group
{
    // Adds contact to array
    [self.contacts addObject:contact];
    
    // Add contact to group
    [group.contacts addObject:contact];
    
    // save to persistent storage
    [self saveEverything];
    
    // Dismisses Modal view
    [controller dismissViewControllerAnimated:YES completion:nil];
}


// Seque method that performs the seque to new scene, selects the tapped group
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedGroup = (self.groups)[indexPath.row];
    [self performSegueWithIdentifier:@"groupDetail" sender:self];
}

#pragma mark - Navigation

 //In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"groupDetail"])
    {        
        GroupViewController *groupView = [segue destinationViewController];
        groupView.group = self.selectedGroup;
    }
    if([[segue identifier] isEqualToString:@"groupAdd"])
    {
        AddGroupViewController *addGroupView = [segue destinationViewController];
        addGroupView.contacts = self.contacts;
        addGroupView.selectedContacts = [NSMutableArray arrayWithCapacity:10];
        addGroupView.delegate = self;
    }
    if([[segue identifier] isEqualToString:@"contactAdd"])
    {
        AddContactViewController *addContactView = [segue destinationViewController];
        addContactView.groups = self.groups;
        addContactView.delegate = self;
    }
 
}

#pragma mark - Persistent Storage

// Save everything as a JSON file
- (void)saveEverything{
    
    NSMutableArray *groupDicts = [NSMutableArray arrayWithCapacity:20];
    
    // loop through groups, adding to dict
    Group * g;
    for (g in _groups){
        [groupDicts addObject:[g getGroupDictionary]];
    }

    NSData *json;
    NSError *error = nil;
    
    // Convert dictionary to json
    if ([NSJSONSerialization isValidJSONObject:groupDicts])
    {
        // Serialize the array
        json = [NSJSONSerialization dataWithJSONObject:groupDicts options:NSJSONWritingPrettyPrinted error:&error];
        
    }
    
    // Save JSON to documents
    // Use GCD's background queue
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
//        NSFileManager *filemgr = [NSFileManager defaultManager];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:@"GetConnectedData.json"];
        [json writeToFile:dataPath atomically:YES];
    });
    
}


@end
