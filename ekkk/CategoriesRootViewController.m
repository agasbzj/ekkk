//
//  CategoriesRootViewController.m
//  ekkk
//
//  Created by Wu Jianjun on 11-4-3.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "CategoriesRootViewController.h"
#import "CategoryTableViewController.h"
#import "CategoryRootCell.h"
#import "OneItem.h"

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
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //获得plist下的内容
    NSString *path = [[NSBundle mainBundle] pathForResource:@"NearbyCategory" ofType:@"plist"];
    _plistKey = [[NSDictionary alloc] initWithContentsOfFile:path];
    _categoryArray = [_plistKey valueForKey:@"categoryList"];
    
    self.tableView.backgroundColor = [UIColor darkGrayColor];
    
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
    
    CategoryRootCell *cell = (CategoryRootCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
//        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
//        cell.selectionStyle = UITableViewCellSelectionStyleGray;
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        cell.indentationLevel = 1;
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"CategoryRootCell" owner:self options:nil];
    cell = [array objectAtIndex:0];

    }
    
    
    NSString *backgroundImagePath = [[NSBundle mainBundle] pathForResource:(indexPath.row % 2 == 0) ? @"DarkBackground" : @"LightBackground" ofType:@"png"];
    UIImage *backgroundImage = [[UIImage imageWithContentsOfFile:backgroundImagePath] stretchableImageWithLeftCapWidth:0.0 topCapHeight:1.0];
    cell.backgroundView = [[[UIImageView alloc] initWithImage:backgroundImage] autorelease];
    cell.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    cell.backgroundView.frame = cell.bounds;
        
    // Configure the cell...
    NSDictionary *dic = [_categoryArray objectAtIndex:indexPath.row];
    cell.theLabel.text = [dic valueForKey:@"name"];
//    UIFont *font = [UIFont systemFontOfSize:14];
//    cell.detailTextLabel.font = font;
//    cell.textLabel.font = font;
    UIImage *icon = [UIImage imageNamed:[dic valueForKey:@"icon"]];
    cell.iconImageView.image = icon;                 

    return cell;
}

#pragma mark - Table view delegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary *dic = [_categoryArray objectAtIndex:indexPath.row];
    NSString *str = [dic valueForKey:@"keyForSearch"];
    NSMutableArray *showArray = [[NSMutableArray alloc] initWithCapacity:30];
    
    NSArray *allData = (NSArray *)[ekkkManager sharedManager].parsedItems;
    for (OneItem *item in allData) {
         //这里的数据源范围是所有非hot的数据，这样可以做到offers的数据源和其他信用卡的数据源共用一个xml文件的同种类型的记录，方便解析和数据model；
        if ([str isEqualToString:item.category_Coarse] & [item.hot isEqualToString:@"0"])  {
            [showArray addObject:item];
        }
    }
    
    CategoryTableViewController *categoryTableViewController = [[CategoryTableViewController alloc] initWithNibName:@"CategoryTableViewController" bundle:[NSBundle mainBundle]];
    categoryTableViewController.dataArray = showArray;
    categoryTableViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:categoryTableViewController animated:YES];
    [categoryTableViewController release];
    [showArray release];
}
@end
