//
//  AppDelegate.m
//  SocialEmail
//
//  Created by Tyler on 2018-11-20.
//  Copyright © 2018 Michelle and Tyler. All rights reserved.
//

#import "AppDelegate.h"
#import "Group.h"
#import "Contact.h"
#import "TableViewController.h"

@interface AppDelegate ()

@property (nonatomic, strong) IBOutlet TableViewController *tableViewController;
@property (nonatomic, strong) IBOutlet UINavigationController *navigationController;

@end

@implementation AppDelegate

NSMutableArray *_groups;
NSMutableArray *_contacts;



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    // Allocate mutable arrays for both groups and contacts
    _groups = [NSMutableArray arrayWithCapacity:20];
    _contacts = [NSMutableArray arrayWithCapacity:20];
    
    // Load data from persistent storage
    [self loadAllData];
    
    // Add initial groups and contacts if nothing was loaded
    if ([_groups count] < 1){

        
        Group *group = [[Group alloc] init];
        group.name = @"Family";
        group.date = [NSDate date];
        group.contacts = [NSMutableArray arrayWithCapacity:10];

        Contact *contact = [[Contact alloc] init];
        contact.name = @"John";
        contact.notes = @"Just some guy";
        contact.email = @"4768testemail1@gmail.com";
        contact.date = [NSDate date];
        [_contacts addObject:contact];
        [group.contacts addObject:contact];

        
        contact = [[Contact alloc] init];
        contact.name = @"Aunt Jemima";
        contact.notes = @"Makes the best pancakes.";
        contact.email = @"aunt-4768testemail2@gmail.com";
        contact.date = [NSDate date];
        [_contacts addObject:contact];
        [group.contacts addObject:contact];
        
        contact = [[Contact alloc] init];
        contact.name = @"Uncle Hickory";
        contact.notes = @"Makes the best cheese and sausage.";
        contact.email = @"uncle-4768testemail3@gmail.com";
        contact.date = [NSDate date];
        [_contacts addObject:contact];
        [group.contacts addObject:contact];
        
        contact = [[Contact alloc] init];
        contact.name = @"Mum";
        contact.notes = @"<3";
        contact.email = @"mum-4768testemail4@gmail.com";
        contact.date = [NSDate date];
        [_contacts addObject:contact];
        [group.contacts addObject:contact];

        
        [_groups addObject:group];
        
        group = [[Group alloc] init];
        group.name = @"Coworkers";
        group.date = [NSDate date];
        group.contacts = [NSMutableArray arrayWithCapacity:10];

        contact = [[Contact alloc] init];
        contact.name = @"Bossman";
        contact.notes = @"Must be defeated to get boss powerup.";
        contact.email = @"johntwo-4768testemail5@gmail.com";
        contact.date = [NSDate date];
        
        contact = [[Contact alloc] init];
        contact.name = @"Andrew from accounting";
        contact.notes = @"Techn illiterate.";
        contact.email = @"johntwo-4768testemail6@gmail.com";
        contact.date = [NSDate date];
        
        contact = [[Contact alloc] init];
        contact.name = @"John Two";
        contact.notes = @"Now theres another one.";
        contact.email = @"johntwo-4768testemail7@gmail.com";
        contact.date = [NSDate date];
        
        [_contacts addObject:contact];
        [group.contacts addObject:contact];
        [_groups addObject:group];

        
        group = [[Group alloc] init];
        group.name = @"Friends";
        group.date = [NSDate date];
        group.contacts = [NSMutableArray arrayWithCapacity:10];
        [_groups addObject:group];

        group = [[Group alloc] init];
        group.name = @"Aquaintances";
        group.date = [NSDate date];
        group.contacts = [NSMutableArray arrayWithCapacity:10];
        [_groups addObject:group];

        group = [[Group alloc] init];
        group.name = @"Adversaries";
        group.date = [NSDate date];
        group.contacts = [NSMutableArray arrayWithCapacity:10];
        [_groups addObject:group];
        
    }
    
    // Setup navigation controller
    self.navigationController = (UINavigationController *)self.window.rootViewController;
    
    // Add groups array to table view controller
    self.tableViewController = [self.navigationController viewControllers][0];
    self.tableViewController.groups = _groups;
    self.tableViewController.contacts = _contacts;

    return YES;
}


// Method for handling opening JSON files with app!
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    
    // Get all files in directory
    NSFileManager *filemgr = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString* inboxPath = [documentsDirectory stringByAppendingPathComponent:@"Inbox"];
    NSArray *dirFiles = [filemgr contentsOfDirectoryAtPath:inboxPath error:nil];
    
    
    // Get JSON File, convert to NSData, return NO if failure
    if ([dirFiles firstObject] == nil){return NO;}
    NSString *filePath = [NSString stringWithFormat:@"%@/%@", inboxPath, [dirFiles firstObject]];
    NSLog(@"Reading: %@",filePath);
    NSData *jsonData = [NSData dataWithContentsOfFile:filePath ];
    
    // Check if json has contact or group data
    BOOL isGroup = NO;
    if (([[dirFiles firstObject] rangeOfString:@"Contact"].location == NSNotFound)){
        isGroup = YES;
    }

    // Clean inbox of files
    NSLog(@"Cleaning Inbox");
    NSString *path;
    NSError *error = nil;
    for (path in dirFiles){
        [filemgr removeItemAtPath:[NSString stringWithFormat:@"%@/%@", inboxPath, path] error:&error];

    }

