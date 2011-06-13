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

@implementation DetailController
@synthesize tableView = _tableView;
@synthesize oneItem = _oneItem;

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.navigationItem.title = _oneItem.seller;
    UIBarButtonItem *mapButton = [[UIBarButtonItem alloc] initWithTitle:@"地图" style:UIBarButtonItemStyleDone target:self action:@selector(showMap:)];
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
    
    
    
    
    
    NSArray *array2 = [[NSBundle mainBundle] loadNibNamed:@"DetailFooterView" owner:self options:nil];
    DetailFooterView *footerView;
    footerView = [array2 objectAtIndex:0];
    footerView.delegate = self;
    footerView.backgroundColor = [UIColor clearColor];
    footerView.textView.text = _oneItem.details;
    footerView.textView.backgroundColor = [UIColor colorWithRed:0.945 green:0.945 blue:0.945 alpha:.5f];
    footerView.textView.layer.cornerRadius = 5.f;
    
    footerView.label.layer.cornerRadius = 10.f;
    footerView.leftButton.layer.cornerRadius = 10.f;
    footerView.rightButton.layer.cornerRadius = 10.f;
    
    _tableView.tableFooterView = footerView;
    
    
    
}
- (void)shareButtonPressed
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消分享" destructiveButtonTitle:nil otherButtonTitles:@"通过新浪微博分享", @"通过Email分享", @"通过短信分享", nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    [actionSheet showInView:self.view];
    [actionSheet release];
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
    if ([[[_oneItem.bank objectAtIndex:0] valueForKey:@"bank_name"] isEqualToString:@""]) {
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
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        if (section == 0) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            cell.imageView.image = indexPath.row == 0 ? [UIImage imageNamed:@"VoIP-Alt.png"] : [UIImage imageNamed:@"Home.png"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        else if (section == 1) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        }
    }
    
    if (section == 0) {
        switch (row) {
            case 0:
            {
                NSString *telText = [NSString stringWithFormat:@"电话：%@", _oneItem.telephone];
                cell.textLabel.text = telText;
//                cell.detailTextLabel.text = _oneItem.telephone;
                break;
            }
            case 1:
            {
                NSString *telText = [NSString stringWithFormat:@"地址：%@", _oneItem.address];
                cell.textLabel.text = telText;
//                cell.detailTextLabel.text = _oneItem.address;
            }
            default:
                break;
        }
        UIFont *font = [UIFont systemFontOfSize:14];
        cell.detailTextLabel.font = font;
        cell.textLabel.font = font;
//        cell.textLabel.numberOfLines = 2;
        cell.detailTextLabel.numberOfLines = 2;
    }
    else if (section == 1) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = [[_oneItem.bank objectAtIndex:row] valueForKey:@"discount"];
        cell.textLabel.numberOfLines = 2;
        cell.textLabel.textAlignment = UITextAlignmentCenter;
        UIFont *font = [UIFont systemFontOfSize:14];
        cell.textLabel.font = font;

        cell.textLabel.textColor = [UIColor orangeColor];
        cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", [[_oneItem.bank objectAtIndex:row] valueForKey:@"bank_name"]]];

    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 1) {
        [_tableView deselectRowAtIndexPath:indexPath animated:YES];
        [self showMap:nil];
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
    
    NSString*msg;
    
    NSLog(@"发送结果：%@", msg);
    
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
