//
//  CardsRootViewController.m
//  ekkk
//
//  Created by Wu Jianjun on 11-4-3.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "CardsRootViewController.h"
#import "FetchDataController.h"
#import "CategoryTableViewController.h"

@implementation CardsRootViewController
@synthesize tableView = _tableView;
@synthesize bankArray = _bankArray;
@synthesize plistKey = _plistKey;

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
    [_bankArray release];
    [_plistKey release];
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
//    _bankList = [[[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"BanksAndCards" ofType:@"plist"]] valueForKey:@"Banks"] retain];
//    self.tableView.rowHeight = 60;  //根据类别数量配置行高
    self.tableView.scrollEnabled = YES; //不允许滚动
    
    
    //获得plist下的内容
    NSString *path = [[NSBundle mainBundle] pathForResource:@"BanksAndCards" ofType:@"plist"];
    _plistKey = [[NSDictionary alloc] initWithContentsOfFile:path];
    _bankArray = [_plistKey valueForKey:@"Banks"];
    
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return [_bankArray count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    // Configure the cell...
    NSDictionary *dic = [_bankArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [dic valueForKey:@"bankName"];
    UIImage *icon = [UIImage imageNamed:[dic valueForKey:@"icon"]];
    cell.imageView.image = icon;                 
    
    return cell;
}

/*
#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary *dic = [_bankArray objectAtIndex:indexPath.row];
    NSString *str = [dic valueForKey:@"bankName"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"card_Bank = %@", str];
    FetchDataController *fetchController = [[FetchDataController alloc] init];
    [fetchController getDataByPredicate:predicate];
    
    CategoryTableViewController *categoryTableViewController = [[CategoryTableViewController alloc] init];
    categoryTableViewController.dataArray = fetchController.itemList;
    categoryTableViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:categoryTableViewController animated:YES];
    [categoryTableViewController release];
}
*/
@end
