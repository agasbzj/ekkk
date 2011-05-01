//
//  BankSelectViewController.h
//  ekkk
//
//  Created by 卞 中杰 on 11-4-23.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardsSelectView.h"

@protocol UserCardsSelectedDelegate

- (void)userCardsSelected:(NSMutableArray *)userCards;

@end

@interface BankSelectViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, CardsSelectViewDelegate> {
    UITableView *_tableView;
    NSArray *_bankArray;
    NSMutableArray *_userArray; //本地用户已保存的卡片数据
    NSMutableArray *_readyToWriteArray; //用于新保存的用户所有卡的数组
    NSMutableDictionary *_currentBankDictionary;
    id <UserCardsSelectedDelegate> delegate;
}
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSArray *bankArray;
@property (nonatomic, retain) NSMutableArray *userArray;
@property (nonatomic, retain) NSMutableArray *readyToWriteArray;
@property (nonatomic, retain) NSMutableDictionary *currentBankDictionary;
@property (nonatomic, assign) id <UserCardsSelectedDelegate> delegate;
- (IBAction)ok:(id)sender;
- (IBAction)cancel:(id)sender;
@end
