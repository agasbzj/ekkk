//
//  ekkkAppDelegate.m
//  ekkk
//
//  Created by Wu Jianjun on 11-4-3.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//
 
#import "ekkkAppDelegate.h"
#import "InterconnectWithServer.h"
#import "LocateAndDownload.h"

#define kLocationFileName @"location.plist"
#define kDataFileName @"Data.plist"
#define kUserCardsFileName @"UserCards.plist"

@implementation ekkkAppDelegate

@synthesize window=_window;
@synthesize tabBarController=_tabBarController;

@synthesize offerNavController = _offerNavController;

static LocateAndDownload *kLAndD = nil;

- (void)changeBadge {
    [[[_tabBarController.viewControllers objectAtIndex:0] tabBarItem] setBadgeValue:[NSString stringWithFormat:@"%d", [[[ekkkManager sharedManager] parsedItems] count]]];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    /*
    _parsedItems = [[NSMutableArray alloc] initWithCapacity:50];
    
    [ekkkManager sharedManager];
    
    [self loadData];
    //注册为观察者，用于接受新线程解析的数据。
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadItems:) name:@"LocalXMLParsed" object:nil];
    
   //开始定位
    [self startStandardUpdates];
    */
//    [[[[self.tabBarController viewControllers] objectAtIndex:1] tabBarItem] setBadgeValue:@"New"];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeBadge) name:@"NewDataSaved" object:nil];
    LocateAndDownload *locate = [[LocateAndDownload alloc] init];
    [locate loadDataWithParsedItems:nil];
    [locate startStandardUpdates];
    kLAndD = locate;
    
    // Override point for customization after application launch.
    // Add the tab bar controller's current view as a subview of the window
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    return YES;
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
    [kLAndD release];
    [_window release];
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





@end
