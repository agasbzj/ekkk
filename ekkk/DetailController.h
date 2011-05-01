//
//  DetailController.h
//  ekkk
//
//  Created by Wu Jianjun on 11-4-30.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OneItem.h"

@interface DetailController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    UITableView *_tableView;
    OneItem *_oneItem;
}
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) OneItem *oneItem;
@end