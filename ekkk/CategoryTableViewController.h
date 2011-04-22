//
//  CategoryTableViewController.h
//  ekkk
//
//  Created by Wu Jianjun on 11-4-19.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IndividualTableCell;

@interface CategoryTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    NSArray *_dataArray;
    UITableView *_tableView;
}
@property (nonatomic, retain) NSArray *dataArray;
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@end

