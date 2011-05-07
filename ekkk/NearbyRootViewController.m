//
//  NearbyRootViewController.m
//  ekkk
//
//  Created by 卞 中杰 on 11-4-18.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "NearbyRootViewController.h"
#import "NearbyTableViewController.h"
#import "ekkkAppDelegate.h"
@implementation NearbyRootViewController

@synthesize categoryArray = _categoryArray;
@synthesize plistKey = _plistKey;


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

    self.tableView.rowHeight = 60;  //根据类别数量配置行高
    self.tableView.scrollEnabled = NO; //不允许滚动
    

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

    
    
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
    UIFont *font = [UIFont systemFontOfSize:14];
    cell.detailTextLabel.font = font;
    cell.textLabel.font = font;
    UIImage *icon = [UIImage imageNamed:[dic valueForKey:@"icon"]];
    cell.imageView.image = icon;                 

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

    NSDictionary *dic = [_categoryArray objectAtIndex:indexPath.row];
    NSString *str = [dic valueForKey:@"keyForSearch"];
    
    NSMutableArray *showArray = [[NSMutableArray alloc] initWithCapacity:30];
    ekkkAppDelegate *myDelegate = (ekkkAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSArray *allData = (NSArray *)myDelegate.parsedItems;
    for (OneItem *item in allData) {
        //nearby这里的数据源范围是所有非hot的数据，这样可以做到offers的数据源和其他信用卡的数据源共用一个xml文件的同种类型的记录，方便解析和数据model；
        if ([str isEqualToString:item.category_Coarse] & [item.hot isEqualToString:@"0"]) {
            [showArray addObject:item];
        }
    }

    NearbyTableViewController *nearbyTableViewController = [[NearbyTableViewController alloc] init];
    nearbyTableViewController.nearbyArray = showArray;
    nearbyTableViewController.dataArray = showArray;
    [self.navigationController pushViewController:nearbyTableViewController animated:YES];
    [nearbyTableViewController release];
    [showArray release];
}


@end
