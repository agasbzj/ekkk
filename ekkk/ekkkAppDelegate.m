//
//  ekkkAppDelegate.m
//  ekkk
//
//  Created by Wu Jianjun on 11-4-3.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//
 
#import "ekkkAppDelegate.h"
#import "InterconnectWithServer.h"

@implementation ekkkAppDelegate


@synthesize window=_window;

@synthesize tabBarController=_tabBarController;

@synthesize managedObjectContext=__managedObjectContext;

@synthesize managedObjectModel=__managedObjectModel;

@synthesize persistentStoreCoordinator=__persistentStoreCoordinator;

@synthesize locationManager;
@synthesize interConnectOperationQueue;
@synthesize parsedItems = _parsedItems;
@synthesize interconnectOperation;

@synthesize offerNavController = _offerNavController;

- (NSURL *)locationDataFilePath {
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:kFileName];
    NSLog(@"%@", storeURL);
    return storeURL;
}

//写入解析完的数据
- (void)saveItems:(NSNotification *)items {
    
    //关闭状态栏小菊花
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    _parsedItems = [[items userInfo] objectForKey:@"Items"];
//    NSLog(@"%@", _parsedItems);
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"LocalXMLParsed" object:nil];
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ItemDetail" inManagedObjectContext:context];
    
    
    
    NSError *error;
    for (OneItem *oneItem in _parsedItems) {
        NSManagedObject *object = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
        [object setValue:oneItem.city forKey:@"city"];
        [object setValue:oneItem.area forKey:@"area"];
        [object setValue:oneItem.category_Coarse forKey:@"category_Coarse"];
        [object setValue:oneItem.category_Fine forKey:@"category_Fine"];
        [object setValue:oneItem.seller forKey:@"seller"];
        [object setValue:oneItem.telephone forKey:@"telephone"];
        [object setValue:oneItem.details forKey:@"details"];
        [object setValue:oneItem.address forKey:@"address"];
        [object setValue:oneItem.latitude forKey:@"latitude"];
        [object setValue:oneItem.longitude forKey:@"longitude"];
        [object setValue:oneItem.hot forKey:@"hot"];
        [object setValue:oneItem.comments_Service forKey:@"comments_Service"];
        [object setValue:oneItem.comments_General forKey:@"comments_General"];
        [object setValue:oneItem.comments_Enviroment forKey:@"comments_Enviroment"];
        [object setValue:oneItem.comments_Discount forKey:@"comments_Discount"];
//        [object setValue:oneItem.card_Bank forKey:@"card_Bank"];
        [context save:&error];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NewDataSaved" object:self];
    [interConnectOperationQueue release];
}



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //注册为观察者，用于接受新线程解析的数据。
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveItems:) name:@"LocalXMLParsed" object:nil];
    
   //开始定位
    [self startStandardUpdates];
    

    
    // Override point for customization after application launch.
    // Add the tab bar controller's current view as a subview of the window
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)startStandardUpdates
{
    // Create the location manager if this object does not
    // already have one.
    if (nil == locationManager)
        locationManager = [[CLLocationManager alloc] init];
    
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    // Set a movement threshold for new events.
    locationManager.distanceFilter = kCLHeadingFilterNone;
    
    [locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"latitude %+.6f, longitude %+.6f\n",
          newLocation.coordinate.latitude,
          newLocation.coordinate.longitude);
    // If it's a relatively recent event, turn off updates to save power
//    NSDate* eventDate = newLocation.timestamp;
//    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
//    if (abs(howRecent) < 15.0)
//    {
//        NSLog(@"latitude %+.6f, longitude %+.6f\n",
//              newLocation.coordinate.latitude,
//              newLocation.coordinate.longitude);
//    }
    // else skip the event and process the next one.
    [locationManager stopUpdatingLocation];

    
    NSMutableDictionary *ddd = [NSMutableDictionary dictionaryWithCapacity:2];
    NSNumber *lat = [NSNumber numberWithFloat:newLocation.coordinate.latitude];
    NSNumber *log = [NSNumber numberWithFloat:newLocation.coordinate.longitude];
    [ddd setValue:lat forKey:@"latitude"];
    [ddd setValue:log forKey:@"longitude"];
    [ddd writeToURL:[self locationDataFilePath] atomically:YES];
    
    
    //新建线程
    interConnectOperationQueue = [NSOperationQueue new];
    
    //定位完成开始和服务器交互
    interconnectOperation = [[[InterconnectWithServer alloc] initWithCoordinate:ddd] autorelease];
    [self.interConnectOperationQueue addOperation: interconnectOperation];
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    // The location "unknown" error simply means the manager is currently unable to get the location.
    // We can ignore this error for the scenario of getting a single location fix, because we already have a 
    // timeout that will stop the location manager to save power.
    NSLog(@"Error:%@", [error userInfo]);
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
    [self saveContext];
}

- (void)dealloc
{
    [_parsedItems release];
    [locationManager release];
    [interConnectOperationQueue release];
    [_window release];
    [__managedObjectContext release];
    [__managedObjectModel release];
    [__persistentStoreCoordinator release];
    [_tabBarController release];
    [super dealloc];
}

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

#pragma mark - Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext
{
    if (__managedObjectContext != nil)
    {
        return __managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil)
    {
        __managedObjectContext = [[NSManagedObjectContext alloc] init];
        [__managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return __managedObjectContext;
}

/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel
{
    if (__managedObjectModel != nil)
    {
        return __managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"ItemModel" withExtension:@"momd"];
    __managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];    
    return __managedObjectModel;
}

/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (__persistentStoreCoordinator != nil)
    {
        return __persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"ItemModel.sqlite"];
    
    NSError *error = nil;
    __persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![__persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error])
    {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter: 
         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return __persistentStoreCoordinator;
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil)
    {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])
        {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Application's Documents directory

/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


@end
