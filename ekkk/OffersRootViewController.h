//
//  OffersRootViewController.h
//  ekkk
//
//  Created by Wu Jianjun on 11-4-3.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageDownloader.h"
#import "TableCellDownloadReceiver.h"
@interface OffersRootViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>{
    UITableView *_tableView;
    UISegmentedControl *_segmentedControl;
    NSMutableArray *_dataArray;
    
    @private
    NSMutableDictionary *cellReceivers;
}

@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) IBOutlet UISegmentedControl *segmentedControl;
@property (nonatomic, retain) NSMutableArray *dataArray;

- (NSURL *)applicationDocumentsDirectory;
- (NSURL *)locationDataFilePath;
- (IBAction)switchCategory:(id)sender;
@end

