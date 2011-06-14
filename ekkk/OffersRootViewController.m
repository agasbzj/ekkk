//
//  OffersRootViewController.m
//  ekkk
//
//  Created by Wu Jianjun on 11-4-3.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//


#import "OffersRootViewController.h"
#import "OneItem.h"
#import "OffersTableCell.h"
#import "DetailController.h"
#import "ekkkAppDelegate.h"
#define kFileName @"location.plist"
#define kDataFileName @"Data.plist"
#define DARK_BACKGROUND [UIColor colorWithRed:151.0/255.0 green:152.0/255.0 blue:155.0/255.0 alpha:1.0];
#define LIGHT_BACKGROUND [UIColor colorWithRed:172.0/255.0 green:173.0/255.0 blue:175.0/255.0 alpha:1.0];

@implementation OffersRootViewController
@synthesize tableView = _tableView;
@synthesize dataArray = _dataArray;
@synthesize segmentedControl = _segmentedControl;


NSArray *temp;  //跟踪指针，用来释放。

- (NSURL *)locationDataFilePath {
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:kFileName];
    NSLog(@"%@", storeURL);
    return storeURL;
}

- (NSURL *)itemDataFilePath {
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:kDataFileName];
    NSLog(@"%@", storeURL);
    return storeURL;
}

- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

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
    [_segmentedControl release];
    [_dataArray release];
    [_tableView release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}



////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//别的表视图重写这个方法！！！！
- (void)getData {    
//    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:kDataFileName];
//    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfURL:storeURL];
//    _dataArray = [dic valueForKey:@"data_Array"];
    if ([_dataArray count] > 0) {
        [_dataArray removeAllObjects];
    }
    ekkkAppDelegate *ekkkDelegate = (ekkkAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSArray *allData = ekkkDelegate.parsedItems;
    _dataArray = [[NSMutableArray alloc] initWithCapacity:30];
    for (OneItem *item in allData) {
        if ([item.hot isEqualToString:@"1"]) {
            [_dataArray addObject:item];
        }
    }
    
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (void)getMyCardsData 
{
    if ([_dataArray count] > 0) 
    {
        [_dataArray removeAllObjects];
    }
    ekkkAppDelegate *ekkkDelegate = (ekkkAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSArray *allData = ekkkDelegate.parsedItems;
    NSArray *myCards = ekkkDelegate.userCardsArray;
    _dataArray = [[NSMutableArray alloc] initWithCapacity:30];
    NSMutableArray *allMyCards = [[[NSMutableArray alloc] initWithCapacity:10] autorelease];
    
    //所有用户的卡，每一项是string
    for (NSDictionary *dic in myCards)
    {
        [allMyCards addObjectsFromArray:[dic valueForKey:@"cards"]];
    }
    
//    BOOL isSameBank = NO;   //是否拥有某个银行的卡，如果有，则跳过该银行其他的卡的判断，否则会重复添加。
//
//    for (OneItem *item in allData) 
//    {
//        if ([item.hot isEqualToString:@"1"]) 
//        {
//            for (NSDictionary *bankDic in item.bank) 
//            {
//                NSArray *cardA = [bankDic valueForKey:@"card"];
//                for (NSDictionary *cardD in cardA) 
//                {
//                    NSString *str1 = [cardD valueForKey:@"card_name"];
//
//                    for (NSString *str2 in allMyCards) 
//                    {
//                        if ([str1 isEqualToString:str2] == YES) 
//                        {
//                            [_dataArray addObject:item];
//                            isSameBank = YES;
//                            break;
//                        }
//                    }
//                    if (isSameBank == YES) {
//                        break;
//                    }
//                }
//                if (isSameBank == YES) {
//                    isSameBank = NO;
//                    continue;
//                }
//            }
//        }
//    }
    for (OneItem *item in allData) 
    {
        for (NSDictionary *bankDic in item.bank) 
        {
            NSString *bankName = [bankDic valueForKey:@"bank_name"];
            for (NSDictionary *dic in myCards) {
                NSString *str2 = [dic valueForKey:@"bank_name"];
                if ([bankName isEqualToString:str2]) {
                    [_dataArray addObject:item];
                }
            }
        }
    }
}

- (void)reloadItemData {
    [self.tableView reloadData];
}


//新数据来了之后重新读数据库并显示新数据
- (void)regetData {
    [temp release];
    [self getData];
    [_tableView reloadData];
}

- (IBAction)switchCategory:(id)sender {

    switch (_segmentedControl.selectedSegmentIndex) {
        case 0:
        {
            [self getData];
            
            break;
        }
        case 1:
        {
            [self getMyCardsData];
            break;
        }
            
        default:
            break;
    }

    [_tableView reloadData];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.rowHeight = 74;  //设置每个cell行高
    self.tableView.backgroundColor = [UIColor blackColor];
    self.tableView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.navigationController.navigationBarHidden = YES;
    
    //观察新数据是否保持完毕
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(regetData) name:@"NewDataSaved" object:nil];
    
    // Do any additional setup after loading the view from its nib.
    NSURL *filePath = [self locationDataFilePath];
    NSDictionary *tmp = [[[NSDictionary alloc] initWithContentsOfURL:filePath] autorelease];
    NSLog(@"%@,%@",[tmp valueForKey:@"latitude"],[tmp valueForKey:@"longitude"]);
    
    [self getData];
    
    _segmentedControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"Hot", @"My Cards", nil]];
    _segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
    _segmentedControl.selectedSegmentIndex = 0;
    
    [_segmentedControl addTarget:self action:@selector(switchCategory:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = _segmentedControl;
    
    
}

- (void)viewDidUnload
{
//    _fetchDataController = nil;
//    _dataArray = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - TableView Delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"CellIdentifier";
    OffersTableCell *cell = (OffersTableCell *)[_tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {

        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"OffersTableCell" owner:self options:nil];
        cell = [array objectAtIndex:0];
        cell.backgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img-offers-cellBackground.png"]] autorelease];
        cell.selectionStyle = UITableViewCellEditingStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;

    }
    

    OneItem *item = [_dataArray objectAtIndex:indexPath.row];
    
    cell.sellerLabel.text = item.seller;
    cell.discountLabel.text = [[item.bank objectAtIndex:0] valueForKey:@"discount"];
    cell.sourceLabel.text = item.source;
    
    if (indexPath.row % 2 == 0) {
        cell.layer.backgroundColor = [[UIColor colorWithRed:.3f green:.3f blue:.3f alpha:1.f] CGColor];
    }
    else cell.layer.backgroundColor = [[UIColor colorWithRed:.6f green:.6f blue:.6f alpha:1.f] CGColor];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    OneItem *item = [_dataArray objectAtIndex:indexPath.row];
    DetailController *detailController = [[[DetailController alloc] init] autorelease];
    detailController.oneItem = item;    
    detailController.hidesBottomBarWhenPushed = YES;    //detail隐藏tabbar
    [self.navigationController pushViewController:detailController animated:YES];
}



@end
 

