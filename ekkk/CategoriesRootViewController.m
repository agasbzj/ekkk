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

/*
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
*/
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
    //    [nearbyTableViewController setDataArray:[fetchController itemList]];
    [self.navigationController pushViewController:categoryTableViewController animated:YES];
    [categoryTableViewController release];
}

@end
