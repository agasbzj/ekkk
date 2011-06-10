//
//  CardsSelectView.h
//  ekkk
//
//  Created by 卞 中杰 on 11-4-23.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

//用户设置选择银行卡界面


#import <UIKit/UIKit.h>

@protocol CardsSelectViewDelegate

- (void)cardsSelected:(NSMutableArray *)cardsSelectedArray isCancel:(BOOL)isCancel;

@end
@interface CardsSelectView : UIView <UITableViewDataSource, UITableViewDelegate> {
    UITableView *tableView;
    NSArray *_cardsArray;
    NSMutableArray *_selectedCards;
    id <CardsSelectViewDelegate> delegate;
}
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSArray *cardsArray;
@property (nonatomic, retain) NSMutableArray *selectedCards;
@property (nonatomic, assign) id <CardsSelectViewDelegate> delegate;
- (IBAction)ok:(id)sender;
- (IBAction)cancel:(id)sender;
@end
