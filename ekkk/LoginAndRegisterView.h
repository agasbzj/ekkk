//
//  LoginAndRegisterView.h
//  ekkk
//
//  Created by 卞 中杰 on 11-6-10.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoginAndRegisterViewDelegate <NSObject>

- (void)pushRegisterViewController; //注册

@end
@interface LoginAndRegisterView : UIView <UITableViewDelegate, UITableViewDataSource> {
    UITableView *_tableView;
    id <LoginAndRegisterViewDelegate> delegate;
    UITextField *_userTextField;
    UITextField *_passTextField;
}
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, assign) id <LoginAndRegisterViewDelegate> delegate;
@property (nonatomic, retain) UITextField *userTextField;
@property (nonatomic, retain) UITextField *passTextField;
@end
