//
//  ShowMyCardsViewController.h
//  ekkk
//
//  Created by 卞 中杰 on 11-5-1.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ShowMyCardsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    UITableView *tableView;
    NSArray *_dataArray;
}
@property (nonatomic, retain) NSArray *dataArray;
@property (nonatomic, retain) IBOutlet UITableView *tableView;
- (IBAction)goBack:(id)sender;
@end
