//
//  LoginAndRegisterView.h
//  ekkk
//
//  Created by 卞 中杰 on 11-6-10.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoginAndRegisterViewDelegate <NSObject>

- (void)pushRegisterViewController;

@end
@interface LoginAndRegisterView : UIView <UITableViewDelegate, UITableViewDataSource> {
    UITableView *_tableView;
    id <LoginAndRegisterViewDelegate> delegate;
}
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, assign) id <LoginAndRegisterViewDelegate> delegate;
@end
