//
//  CardsSelectView.h
//  ekkk
//
//  Created by 卞 中杰 on 11-4-23.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CardsSelectView : UIView <UITableViewDataSource, UITableViewDelegate> {
    UITableView *tableView;
    NSArray *_cardsArray;
}
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSArray *cardsArray;

- (IBAction)ok:(id)sender;
- (IBAction)cancel:(id)sender;
@end
