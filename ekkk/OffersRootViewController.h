//
//  OffersRootViewController.h
//  ekkk
//
//  Created by Wu Jianjun on 11-4-3.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface OffersRootViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>{
    UITableView *tableView;
}

@property (nonatomic, retain) IBOutlet UITableView *tableView;
- (NSURL *)applicationDocumentsDirectory;
- (NSURL *)locationDataFilePath;

@end
