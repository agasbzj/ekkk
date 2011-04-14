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
//@synthesize fetchDataController = _fetchDataController;

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
//    [_fetchDataController release];
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
    FetchDataController *fetchDataController = [[FetchDataController alloc] init];
    [fetchDataController getDataByKey:@"city" isEqualToValue:@"上海"];
    _dataArray = [[NSArray arrayWithArray:(NSArray *)fetchDataController.itemList] retain]; //把这里retain就没有崩溃了
    [fetchDataController release];

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
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    OneItem *item = [_dataArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = item.discount;
    cell.detailTextLabel.text = item.city;
    
    return cell;
}
@end
 

/*
#import "OffersRootViewController.h"
#import "DetailViewController.h"
#import "OneItem.h"
#define kFileName @"location.plist"

@implementation OffersRootViewController

@synthesize tableView;
@synthesize managedObjectContext,fetchSectioningControl;

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


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSURL *filePath = [self locationDataFilePath];
    
    managedObjectContext = [[[UIApplication sharedApplication] delegate] managedObjectContext];
    
    NSDictionary *tmp = [[NSDictionary alloc] initWithContentsOfURL:filePath];
    NSLog(@"%@,%@",[tmp valueForKey:@"latitude"],[tmp valueForKey:@"longitude"]);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleSaveNotification:) name:NSManagedObjectContextDidSaveNotification object:self.managedObjectContext];
    self.navigationItem.hidesBackButton = YES;
    [self fetch];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.tableView = nil;
    self.fetchSectioningControl = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSManagedObjectContextDidSaveNotification object:self.managedObjectContext];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSManagedObjectContextDidSaveNotification object:self.managedObjectContext];
    [fetchedResultsController release];
    [managedObjectContext release];
    [detailController release];
    [tableView release];
    [fetchSectioningControl release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View Operation

- (DetailViewController *)detailController {
    if (detailController == nil) {
        detailController = [[DetailViewController alloc] initWithNibName:@"DetailView" bundle:nil];
    }
    return detailController;
}

- (void)handleSaveNotification:(NSNotification *)aNotification {
    [managedObjectContext mergeChangesFromContextDidSaveNotification:aNotification];
    [self fetch];
}

- (IBAction)changeFetchSectioning:(id)sender {
    [fetchedResultsController release];
    fetchedResultsController = nil;
    [self fetch];
}

- (void)fetch {
    NSError *error = nil;
    BOOL success = [self.fetchedResultsController performFetch:&error];
    NSAssert2(success, @"Unhandled error performing fetch at OffersViewController.m, line %d: %@", __LINE__, [error localizedDescription]);
    [self.tableView reloadData];
}

- (NSFetchedResultsController *)fetchedResultsController {
    if (fetchedResultsController == nil) {
        NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
        [fetchRequest setEntity:[NSEntityDescription entityForName:@"ItemDetail" inManagedObjectContext:managedObjectContext]];
        NSArray *sortDescriptors = nil;
        NSString *sectionNameKeyPath = nil;
        if ([fetchSectioningControl selectedSegmentIndex] == 1) {
            sortDescriptors = [NSArray arrayWithObjects:[[[NSSortDescriptor alloc] initWithKey:@"cards.bank" ascending:YES] autorelease], [[[NSSortDescriptor alloc] initWithKey:@"hot" ascending:YES] autorelease], nil];
            sectionNameKeyPath = @"cards.bank";
        } else {
            sortDescriptors = [NSArray arrayWithObject:[[[NSSortDescriptor alloc] initWithKey:@"hot" ascending:YES] autorelease]];
        }
        [fetchRequest setSortDescriptors:sortDescriptors];
        fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:managedObjectContext sectionNameKeyPath:sectionNameKeyPath cacheName:nil];
    }    
    return fetchedResultsController;
}    


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - TableView Delegates

- (NSInteger)numberOfSectionsInTableView:(UITableView *)table {
    return [[fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [[fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

// 用于在table section顶上显示商家数量

- (NSString *)tableView:(UITableView *)table titleForHeaderInSection:(NSInteger)section { 
    id <NSFetchedResultsSectionInfo> sectionInfo = [[fetchedResultsController sections] objectAtIndex:section];
    if ([fetchSectioningControl selectedSegmentIndex] == 0) {
        return [NSString stringWithFormat:NSLocalizedString(@"Top %d sellers", @"Top %d sellers"), [sectionInfo numberOfObjects]];
    } else {
        return [NSString stringWithFormat:NSLocalizedString(@"%@ - %d sellers", @"%@ - %d sellers"), [sectionInfo name], [sectionInfo numberOfObjects]];
    }
}


- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)table {
    // return list of section titles to display in section index view (e.g. "ABCD...Z#")
    return [fetchedResultsController sectionIndexTitles];
}

- (NSInteger)tableView:(UITableView *)table sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    // tell table which section corresponds to section title/index (e.g. "B",1))
    return [fetchedResultsController sectionForSectionIndexTitle:title atIndex:index];
}

- (UITableViewCell *)tableView:(UITableView *)table cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *kCellIdentifier = @"ItemDetailCell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont boldSystemFontOfSize:14];
    }
    OneItem *Item = [fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:NSLocalizedString(@"#%d %@", @"#%d %@"), [Item.hot integerValue], Item.seller];
    return cell;
}

- (void)tableView:(UITableView *)table didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [table deselectRowAtIndexPath:indexPath animated:YES];
    self.detailController.oneItem = [fetchedResultsController objectAtIndexPath:indexPath];
    [self.navigationController pushViewController:self.detailController animated:YES];
}

@end
*/
