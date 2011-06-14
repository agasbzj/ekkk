//
//  ManagementRootViewController.m
//  ekkk
//
//  Created by 卞 中杰 on 11-4-23.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "ManagementRootViewController.h"
#import "BankSelectViewController.h"
#import "ekkkManager.h"
#import "ShowMyCardsViewController.h"
#import "RegisterViewController.h"
#import "UserInfoView.h"

@implementation ManagementRootViewController
@synthesize tableView = _tableView;

static UIBarButtonItem *loginAndOutButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [_tableView release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}



- (void)login {
    UserInfoView *userInfoView = [[UserInfoView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
    userInfoView.alpha = 0.f;
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:.5f];
    [self.tableView setTableHeaderView:userInfoView];
    userInfoView.alpha = 1.f;
    [loginAndOutButton setTitle:@"登出"];
    [loginAndOutButton setAction:@selector(logout)];
    [UIView commitAnimations];
    
    [userInfoView release];
}

- (void)logout {
    LoginAndRegisterView *loginView = [[LoginAndRegisterView alloc] initWithFrame:CGRectMake(0, 0, 320, 240)];
    loginView.delegate = self;
    loginView.alpha = 0.f;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:.5f];
    [self.tableView setTableHeaderView:loginView];
    loginView.alpha = 1.f;
    [loginAndOutButton setTitle:@"登录"];
    [loginAndOutButton setAction:@selector(login)];
    [UIView commitAnimations];
    
    [loginView release];

}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    LoginAndRegisterView *loginView = [[LoginAndRegisterView alloc] initWithFrame:CGRectMake(0, 0, 320, 240)];
    loginView.delegate = self;
    [self.tableView setTableHeaderView:loginView];
    [loginView release];
    
    UIBarButtonItem *loginButton = [[UIBarButtonItem alloc] initWithTitle:@"登录" style:UIBarButtonItemStyleBordered target:self action:@selector(login)];
    loginAndOutButton = loginButton;
    self.navigationItem.rightBarButtonItem = loginButton;
    [loginButton release];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



- (IBAction)editMyCards:(id)sender {
    BankSelectViewController *bankSelectViewController = [[BankSelectViewController alloc] init];
    ekkkManager *ekkkDele = [ekkkManager sharedManager];

    bankSelectViewController.delegate = ekkkDele;
    
    //已保存的数据复制一份来进行修改
    bankSelectViewController.userArray = [ekkkManager sharedManager].userCardsArray;
    bankSelectViewController.readyToWriteArray = [[NSMutableArray alloc] initWithArray:bankSelectViewController.userArray copyItems:YES];
    [self presentModalViewController:bankSelectViewController animated:YES];
    [bankSelectViewController release];
}

- (IBAction)showMyCards:(id)sender {
    ShowMyCardsViewController *showController = [[ShowMyCardsViewController alloc] init];
    showController.dataArray = [ekkkManager sharedManager].userCardsArray;
    [self presentModalViewController:showController animated:YES];
    [showController release];
}

#pragma mark - tableView Delegate
#pragma mark - TableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 2;
            break;

        default:
            return 0;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger section = [indexPath section];
    NSUInteger row = [indexPath row];
    
    static NSString *CellIdentifier = @"CellIdentifer";
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    if (section == 0) {
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.textAlignment = UITextAlignmentLeft;
        UIFont *font = [UIFont systemFontOfSize:14];
        cell.textLabel.font = font;
        switch (row) {
            case 0:
                cell.textLabel.text = @"设置我的卡片";
                break;
            case 1:
                cell.textLabel.text = @"显示我的卡片";
                
            default:
                break;
        }

    }


    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"卡片管理：";
            break;

        default:
            return nil;
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
        switch (indexPath.row) {
            case 0:
            {
                BankSelectViewController *bankSetViewController = [[BankSelectViewController alloc] init];
                bankSetViewController.hidesBottomBarWhenPushed = YES;
                ekkkManager *ekkkDele = [ekkkManager sharedManager];
                
                bankSetViewController.delegate = ekkkDele;
                
                //已保存的数据复制一份来进行修改
                bankSetViewController.userArray = ekkkDele.userCardsArray;
                bankSetViewController.readyToWriteArray = [[NSMutableArray alloc] initWithArray:bankSetViewController.userArray copyItems:YES];
                [self.navigationController pushViewController:bankSetViewController animated:YES];
                [bankSetViewController release];
                break;
            }
            case 1:
            {
                ShowMyCardsViewController *showCardsController = [[ShowMyCardsViewController alloc] init];
                showCardsController.hidesBottomBarWhenPushed = YES;
                ekkkManager *ekkkDele = [ekkkManager sharedManager];
                showCardsController.dataArray = ekkkDele.userCardsArray;
                [self.navigationController pushViewController:showCardsController animated:YES];
                [showCardsController release];
                break;
            }
            default:
                break;
        }
    
            
    }
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];

}


#pragma mark - 
- (void)pushRegisterViewController {
    RegisterViewController *registerViewController = [[RegisterViewController alloc] initWithStyle:UITableViewStyleGrouped];
    registerViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:registerViewController animated:YES];
    [registerViewController release];
}

@end
