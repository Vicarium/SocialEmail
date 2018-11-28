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


    // Load groups and contacts array from persistent storage - TODO
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *path = [ [paths objectAtIndex:0] stringByAppendingPathComponent:@"archive.dat"];
//    _groups = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    
    // Add initial groups and contacts if nothing was loaded
    if ([_groups count] < 1){
        _groups = [NSMutableArray arrayWithCapacity:20];
        _contacts = [NSMutableArray arrayWithCapacity:20];
        
        Group *group = [[Group alloc] init];
        group.name = @"Family";
        group.date = [NSDate date];
        group.contacts = [NSMutableArray arrayWithCapacity:10];

        Contact *contact = [[Contact alloc] init];
        contact.name = @"John";
        contact.notes = @"Just some guy";
        contact.email = @"4768testemail@gmail.com";
        contact.date = [NSDate date];
        
        [_contacts addObject:contact];
        [group.contacts addObject:contact];
        [_groups addObject:group];
        
        group = [[Group alloc] init];
        group.name = @"Coworkers";
        group.date = [NSDate date];
        group.contacts = [NSMutableArray arrayWithCapacity:10];

        contact = [[Contact alloc] init];
        contact.name = @"John2";
        contact.notes = @"Just some guy2";
        contact.email = @"4768testemail2@gmail.com";
        contact.date = [NSDate date];
        
        [_contacts addObject:contact];
        [group.contacts addObject:contact];
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

@end
