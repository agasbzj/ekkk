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

@implementation OffersRootViewController
@synthesize tableView = _tableView;
@synthesize dataArray = _dataArray;
@synthesize fetchDataController = _fetchDataController;
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
    [_fetchDataController release];
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

- (void)getData {

    [_fetchDataController getDataByKey:@"city" isEqualToValue:@"Shanghai"];
    _dataArray = [NSArray arrayWithArray:_fetchDataController.itemList];

}

- (void)reloadItemData {
    [self.tableView reloadData];
}

- (void)regetData {
//    _fetchDataController = nil;
//    _dataArray = nil;
    [self getData];
    [_tableView reloadData];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    _fetchDataController = [[FetchDataController alloc] init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(regetData) name:@"NewDataSaved" object:nil];
    // Do any additional setup after loading the view from its nib.
    NSURL *filePath = [self locationDataFilePath];
    NSDictionary *tmp = [[NSDictionary alloc] initWithContentsOfURL:filePath];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier] autorelease];
    }
    OneItem *item = [_dataArray objectAtIndex:indexPath.row];
    cell.textLabel.text = item.discount;
    cell.detailTextLabel.text = item.city;
    
    return cell;
}
@end
