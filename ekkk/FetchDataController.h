//
//  FetchDataController.h
//  ekkk
//
//  Created by 卞 中杰 on 11-4-10.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "ekkkAppDelegate.h"

@interface FetchDataController : NSObject <NSFetchedResultsControllerDelegate>{
    NSMutableArray *_itemList;
}
@property (nonatomic, retain) NSMutableArray *itemList;

@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

- (void)saveContext;
- (void)getDataByKey:(NSString *)key isEqualToValue:(id)value;
@end
