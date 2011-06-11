//
//  ekkkAppDelegate.m
//  ekkk
//
//  Created by Wu Jianjun on 11-4-3.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//
 
#import "ekkkAppDelegate.h"
#import "InterconnectWithServer.h"

#define kLocationFileName @"location.plist"
#define kDataFileName @"Data.plist"
#define kUserCardsFileName @"UserCards.plist"

@implementation ekkkAppDelegate

@synthesize window=_window;
@synthesize tabBarController=_tabBarController;
@synthesize locationManager;
@synthesize interConnectOperationQueue;
@synthesize parsedItems = _parsedItems;
@synthesize interconnectOperation;
@synthesize offerNavController = _offerNavController;
@synthesize userCardsArray = _userCardsArray;

- (NSURL *)userCardsFilePath {
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:kUserCardsFileName];
    NSLog(@"%@", storeURL);
    return storeURL;
}

- (NSURL *)locationDataFilePath {
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:kLocationFileName];
    NSLog(@"%@", storeURL);
    return storeURL;
}

- (NSURL *)itemDataFilePath {
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:kDataFileName];
    NSLog(@"%@", storeURL);
    return storeURL;
}
- (void)loadData {
    [_parsedItems removeAllObjects];
    NSURL *url = [self itemDataFilePath];
    NSArray *tempArray = [[NSDictionary dictionaryWithContentsOfURL:url] valueForKey: @"data_Array"];
    
    for (NSDictionary *dic in tempArray) {
        OneItem *oneItem = [[OneItem alloc] init];
        oneItem.city = [dic valueForKey:@"city"];
        oneItem.area = [dic valueForKey:@"area"];
        oneItem.seller = [dic valueForKey:@"seller"];
        oneItem.image = [dic valueForKey:@"image"];
        oneItem.category_Fine = [dic valueForKey:@"category_Fine"];
        oneItem.category_Coarse = [dic valueForKey:@"category_Coarse"];
        oneItem.telephone = [dic valueForKey:@"telephone"];
        oneItem.address = [dic valueForKey:@"address"];
        oneItem.www_Address = [dic valueForKey:@"www_Address"];
        oneItem.latitude = [dic valueForKey:@"latitude"];
        oneItem.longitude = [dic valueForKey:@"longitude"];
        oneItem.details = [dic valueForKey:@"details"];
        oneItem.hot = [dic valueForKey:@"hot"];
        oneItem.comments_General = [dic valueForKey:@"comments_General"];
        oneItem.comments_Discount = [dic valueForKey:@"comments_Discount"];
        oneItem.comments_Service = [dic valueForKey:@"comments_Service"];
        oneItem.comments_Enviroment = [dic valueForKey:@"comments_Enviroment"];
        oneItem.bank = [dic valueForKey:@"bank"];
        oneItem.card = [dic valueForKey:@"card"];
        oneItem.source = [dic valueForKey:@"source"];
        oneItem.distance = [dic valueForKey:@"distance"];
        [_parsedItems addObject:oneItem];
        [oneItem release];
    }
    

}

//写入解析完的数据
- (void)loadItems:(NSNotification *)items {
    
    //关闭状态栏小菊花
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    

    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"LocalXMLParsed" object:nil];
    
   

    
    [self loadData];
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NewDataSaved" object:self];
    [interConnectOperationQueue release];
}



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    _parsedItems = [[NSMutableArray alloc] initWithCapacity:50];
//    _userCardsArray = [[NSMutableArray alloc] init];
    _userCardsArray = [[[NSDictionary dictionaryWithContentsOfURL:[self userCardsFilePath]] valueForKey:@"cards"] retain];
    
    [self loadData];
    //注册为观察者，用于接受新线程解析的数据。
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadItems:) name:@"LocalXMLParsed" object:nil];
    
    
    ////////////////////////////////////////////////////////////////////////////////////////
    //用于调试，删除之
    //新建线程
//    interConnectOperationQueue = [NSOperationQueue new];
//    
//    //定位完成开始和服务器交互
//    interconnectOperation = [[[InterconnectWithServer alloc] initWithCoordinate:nil] autorelease];
//    [self.interConnectOperationQueue addOperation: interconnectOperation];
    ////////////////////////////////////////////////////////////////////////////////////////
    
    
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
    locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    
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
//    [self saveContext];
}

- (void)dealloc
{
    [_userCardsArray release];
    [_parsedItems release];
    [locationManager release];
    [interConnectOperationQueue release];
    [_window release];
//    [__managedObjectContext release];
//    [__managedObjectModel release];
//    [__persistentStoreCoordinator release];
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


#pragma mark - Application's Documents directory

/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

#pragma mark - 
- (void)userCardsSelected:(NSMutableArray *)userCards {
    NSDictionary *dic = [NSDictionary dictionaryWithObject:userCards forKey:@"cards"];
    [dic writeToURL:[self userCardsFilePath] atomically:YES];
    //保存完数据要重新读取新数据
    _userCardsArray = nil;
    [_userCardsArray release];
    _userCardsArray = [[[NSDictionary dictionaryWithContentsOfURL:[self userCardsFilePath]] valueForKey:@"cards"] retain];
}

@end
