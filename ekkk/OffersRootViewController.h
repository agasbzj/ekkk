//
//  OffersRootViewController.h
//  ekkk
//
//  Created by Wu Jianjun on 11-4-3.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FetchDataController.h"

@interface OffersRootViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>{
    UITableView *_tableView;
    NSArray *_dataArray;

}

@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSArray *dataArray;
//@property (nonatomic, retain) FetchDataController *fetchDataController;
- (NSURL *)applicationDocumentsDirectory;
- (NSURL *)locationDataFilePath;

@end

/*
#import <UIKit/UIKit.h>

@class DetailViewController;

@interface OffersRootViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>{
@private
    DetailViewController *detailController;
    NSFetchedResultsController *fetchedResultsController;
    NSManagedObjectContext *managedObjectContext;
    
    UITableView *tableView;
    UISegmentedControl *fetchSectioningControl;
}

@property (nonatomic, retain, readonly) DetailViewController *detailController;
@property (nonatomic, retain, readonly) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) IBOutlet UISegmentedControl *fetchSectioningControl;

- (IBAction)changeFetchSectioning:(id)sender;

- (NSURL *)applicationDocumentsDirectory;
- (NSURL *)locationDataFilePath;

- (void)fetch;

@end

*/