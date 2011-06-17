//
//  CardsRootViewController.m
//  ekkk
//
//  Created by Wu Jianjun on 11-4-3.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "CardsRootViewController.h"
#import "CardsTableViewController.h"
#import "OneItem.h"
#import "CardsTableCell.h"

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
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //获得plist下的内容
    NSString *path = [[NSBundle mainBundle] pathForResource:@"BanksAndCards" ofType:@"plist"];
    _plistKey = [[NSDictionary alloc] initWithContentsOfFile:path];
    _bankArray = [_plistKey valueForKey:@"Banks"];
    
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
    return [_bankArray count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    CardsTableCell *cell = (CardsTableCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {

        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"CardsTableCell" owner:self options:nil];
        cell = [array objectAtIndex:0];
    }
    
    NSString *backgroundImagePath = [[NSBundle mainBundle] pathForResource:(indexPath.row % 2 == 0) ? @"DarkBackground" : @"LightBackground" ofType:@"png"];
    UIImage *backgroundImage = [[UIImage imageWithContentsOfFile:backgroundImagePath] stretchableImageWithLeftCapWidth:0.0 topCapHeight:1.0];
    cell.backgroundView = [[[UIImageView alloc] initWithImage:backgroundImage] autorelease];
    cell.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    cell.backgroundView.frame = cell.bounds;
    
    // Configure the cell...
    NSDictionary *dic = [_bankArray objectAtIndex:indexPath.row];
    cell.theLabel.text = [dic valueForKey:@"bankName"];
    UIImage *icon = [UIImage imageNamed:[dic valueForKey:@"icon"]];
    cell.iconImageView.image = icon;                 
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary *dic = [_bankArray objectAtIndex:indexPath.row];
    NSString *str = [dic valueForKey:@"bankName"];
    NSMutableArray *showArray = [[NSMutableArray alloc] initWithCapacity:30];
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"card_Bank = %@", str];
//    FetchDataController *fetchController = [[FetchDataController alloc] init];
//    [fetchController getDataByPredicate:predicate];
    
    NSArray *allData = (NSArray *)[ekkkManager sharedManager].parsedItems;
    for (OneItem *item in allData) {
        for (NSDictionary *bankDic in item.bank) {
            if ([[bankDic valueForKey:@"bank_name"] isEqualToString:str]) {
                [showArray addObject:item];
                break;
            }
        }

    }
    
    
    CardsTableViewController *cardsTableViewController = [[CardsTableViewController alloc] initWithNibName:@"CategoryTableViewController" bundle:[NSBundle mainBundle]];
    cardsTableViewController.dataArray = showArray;
    cardsTableViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:cardsTableViewController animated:YES];
    [cardsTableViewController release];
    [showArray release];
}

@end
