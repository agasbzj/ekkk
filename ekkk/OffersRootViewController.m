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
#import "ekkkManager.h"
#import "LocateAndDownload.h"

#define kFileName @"location.plist"
#define kDataFileName @"Data.plist"
#define DARK_BACKGROUND [UIColor colorWithRed:0.757 green:0.757 blue:0.757 alpha:1.0]
#define LIGHT_BACKGROUND [UIColor colorWithRed:0.961 green:0.961 blue:0.961 alpha:1.0]

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

- (void)getData {    
//    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:kDataFileName];
//    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfURL:storeURL];
//    _dataArray = [dic valueForKey:@"data_Array"];
    if ([_dataArray count] > 0) {
        [_dataArray removeAllObjects];
    }
    
    NSArray *allData = [ekkkManager sharedManager].parsedItems;
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
    NSArray *allData = [ekkkManager sharedManager].parsedItems;
    NSArray *myCards = [ekkkManager sharedManager].userCardsArray;
    _dataArray = [[NSMutableArray alloc] initWithCapacity:30];
    NSMutableArray *allMyCards = [[[NSMutableArray alloc] initWithCapacity:10] autorelease];
    
    //所有用户的卡，每一项是string
    for (NSDictionary *dic in myCards)
    {
        [allMyCards addObjectsFromArray:[dic valueForKey:@"cards"]];
    }
    

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

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
}

- (void)viewWillDisappear:(BOOL)animated {
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.rowHeight = 74;  //设置每个cell行高
//    self.tableView.backgroundColor = [UIColor blackColor];
//    self.tableView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.navigationController.navigationBarHidden = YES;
    
    
    
    //观察新数据是否保持完毕
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(regetData) name:@"NewDataSaved" object:nil];
    
    // Do any additional setup after loading the view from its nib.
    NSURL *filePath = [self locationDataFilePath];
    NSDictionary *tmp = [[[NSDictionary alloc] initWithContentsOfURL:filePath] autorelease];
    NSLog(@"%@,%@",[tmp valueForKey:@"latitude"],[tmp valueForKey:@"longitude"]);
    
    [self getData];
    
    _segmentedControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:NSLocalizedString(@"Hot", @"Hot"), NSLocalizedString(@"My Cards", @"My Cards"), nil]];
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

        cell.selectionStyle = UITableViewCellEditingStyleNone;

    }
    

    OneItem *item = [_dataArray objectAtIndex:indexPath.row];
    
    cell.sellerLabel.text = item.seller;
    cell.discountLabel.text = [[item.bank objectAtIndex:0] valueForKey:@"discount"];
    cell.sourceLabel.text = item.source;
    

    
    NSString *backgroundImagePath = [[NSBundle mainBundle] pathForResource:(indexPath.row % 2 == 0) ? @"DarkBackground" : @"LightBackground" ofType:@"png"];
    UIImage *backgroundImage = [[UIImage imageWithContentsOfFile:backgroundImagePath] stretchableImageWithLeftCapWidth:0.0 topCapHeight:1.0];
    cell.backgroundView = [[[UIImageView alloc] initWithImage:backgroundImage] autorelease];
    cell.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    cell.backgroundView.frame = cell.bounds;
    
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
 

