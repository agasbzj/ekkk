//
//  CategoryTableViewController.h
//  ekkk
//
//  Created by Wu Jianjun on 11-4-19.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NearbyTableViewController.h"
@class IndividualTableCell;

@interface CategoryTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    UITableView *_tableView;
    NSArray *_dataArray;
    IndividualTableCell *_individualTableCell;
    UINib *cellNib;
    UITableViewController *_tableViewController;
}

@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSArray *dataArray;
@property (nonatomic, retain) IndividualTableCell *individualTableCell;
@property (nonatomic, retain) UINib *cellNib;
@property (nonatomic, retain) UITableViewController *tableViewController;

@end
