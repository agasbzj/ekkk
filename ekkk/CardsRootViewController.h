//
//  CardsRootViewController.h
//  ekkk
//
//  Created by Wu Jianjun on 11-4-3.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CardsRootViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    UITableView *_tableView;
    NSArray *_bankArray;
    NSDictionary *_plistKey;
}
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSArray *bankArray;
@property (nonatomic, retain) NSDictionary *plistKey;
@end
