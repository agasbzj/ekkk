//
//  ManagementRootViewController.h
//  ekkk
//
//  Created by 卞 中杰 on 11-4-23.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginAndRegisterView.h"

@interface ManagementRootViewController : UIViewController <UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource, LoginAndRegisterViewDelegate> {
    UITableView *_tableView;
}
- (IBAction)editMyCards:(id)sender;
- (IBAction)showMyCards:(id)sender;
@property (nonatomic, retain) IBOutlet UITableView *tableView;

- (void)login;
- (void)logout;
@end
