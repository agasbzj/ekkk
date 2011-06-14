//
//  CategoryTableViewController.m
//  ekkk
//
//  Created by Wu Jianjun on 11-4-19.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "CategoryTableViewController.h"
#import "DetailController.h"
#import "OneItem.h"
#import "IndividualTableCell.h"
#import "MapViewController.h"
#import "ekkkAppDelegate.h"
#import "PlaceSelectViewController.h"

#define ChangePlaceTag  1
#define CategoryTag     2
#define DistanceTag     3
#define BankTag         4

@implementation CategoryTableViewController

@synthesize dataArray = _dataArray;
@synthesize tableView = _tableView;
@synthesize bankButton = _bankButton;
@synthesize showArray = _showArray;
@synthesize picker = _picker;
@synthesize pickerArray = _pickerArray;

@synthesize categoryArray = _categoryArray, distanceArray = _distanceArray, bankArray = _bankArray;
@synthesize categoryButton = _categoryButton;
@synthesize distanceButton = _distanceButton;
@synthesize placeButton = _placeButton;
@synthesize sortKeyDictionary = _sortKeyDictionary;

static NSUInteger choosenTag = 0;   //点了哪个查询分类
//static bool pickerOpen = NO;    //是否已经打开了一个picker
static UIActionSheet *kActionSheet;
static UIPickerView *kPicker;

//static NSString *kByCategory = @"all";  //风味筛选字段
//static NSString *kByRange = @"all";     //距离筛选字段
//static NSString *kBankKey = @"all";     //银行字段
static UIBarButtonItem *kMapButton = nil;
static UISegmentedControl *kSegmentedControl = nil; //切换控制 

