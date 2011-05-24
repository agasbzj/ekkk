//
//  NearbyTableViewController.m
//  ekkk
//
//  Created by 卞 中杰 on 11-4-19.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "NearbyTableViewController.h"
#import "DetailController.h"
#import "IndividualTableCell.h"
#import "ekkkAppDelegate.h"
#import "MapViewController.h"

@implementation NearbyTableViewController
@synthesize dataArray = _dataArray;
@synthesize nearbyArray = _nearbyArray;
@synthesize oneItem = _oneItem;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [_dataArray release];
    [_nearbyArray release];
    [_oneItem release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}



- (void)getMyCardsData 
{
//    if ([_dataArray count] > 0) 
//    {
//        [_dataArray removeAllObjects];
//    }
    
    ekkkAppDelegate *ekkkDelegate = (ekkkAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSArray *allData = [[NSArray alloc] initWithArray:_nearbyArray];    //所有附近item数组
    NSArray *myCards = ekkkDelegate.userCardsArray; //我的卡数组
    _dataArray = [[NSMutableArray alloc] initWithCapacity:30];
    NSMutableArray *allMyCards = [[NSMutableArray alloc] initWithCapacity:10];
    
    //所有用户的卡，每一项是string
    for (NSDictionary *dic in myCards)
    {
        [allMyCards addObjectsFromArray:[dic valueForKey:@"cards"]];
    }
    
//    BOOL isSameBank = NO;   //是否拥有某个银行的卡，如果有，则跳过该银行其他的卡的判断，否则会重复添加。
    
//    for (OneItem *item in allData) 
//    {
//            for (NSDictionary *bankDic in item.bank) 
//            {
//                NSArray *cardA = [bankDic valueForKey:@"card"];
//                for (NSDictionary *cardD in cardA) 
//                {
//                    
//                    
//                    //传入的数据中的卡
//                    NSString *str1 = [cardD valueForKey:@"card_name"];
//                    
//                    
//                    //我的卡
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
//
//                }
//                if (isSameBank == YES) {
//                    isSameBank = NO;
//                    continue;
//                }
//            }
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

- (void)switchCards:(id)sender {
    UISegmentedControl *seg = (UISegmentedControl *)sender;
    switch (seg.selectedSegmentIndex) {
        case 0:
            //            _dataArray = [[NSArray alloc] initWithArray:_nearbyArray];
            _dataArray = _nearbyArray;
            
            break;
        case 1:
            [self getMyCardsData];
            
            break;
        default:
            break;
    }
    [self.tableView reloadData];
}

//实现点击显示地图按钮
//实现点击显示地图按钮
- (IBAction)showMap:(id)sender {
//    MapViewController *mapViewController = [[MapViewController alloc] init];
//    mapViewController.theItem = _oneItem;
//    [self.navigationController pushViewController:mapViewController animated:YES];
//    [mapViewController release];
    
    MapViewController *mapViewController = [[MapViewController alloc] init];
    mapViewController.showMultiItems = YES;
    mapViewController.itemAnnotations = _dataArray;
    [self.navigationController pushViewController:mapViewController animated:YES];
    [mapViewController release];
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.rowHeight = 74;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    //增加地图按钮
    UIBarButtonItem *mapButton = [[UIBarButtonItem alloc] initWithTitle:@"地图" style:UIBarButtonItemStyleDone target:self action:@selector(showMap:)];
    self.navigationItem.rightBarButtonItem = mapButton;
    [mapButton release];
    
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"All Cards", @"My Cards", nil]];
    segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
    segmentedControl.selectedSegmentIndex = 0;
    [segmentedControl addTarget:self action:@selector(switchCards:) forControlEvents:UIControlEventValueChanged];
//    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithCustomView:segmentedControl];
//    self.navigationItem.rightBarButtonItem = button;
//    [button release];
//    [segmentedControl release];
    self.navigationItem.titleView = segmentedControl;
}

//_segmentedControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"Hot", @"My Cards", nil]];
//_segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
//_segmentedControl.selectedSegmentIndex = 0;
//
//[_segmentedControl addTarget:self action:@selector(switchCategory:) forControlEvents:UIControlEventValueChanged];
//self.navigationItem.titleView = _segmentedControl;

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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
    return [_dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    IndividualTableCell *cell = (IndividualTableCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {

        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"IndividualTableCell" owner:self options:nil];
        cell = [array objectAtIndex:0];
    
    }
    
    // Configure the cell...
    
    OneItem *item = [_dataArray objectAtIndex:indexPath.row];
    
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
    detailViewController.oneItem = [_dataArray objectAtIndex:indexPath.row];
    detailViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
    
}

@end
