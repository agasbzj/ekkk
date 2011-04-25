//
//  CategoryTableViewController.m
//  ekkk
//
//  Created by Wu Jianjun on 11-4-19.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "CategoryTableViewController.h"
#import "DetailViewController.h"
#import "OneItem.h"
#import "IndividualTableCell.h"

@implementation CategoryTableViewController

@synthesize dataArray = _dataArray;
@synthesize tableView = _tableView;
@synthesize toolBar = _toolBar;
@synthesize cityButton = _cityButton;
@synthesize showArray = _showArray;
@synthesize picker = _picker;
@synthesize pickerArray = _pickerArray;

static NSUInteger choosenTag = 0;   //点了哪个查询分类

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
    [_picker release];
    [_showArray release];
    [_toolBar release];
    [_dataArray release];
    [_pickerArray release];
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
    _showArray = [[NSMutableArray alloc] initWithArray:_dataArray];
    _pickerArray = [[NSMutableArray alloc] initWithCapacity:10];
    self.tableView.rowHeight = 74;  
    _picker = [[UIPickerView alloc] init];
    _picker.delegate = self;
    _picker.dataSource = self;
    _picker.showsSelectionIndicator = YES;
    
    CGPoint p = _picker.center;
    p.y += 50;
    _picker.center = p;
    
    CGRect rect = _picker.bounds;
    rect.size.width = 280;
    _picker.bounds = rect;
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
    return [_showArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    IndividualTableCell *cell = (IndividualTableCell *)[_tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"IndividualTableCell" owner:self options:nil];
        cell = [array objectAtIndex:0];
        
    }
    
    // Configure the cell...
    
    OneItem *item = [_showArray objectAtIndex:indexPath.row];
    
    cell.discountLable.text = item.discount;
    cell.sellerLabel.text = item.seller;
    cell.cityLabel.text = item.city;
    cell.areaLabel.text = item.area;
    
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
    DetailViewController *detailViewController = [[DetailViewController alloc] init];
    detailViewController.oneItem = [_dataArray objectAtIndex:indexPath.row];
//    detailViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
    
}

- (void)generateActionSheet {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"请选择\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"好" otherButtonTitles:nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;

//    actionSheet.layer.shadowOffset = CGSizeMake(0, -10);
//    actionSheet.layer.shadowOpacity = 0.5;
//    actionSheet.layer.shadowColor = [[UIColor blackColor] CGColor];
//    [actionSheet showFromToolbar:_toolBar];
//    [actionSheet showFromBarButtonItem:_cityButton animated:YES];
    
//    UIDatePicker *picker = [[UIDatePicker alloc] init];
//    picker.datePickerMode = UIDatePickerModeDate;
//    
//    CGRect menuRect = actionSheet.frame;
//    CGFloat mh = menuRect.size.height;
//    menuRect.origin.y -= 214;
//    menuRect.size.height += 214;
//    actionSheet.frame = menuRect;
//    
//    CGRect pickerRect = picker.frame;
//    pickerRect.origin.y = mh;
//    picker.frame = pickerRect;
//  
//    picker.contentMode = UIViewContentModeScaleAspectFit;
//    [actionSheet addSubview:picker];
    [actionSheet addSubview:_picker];
    [actionSheet showInView:self.view];
    
    
    [actionSheet release];
}

- (IBAction)cityButtonPressed:(id)sender {
    [self generateActionSheet];
    
}

- (IBAction)selectButtonPressed:(id)sender {
    UIBarButtonItem *button = (UIBarButtonItem *)sender;
    [_pickerArray removeAllObjects];
    
    NSString *str;
    NSInteger flag = 0;
    
    choosenTag = button.tag;
    
    //根据分类显示选取器内可供选择的数据
    switch (choosenTag) {
        case 1:
            for (OneItem *item in _dataArray) {
                str = item.city;
                for (NSString *s in _pickerArray) {
                    if ([s isEqualToString:str]) {
                        flag = 1;
                        break;
                    }
                }
                if (flag == 0) {
                    [_pickerArray addObject:item.city];
                }
                flag = 0;
            }
            break;
            
        default:
            break;
    }
    [self generateActionSheet];
}


#pragma mark - Picker

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [_pickerArray count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [_pickerArray objectAtIndex:row];
}


#pragma mark - Action Sheet

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == [actionSheet destructiveButtonIndex]) {
        NSUInteger choosen = [_picker selectedRowInComponent:0];
        [_showArray removeAllObjects];  //先清空要显示的数据
        
        //按点击的分类查询刷新数据
        switch (choosenTag) {
            case 1:
                for (OneItem *item in _dataArray) {
                    if ([item.city isEqualToString:[_pickerArray objectAtIndex:choosen]]) {
                        [_showArray addObject:item];
                    }
                }
                break;
                
            default:
                break;
        }

        [_tableView reloadData];
    }
}
@end
