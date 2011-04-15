//
//  OffersRootViewController.m
//  ekkk
//
//  Created by Wu Jianjun on 11-4-3.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//


#import "OffersRootViewController.h"
#import "OneItem.h"

#define kFileName @"location.plist"
#define DARK_BACKGROUND [UIColor colorWithRed:151.0/255.0 green:152.0/255.0 blue:155.0/255.0 alpha:1.0];
#define LIGHT_BACKGROUND [UIColor colorWithRed:172.0/255.0 green:173.0/255.0 blue:175.0/255.0 alpha:1.0];

@implementation OffersRootViewController
@synthesize tableView = _tableView;
@synthesize dataArray = _dataArray;
@synthesize segmentedControl = _segmentedControl;
@synthesize individualCell = _individualCell;

- (NSURL *)locationDataFilePath {
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:kFileName];
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
    [_individualCell release];
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
    FetchDataController *fetchDataController = [[FetchDataController alloc] init];
//    [fetchDataController getDataByKey:@"city" isEqualToValue:@"上海"];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"hot = '1'"];    //设置查询格式
    [fetchDataController getDataByPredicate:predicate];
    _dataArray = [[NSArray arrayWithArray:(NSArray *)fetchDataController.itemList] retain]; //把这里retain就没有崩溃了
    [fetchDataController release];

}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (void)reloadItemData {
    [self.tableView reloadData];
}

- (void)regetData {
//    _fetchDataController = nil;
//    _dataArray = nil;
    [self getData];
    [_tableView reloadData];
}

- (IBAction)switchCategory:(id)sender {
    NSPredicate *pre;
    switch (_segmentedControl.selectedSegmentIndex) {
        case 0:
        {
            pre = [NSPredicate predicateWithFormat:@"hot = '1'"];
            
            break;
        }
        case 1:
        {
            pre = [NSPredicate predicateWithFormat:@"area = '人民广场'"];
            break;
        }
            
        default:
            break;
    }
    FetchDataController *fc = [[FetchDataController alloc] init];
    [fc getDataByPredicate:pre];
    _dataArray = nil;
    _dataArray = [[NSArray arrayWithArray:(NSArray *)fc.itemList] retain];
    [fc release];
    [_tableView reloadData];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.rowHeight = 74;
    
    self.navigationController.navigationBarHidden = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(regetData) name:@"NewDataSaved" object:nil];
    // Do any additional setup after loading the view from its nib.
    NSURL *filePath = [self locationDataFilePath];
    NSDictionary *tmp = [[[NSDictionary alloc] initWithContentsOfURL:filePath] autorelease];
    NSLog(@"%@,%@",[tmp valueForKey:@"latitude"],[tmp valueForKey:@"longitude"]);
    
    [self getData];
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
    IndividualTableCell *cell = (IndividualTableCell *)[_tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"IndividualTableCell" owner:self options:nil];
        cell = _individualCell;
        self.individualCell = nil;
    }
    

    OneItem *item = [_dataArray objectAtIndex:indexPath.row];
    
    cell.discountLable.text = item.discount;
    cell.sellerLabel.text = item.seller;
    cell.cityLabel.text = item.city;
    cell.areaLabel.text = item.area;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    OneItem *item = [_dataArray objectAtIndex:indexPath.row];
    DetailViewController *detailController = [[[DetailViewController alloc] init] autorelease];
    detailController.oneItem = item;
    [self.navigationController pushViewController:detailController animated:YES];
}



@end
 

