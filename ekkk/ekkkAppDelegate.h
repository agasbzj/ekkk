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

@interface ekkkAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate>
{
    UINavigationController *_offerNavController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;



@property (nonatomic, retain) IBOutlet UINavigationController *offerNavController;



@end