//    // Prompt user to update data using JSON file
//    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Update"
//                                                                   message:@"Updating local data..."
//                                                            preferredStyle:UIAlertControllerStyleAlert];
//
//    //Add Buttons
//    UIAlertAction* yesButton = [UIAlertAction
//                                actionWithTitle:@"Ok"
//                                style:UIAlertActionStyleDefault
//                                handler:^(UIAlertAction * action) {
//                                }];

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Update"
                                                    message:@"Updating local data was successful!"
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];

    // Update data
    [self updateDataFromJson:jsonData isGroupFile: isGroup];

    
//    [alert addAction:yesButton];
//    [self.tableViewController presentViewController:alert animated:YES completion:nil];
    
    
    return YES;
    
}

// Update the local data with json data
-(void)updateDataFromJson:(NSData *)json isGroupFile:(BOOL)isGroup {
    
    // Convert to dict
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:json options:kNilOptions error:nil];
    
    for(id key in dict)
        NSLog(@"key=%@ value=%@", key, [dict objectForKey:key]);

    // Update or create contact if single contact
    if (isGroup == NO){
        // Get or create contact
        Contact * contact;
        contact = [self getOrCreateContact:dict];
        
        // Check for update from dict and update if more recent
        [contact updateFromDict:dict];
    }
    else{
        // Update or create group
        NSString *name = [dict valueForKey:@"NAME"];
        NSString *n = @"name";
        NSPredicate *preda = [NSPredicate predicateWithFormat:@"%K == %@", n, name];
        NSArray *match = [self.tableViewController.groups filteredArrayUsingPredicate:preda];
        
        // Create new if no match
        if ([match firstObject] == nil){
                Group * group = [[Group alloc] initWithDict:dict];
            
                NSMutableDictionary * cont;
                for (cont in [dict valueForKey:@"CONTACTS"]){
                    [group.contacts addObject:[self getOrCreateContact:cont]];
                }
            
                [_groups addObject:group];
            
        }
        else{
            // Update matching
            Group *target = [match firstObject];
            [target updateFromDict:dict];
            
            // Check for existing contacts to update and create the rest
            NSMutableDictionary * cont;
            for (cont in [dict valueForKey:@"CONTACTS"]){
                NSString *email = [cont valueForKey:@"EMAIL"];
                NSString *e = @"email";
                NSPredicate *preda = [NSPredicate predicateWithFormat:@"%K == %@",e, email];
                NSArray *match = [_contacts filteredArrayUsingPredicate:preda];
                
                // Create if not match
                if ([match firstObject] == nil){
                    Contact * newContact = [[Contact alloc] initWithDict:dict];
                    [target.contacts addObject:newContact];
                    [self.tableViewController.contacts addObject:newContact];
                }
                else{
                    // Update if match
                    Contact *contact = [match firstObject];
                    [contact updateFromDict:cont];
                }
            }
            
            [_groups addObject:target];
        }
        
    }
    
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"SocialEmail"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}


#pragma mark - Load Data
- (void)loadAllData{

    // Get file path
    NSFileManager *filemgr = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:@"GetConnectedData.json"];
    
    // Get json data
    NSLog(@"Reading: %@",dataPath);
    NSData *jsonData = [NSData dataWithContentsOfFile:dataPath ];
    NSError *error = nil;
    NSDictionary  *groupDicts = [NSJSONSerialization
                             JSONObjectWithData:jsonData
                             options:0
                             error:&error];
    
    NSDictionary * dict;

    // Create Groups
    for (dict in groupDicts){
        Group * group = [[Group alloc] initWithDict:dict];
        
        NSMutableDictionary * cont;
        for (cont in [dict valueForKey:@"CONTACTS"]){
            [group.contacts addObject:[self getOrCreateContact:cont]];
        }
        
        [_groups addObject:group];
        
    }
    
    
}

// Etheir retrieve existing contact or create one
- (Contact *) getOrCreateContact:(NSDictionary*)dict{
    
    NSString *email = [dict valueForKey:@"EMAIL"];
    NSString *e = @"email";
    NSPredicate *preda = [NSPredicate predicateWithFormat:@"%K == %@",e, email];
    NSArray *match = [_contacts filteredArrayUsingPredicate:preda];
    
    // Create if not match
    if ([match firstObject] == nil){
        Contact * newContact = [[Contact alloc] initWithDict:dict];
        [_contacts addObject:newContact];
        return newContact;
    }
    else{
        // Return if match
        Contact *target = [match firstObject];
        return target;
    }
}


@end
