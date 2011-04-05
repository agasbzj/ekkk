//
//  ekkkAppDelegate.h
//  ekkk
//
//  Created by Wu Jianjun on 11-4-3.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocateOperation.h"
@interface ekkkAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {

    NSOperationQueue *locateAndParseQueue; 

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;


@property (nonatomic, retain) NSOperationQueue *locateAndParseQueue;


- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
@end
