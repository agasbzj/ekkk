//
//  ManagementRootViewController.m
//  ekkk
//
//  Created by 卞 中杰 on 11-4-23.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "ManagementRootViewController.h"
#import "BankSelectViewController.h"
#import "ekkkAppDelegate.h"
#import "ShowMyCardsViewController.h"
#import "RegisterViewController.h"

@implementation ManagementRootViewController
@synthesize tableView = _tableView;

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

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
    ekkkAppDelegate *ekkkDele = (ekkkAppDelegate *)[[UIApplication sharedApplication] delegate];

    bankSelectViewController.delegate = ekkkDele;
    
    //已保存的数据复制一份来进行修改
    bankSelectViewController.userArray = ekkkDele.userCardsArray;
    bankSelectViewController.readyToWriteArray = [[NSMutableArray alloc] initWithArray:bankSelectViewController.userArray copyItems:YES];
    [self presentModalViewController:bankSelectViewController animated:YES];
    [bankSelectViewController release];
}

- (IBAction)showMyCards:(id)sender {
    ShowMyCardsViewController *showController = [[ShowMyCardsViewController alloc] init];
    ekkkAppDelegate *ekkkDele = (ekkkAppDelegate *)[[UIApplication sharedApplication] delegate];
    showController.dataArray = ekkkDele.userCardsArray;
    [self presentModalViewController:showController animated:YES];
    [showController release];
}

#pragma mark - tableView Delegate
#pragma mark - TableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 2;
            break;
        case 1:
            return 1;
            break;
        case 2:
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
//        if (section == 0) {
//            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
//            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        }
//        else if (section == 1) {
//            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
//        }
//        else if (section == 2) {
//            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
//        }
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    if (section == 0) {
        switch (row) {
            case 0:
                break;
            case 1:
                break;
            default:
                break;
        }

    }
    else if (section == 1) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
        cell.textLabel.text = @"创建新帐户";
       cell.textLabel.textAlignment = UITextAlignmentLeft;
        UIFont *font = [UIFont systemFontOfSize:14];
        cell.textLabel.font = font;
        
    }
    else if (section == 2) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
            return @"用户登录：";
            break;
        case 1:
            return @"用户注册：";
            break;
        case 2:
            return @"卡片管理：";
            break;
        default:
            return nil;
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
//        [_tableView deselectRowAtIndexPath:indexPath animated:YES];

    }
    
    if (indexPath.section == 1) {
        RegisterViewController *registerViewController = [[RegisterViewController alloc] initWithStyle:UITableViewStyleGrouped];
        registerViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:registerViewController animated:YES];
        [registerViewController release];
    }
    if (indexPath.section == 2) {
        switch (indexPath.row) {
            case 0:
            {
                BankSelectViewController *bankSetViewController = [[BankSelectViewController alloc] init];
                bankSetViewController.hidesBottomBarWhenPushed = YES;
                ekkkAppDelegate *ekkkDele = (ekkkAppDelegate *)[[UIApplication sharedApplication] delegate];
                
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
                ekkkAppDelegate *ekkkDele = (ekkkAppDelegate *)[[UIApplication sharedApplication] delegate];
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

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return YES;
    }
    else return NO;
}

@end
