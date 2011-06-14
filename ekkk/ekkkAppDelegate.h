//
//  ekkkAppDelegate.h
//  ekkk
//
//  Created by Wu Jianjun on 11-4-3.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "InterconnectWithServer.h"
#import "BankSelectViewController.h"

@interface ekkkAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate, 
                                        CLLocationManagerDelegate>
{

    CLLocationManager *locationManager;
    NSOperationQueue *interConnectOperationQueue;
    InterconnectWithServer *interconnectOperation;
    NSMutableArray *_parsedItems;   //存放解析完回传过来的新数据，其中每个元素为OneItem类
    UINavigationController *_offerNavController;
//    NSMutableArray *_userCardsArray;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;


@property (nonatomic, retain, readonly) NSOperationQueue *interConnectOperationQueue;
@property (nonatomic, retain) InterconnectWithServer *interconnectOperation;
@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain, readonly) NSMutableArray *parsedItems;
@property (nonatomic, retain) NSMutableArray *userCardsArray;
@property (nonatomic, retain) IBOutlet UINavigationController *offerNavController;


- (void)startStandardUpdates;
//- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
- (NSURL *)locationDataFilePath;
- (void)loadItems:(NSNotification *)itemList;
@end
