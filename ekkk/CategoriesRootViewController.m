//
//  CategoriesRootViewController.m
//  ekkk
//
//  Created by Wu Jianjun on 11-4-3.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "CategoriesRootViewController.h"
#import "CategoryTableViewController.h"
#import "FetchDataController.h"

@implementation CategoriesRootViewController
@synthesize categoryArray = _categoryArray;
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
    [_categoryArray release];
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
    self.tableView.rowHeight = 60;  //根据类别数量配置行高
    self.tableView.scrollEnabled = NO; //不允许滚动
    
    
    //获得plist下的内容
    NSString *path = [[NSBundle mainBundle] pathForResource:@"NearbyCategory" ofType:@"plist"];
    _plistKey = [[NSDictionary alloc] initWithContentsOfFile:path];
    _categoryArray = [_plistKey valueForKey:@"categoryList"];
    
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
    return [_categoryArray count];
    
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
    NSDictionary *dic = [_categoryArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [dic valueForKey:@"name"];
    UIImage *icon = [UIImage imageNamed:[dic valueForKey:@"icon"]];
    cell.imageView.image = icon;                 
    
    return cell;
}

#pragma mark - Table view delegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary *dic = [_categoryArray objectAtIndex:indexPath.row];
    NSString *str = [dic valueForKey:@"keyForSearch"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"category_Coarse = %@", str];
    FetchDataController *fetchController = [[FetchDataController alloc] init];
    [fetchController getDataByPredicate:predicate];
    
    CategoryTableViewController *categoryTableViewController = [[CategoryTableViewController alloc] init];
    categoryTableViewController.dataArray = fetchController.itemList;
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:categoryTableViewController animated:YES];
    [categoryTableViewController release];
}
@end
