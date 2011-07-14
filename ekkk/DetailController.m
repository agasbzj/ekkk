//
//  DetailController.m
//  ekkk
//
//  Created by Wu Jianjun on 11-4-30.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "DetailController.h"
#import "DetailHeaderView.h"
#import "DetailFooterView.h"
#import "MapViewController.h"
#import "UserCommitViewController.h"
#import "DetailInfoTableCell.h"

@implementation DetailController
@synthesize tableView = _tableView;
@synthesize oneItem = _oneItem;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    }
    return self;
}

- (void)dealloc
{
    [_oneItem release];
    [_tableView release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

//实现点击显示地图按钮
- (IBAction)showMap:(id)sender {
    MapViewController *mapViewController = [[MapViewController alloc] init];
    mapViewController.theItem = _oneItem;
    [self.navigationController pushViewController:mapViewController animated:YES];
    [mapViewController release];
}

#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.tintColor = nil;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    self.navigationItem.title = _oneItem.seller;
    UIBarButtonItem *mapButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Map", @"Map") style:UIBarButtonItemStyleDone target:self action:@selector(showMap:)];
    self.navigationItem.rightBarButtonItem = mapButton;
    [mapButton release];
    
    DetailHeaderView *headerView;
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"DetailHeaderView" owner:self options:nil];
    headerView = [array objectAtIndex:0];
    headerView.backgroundColor = [UIColor clearColor];
    headerView.seller.text = _oneItem.seller;
    headerView.category_Fine.text = _oneItem.category_Fine;
    headerView.comments_Service.text = _oneItem.comments_Service;
    headerView.comments_General.text = _oneItem.comments_General;
    headerView.comments_Enviroment.text = _oneItem.comments_Enviroment;
    headerView.comments_Discount.text = _oneItem.comments_Discount;
    headerView.ratingView.rating = ([_oneItem.comments_General floatValue] <= 5 && [_oneItem.comments_General floatValue] >= 0) ? [_oneItem.comments_General floatValue] : 0;
    
    _tableView.tableHeaderView = headerView;
    
    
    
    CGSize _size = [_oneItem.details sizeWithFont:[UIFont systemFontOfSize:17]];
    int w = 300;
    int row = (int)_size.width / w + 1;
    int viewHeight = 45 + row * _size.height + 15 + 10 + 37 + 10;
    
    DetailFooterView *footerView = [[DetailFooterView alloc] initWithFrame:CGRectMake(0, 0, 320, viewHeight)];
    footerView.delegate = self;
    footerView.backgroundColor = [UIColor clearColor];
    footerView.detailString = _oneItem.details;
    [footerView configFooterView];
    
    
    _tableView.tableFooterView = footerView;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
}

#pragma mark - DetailFootView Delegate

- (void)shareButtonPressed
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", @"Cancel") destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"Share This Via Sina Weibo", @"Share This Via Sina Weibo"), NSLocalizedString(@"Share This Via Email", @"Share This Via Email"), NSLocalizedString(@"Share This Via Text Message", @"Share This Via Text Message"), nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    [actionSheet showInView:self.view];
    [actionSheet release];
}

- (void)commitButtonPressed {
    UserCommitViewController *commitViewController = [[UserCommitViewController alloc] initWithNibName:@"UserCommitViewController" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:commitViewController animated:YES];
    [commitViewController release];
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

#pragma mark - TableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    if ([[[_oneItem.bank objectAtIndex:0] valueForKey:@"bank_name"] isEqualToString:@""]) {
//        return 1;
//    }
    if ([_oneItem.bank count] == 0) {
        return 1;
    }
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 2;
            break;
        case 1:
            return [_oneItem.bank count];
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
    DetailInfoTableCell *cell = (DetailInfoTableCell *)[_tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
//        cell.backgroundColor = [UIColor clearColor];
//        if (section == 0) {
//            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier] autorelease];
            NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"DetailInfoTableCell" owner:self options:nil];
            cell = [array objectAtIndex:0];
            cell.icon.image = indexPath.row == 0 ? [UIImage imageNamed:@"VoIP-Alt.png"] : [UIImage imageNamed:@"Home.png"];
//        }
//        else if (section == 1) {
//            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier] autorelease];
//        }
    }
    
//    cell.textLabel.textColor = [UIColor colorWithRed:.4f green:.4f blue:.4f alpha:1.f];
//    cell.indentationLevel = 2;

    if (section == 0) {
        switch (row) {
            case 0:
            {
//                NSString *telText = [NSString stringWithFormat:@"%@%@", NSLocalizedString(@"Telephone:", @"Telephone:") , _oneItem.telephone];
                cell.typeLabel.text = NSLocalizedString(@"Telephone:", @"Telephone:");
                cell.detailLabel.text = _oneItem.telephone;
                break;
            }
            case 1:
            {
//                NSString *telText = [NSString stringWithFormat:@"%@%@", NSLocalizedString(@"Address:", @"Address:") , _oneItem.address];
                cell.typeLabel.text = NSLocalizedString(@"Address:", @"Address:");
                cell.detailLabel.text = _oneItem.address;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            default:
                break;
        }
        cell.detailTextLabel.numberOfLines = 2;
    }
    else if (section == 1) {
        cell.typeLabel.text = @"折扣：";
        cell.detailLabel.text = _oneItem.discount;
        cell.detailLabel.numberOfLines = 2;
        cell.icon.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", [_oneItem.bank objectAtIndex:row]]];
    }
    


    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0 && indexPath.row == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"拨打电话" message:[NSString stringWithFormat:@"您确定要拨打%@吗？", _oneItem.telephone] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
        [alert release];
    }
    if (indexPath.section == 0 && indexPath.row == 1) {
        [self showMap:nil];
    }
}

#pragma mark - Alert Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", _oneItem.telephone]]];
    }
}

#pragma mark - Mail Delegate
- (void)sendMail:(id)sender{

    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate = self;
    [picker setSubject:[NSString stringWithFormat:@"分享:%@", _oneItem.seller]];
    
    [picker setMessageBody:@"I found this great deal from ekkk.com" isHTML:NO];
    
    
    [self presentModalViewController:picker animated:YES];
    [picker release];
    
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error 
{	
    
	[self dismissModalViewControllerAnimated:YES];
}

#pragma mark - SMS sharing

- (void)displaySMS {
    NSString *message = [NSString stringWithFormat:@"Share:%@", _oneItem.seller];
    MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
    picker.messageComposeDelegate= self;
    picker.navigationBar.tintColor= [UIColor blackColor];
    picker.body = message; // 默认信息内容
    // 默认收件人(可多个)
    //picker.recipients = [NSArray arrayWithObject:@"12345678901", nil];
    [self presentModalViewController:picker animated:YES];
    [picker release];
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    
        
    [self dismissModalViewControllerAnimated:YES]; 
}

#pragma mark - ActionSheet Delegate 
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    NSLog(@"%d", buttonIndex);
    switch (buttonIndex) {
        case 0:
//          [self.view addSubview: sinaWeiboView];
            break;
        case 1:
            [self sendMail:nil];            
            break;
        case 2:
            [self displaySMS];
            break;
        default:
            break;
    }
}

@end