- (void)dealloc
{
    [_categoryArray release];
    [_distanceArray release];
    [_bankButton release];
    [_picker release];
    [_showArray release];
    [_dataArray release];
    [_pickerArray release];
    [_categoryButton release];
    [_distanceButton release];
    [_sortKeyDictionary release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

//配置选取器用的各个array
- (void)configPickerArray {
    [_categoryArray removeAllObjects];
//    [_distanceArray removeAllObjects];
    
    NSInteger flag = 0;
    NSString *str;

    
    for (OneItem *item in _dataArray) {
        str = item.category_Fine;
        for (NSString *s in _categoryArray) {
            if (s && [s isEqualToString:str] == YES) {
                flag = 1;
                break;
            }
        }
        if (flag == 0) {
            [_categoryArray addObject:item.category_Fine];
        }
        flag = 0;
    }
    flag = 0;
    str = nil;
    
    for (OneItem *item in _dataArray) {
        for (NSDictionary *dic in item.bank) {
            str = [dic valueForKey:@"bank_name"];
            for (NSString *s in _bankArray) {
                if ([s isEqualToString:str] == YES) {
                    flag = 1;
                    break;
                }
            }
            if (flag == 0) {
                [_bankArray addObject:str];
            }
            flag = 0;
        }

    }
    
    
}

//实现点击显示地图按钮，于地图上显示当前页面所有标记
- (IBAction)showMap:(id)sender {
    
    MapViewController *mapViewController = [[MapViewController alloc] init];
    mapViewController.showMultiItems = YES;
    mapViewController.itemAnnotations = _showArray;
    [self.navigationController pushViewController:mapViewController animated:YES];
    [mapViewController release];
}
- (void)getMyCardsData 
{
    
    ekkkAppDelegate *ekkkDelegate = (ekkkAppDelegate *)[[UIApplication sharedApplication] delegate];
//    NSArray *allData = [[NSArray alloc] initWithArray:_showArray];    //所有附近item数组
    NSArray *myCards = ekkkDelegate.userCardsArray; //我的卡数组
//    _showArray = [[NSMutableArray alloc] initWithCapacity:30];
    NSMutableArray *allMyCards = [[[NSMutableArray alloc] initWithCapacity:10] autorelease];
    
    //所有用户的卡，每一项是string
    for (NSDictionary *dic in myCards)
    {
        [allMyCards addObjectsFromArray:[dic valueForKey:@"cards"]];
    }
    
    int i = 0, flag = 0;
    while (i < [_showArray count]) 
    {
        OneItem *item = [_showArray objectAtIndex:i];
        for (NSDictionary *bankDic in item.bank) 
        {
            NSString *bankName = [bankDic valueForKey:@"bank_name"];
            for (NSDictionary *dic in myCards) {
                NSString *str2 = [dic valueForKey:@"bank_name"];
                if ([bankName isEqualToString:str2]) {
                    flag = 1;
                }
            }

        }
        if (!flag) {
            [_showArray removeObject:item];    
            continue;
        }
        flag = 0;
        i++;
    }
    
    //没有结果的话，禁用“地图”按钮，否则启用“地图”按钮
    kMapButton.enabled = [_showArray count] > 0 ? YES : NO;
    [self.tableView reloadData];
}

- (void)switchCards:(id)sender {
    UISegmentedControl *seg = (UISegmentedControl *)sender;
    switch (seg.selectedSegmentIndex) {
        case 0:
            [self sortTableViewWithCategory];
            break;
        case 1:
            [self getMyCardsData];
            break;
        default:
            break;
    }
}


- (void)setButton:(UIButton *)button withImageNamed:(NSString *)fileName {
    UIImage *oriImage = [UIImage imageNamed:fileName];
    UIImage *stretchableButtonImage = [oriImage stretchableImageWithLeftCapWidth:12 topCapHeight:0];
    [button setBackgroundImage:stretchableButtonImage forState:UIControlStateNormal];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _sortKeyDictionary = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"all", @"kByCategory",
                          @"all", @"kByDistance", @"all", @"kByBank",nil];
//    UIImageView *barImageView = [[UIImageView alloc] initWithFrame:CGRectMake(320, 44, 0, 0)];
//    [barImageView setImage:[UIImage imageNamed:@"barimage.png"]];
//    [self.view addSubview:barImageView];
    
    //增加地图按钮
    UIBarButtonItem *mapButton = [[UIBarButtonItem alloc] initWithTitle:@"地图" style:UIBarButtonItemStyleDone target:self action:@selector(showMap:)];
    kMapButton = mapButton;
    self.navigationItem.rightBarButtonItem = mapButton;
    [mapButton release];
    
    
    
    _showArray = [[NSMutableArray alloc] initWithArray:_dataArray];
    _pickerArray = [[NSMutableArray alloc] initWithCapacity:10];
    self.tableView.rowHeight = 74;  
    _picker = [[UIPickerView alloc] init];
    _picker.delegate = self;
    _picker.dataSource = self;
    _picker.showsSelectionIndicator = YES;
    
    CGPoint p = _picker.center;
    p.y += 50;
    _picker.center = p;
    
    CGRect rect = _picker.bounds;
    rect.size.width = 280;
    _picker.bounds = rect;
    
    _categoryArray = [[NSMutableArray alloc] initWithCapacity:10];
    _distanceArray = [[NSMutableArray alloc] initWithObjects:@"100", @"500", @"1000", @"3000", nil];
    _bankArray = [[NSMutableArray alloc] initWithCapacity:5];
    [self configPickerArray];
    
    //分栏符
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"All Cards", @"My Cards", nil]];
    kSegmentedControl = segmentedControl;
    segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
    segmentedControl.selectedSegmentIndex = 0;
    [segmentedControl addTarget:self action:@selector(switchCards:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = segmentedControl;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.dataArray = nil;
    self.showArray = nil;
    self.pickerArray = nil;
    self.tableView = nil;
    self.picker = nil;
    self.categoryArray = nil;
    self.bankArray = nil;
    self.sortKeyDictionary = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_showArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    IndividualTableCell *cell = (IndividualTableCell *)[_tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"IndividualTableCell" owner:self options:nil];
        cell = [array objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    
    // Configure the cell...
    
    OneItem *item = [_showArray objectAtIndex:indexPath.row];
    
    cell.sellerLabel.text = item.seller;
    cell.addressLabel.text = item.address;
    cell.discountLabel.text = [[item.bank objectAtIndex:0] valueForKey:@"discount"];
    cell.distanceLabel.text = item.distance;
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
    DetailController *detailViewController = [[DetailController alloc] init];
    detailViewController.oneItem = [_showArray objectAtIndex:indexPath.row];
//    detailViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
    
}



//生成、配置anction sheet， 包括其中的选取器
- (void)generateActionSheet {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"\n\n\n\n\n\n\n\n\n\n\n\n\n" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;

    PickerView *pickerView = [[PickerView alloc] initWithFrame:CGRectMake(0, 0, 320, 260)];
//    NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"PickerView" owner:self options:nil];
//    pickerView = [array objectAtIndex:0];
    pickerView.delegate = self;
    
    [self setButton:pickerView.confirmButton withImageNamed:@"blueButton.png"];
    [self setButton:pickerView.cancelButton withImageNamed:@"whiteButton.png"];

    
    switch (choosenTag) {
//        case 1:
//            pickerView.pickerDataArray = _cityArray;
//            break;
        case 2:
            pickerView.pickerDataArray = _categoryArray;
            break;
        case 3:
            pickerView.pickerDataArray = _distanceArray;
            break;
        case 4:
            pickerView.pickerDataArray = _bankArray;
            break;
        default:
            break;
    }

    kPicker = pickerView.pickerView;
    [actionSheet addSubview:pickerView];
    [actionSheet showInView:self.view];

    kActionSheet = actionSheet;
    [actionSheet release];
}



- (IBAction)selectButtonPressed:(id)sender {

    UIBarButtonItem *button = (UIBarButtonItem *)sender;
    [_pickerArray removeAllObjects];
    choosenTag = button.tag;
    if (choosenTag == 1) {
        PlaceSelectViewController *selectController = [[PlaceSelectViewController alloc] init];
        [self.navigationController pushViewController:selectController animated:YES];
        [selectController release];
    }
    else
        [self generateActionSheet];
}

- (void)buttonPressed:(NSUInteger)tag withStringInPicker:(NSString *)string{
    //更改按钮为选中的文字
    UIBarButtonItem *barButton = (UIBarButtonItem *)[self.view viewWithTag:choosenTag];
    if (tag == 1) {
        if (choosenTag == 3) {
            string = [NSString stringWithFormat:@"%@米", string];
        }
        [barButton setTitle:string];
    }
    [kActionSheet dismissWithClickedButtonIndex:tag animated:YES];
}


#pragma mark - Picker

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [_pickerArray count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [_pickerArray objectAtIndex:row];
}


#pragma mark - Action Sheet

//筛选和排序
- (void)sortTableViewWithCategory {
    [_showArray removeAllObjects];
    NSString *kByCategory = [_sortKeyDictionary valueForKey:@"kByCategory"];  //风味筛选字段
    NSString *kByDistance = [_sortKeyDictionary valueForKey:@"kByDistance"];     //距离筛选字段
    NSString *kBankKey = [_sortKeyDictionary valueForKey:@"kByBank"];     //银行字段

    int flag = 0;
    for (OneItem *item in _dataArray) {
        
        if (![kByCategory isEqualToString:@"all"]) {
            if (![item.category_Fine isEqualToString:kByCategory]) {
                continue;
            }
        }
        if (![kByDistance isEqualToString:@"all"]) {
            if ([item.distance intValue] >= [kByDistance intValue]) {
                continue;
            }
        }
        if (![kBankKey isEqualToString:@"all"]) {
            for (NSDictionary *dic in item.bank) {
                if ([[dic valueForKey:@"bank_name"] isEqualToString:kBankKey]) {
                    flag = 1;
                }
            }
        }
        if ([kBankKey isEqualToString:@"all"]) {
            [_showArray addObject:item];
        }
        else if (flag == 1) 
            [_showArray addObject:item];
        
        flag = 0;

    }
    
    if (kSegmentedControl.selectedSegmentIndex == 1) {
        [self getMyCardsData];
    }
    
    
//    if (![kBySortKey isEqualToString:@"all"] && [_showArray count] > 1) {
//        float a =0, b = 0;
//        int n = [_showArray count];
//        for (int i = 1; i < n; i++) {
//            for (int j = 0; j < n - i; j++) {
//                a = [[[_showArray objectAtIndex:j] valueForKey:kBySortKey] floatValue];
//                b = [[[_showArray objectAtIndex:j+1] valueForKey:kBySortKey] floatValue];
//                if (a < b) {
//                    [_showArray exchangeObjectAtIndex:j withObjectAtIndex:j+1];
//                }
//            }
//        }
//    }
    
    //没有结果的话，禁用“地图”按钮，否则启用“地图”按钮
    kMapButton.enabled = [_showArray count] > 0 ? YES : NO;
    [self.tableView reloadData];
    
}
    
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {

//    NSString *kByCategory = @"all";  //风味筛选字段
//    NSString *kByRange = @"all";     //距离筛选字段
//    NSString *kBankKey = @"all";     //银行字段
    
    NSUInteger choosen = [kPicker selectedRowInComponent:0];
    switch (buttonIndex) {
        case 1:
            switch (choosenTag) {
                case 1:
                {

                    break;
                }
                case 2:
                {
                    NSString *kCategory = [_categoryArray objectAtIndex:choosen];
                    [_sortKeyDictionary setValue:kCategory forKey:@"kByCategory"];
                    [_categoryButton setTitle:kCategory];
                    break;
                }
                case 3:
                {
                    NSString *kDistance = [_distanceArray objectAtIndex:choosen];
                    [_sortKeyDictionary setValue:kDistance forKey:@"kByDistance"];
                    [_distanceButton setTitle:[NSString stringWithFormat:@"%@米", kDistance]];
                    break;
                }
                case 4:
                {
                    NSString *kBank = [_bankArray objectAtIndex:choosen];
                    [_sortKeyDictionary setValue:kBank forKey:@"kByBank"];
                    [_bankButton setTitle:kBank];
                    break;
                }
                default:
                    break;
            }
            break;
            
        default:
            break;
    }
    [self sortTableViewWithCategory];
    
    kPicker = nil;
    kActionSheet = nil;
}
                                  



@end
