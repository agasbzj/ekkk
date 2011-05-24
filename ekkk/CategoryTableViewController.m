//
//  CategoryTableViewController.m
//  ekkk
//
//  Created by Wu Jianjun on 11-4-19.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "CategoryTableViewController.h"
#import "DetailController.h"
#import "OneItem.h"
#import "IndividualTableCell.h"
#import "PickerViewController.h"
#import "MapViewController.h"

@implementation CategoryTableViewController

@synthesize dataArray = _dataArray;
@synthesize tableView = _tableView;
@synthesize toolBar = _toolBar;
@synthesize cityButton = _cityButton;
@synthesize showArray = _showArray;
@synthesize picker = _picker;
@synthesize pickerArray = _pickerArray;

@synthesize cityArray = _cityArray, categoryArray = _categoryArray, distanceArray = _distanceArray;

static NSUInteger choosenTag = 0;   //点了哪个查询分类
static bool pickerOpen = NO;    //是否已经打开了一个picker
static UIActionSheet *kActionSheet;
static UIPickerView *kPicker;
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
    [_cityArray release];
    [_categoryArray release];
    [_distanceArray release];
    
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

//配置选取器用的各个array
- (void)configPickerArray {
    [_cityArray removeAllObjects];
    [_categoryArray removeAllObjects];
//    [_distanceArray removeAllObjects];
    
    NSInteger flag = 0;
    NSString *str;
    for (OneItem *item in _dataArray) {
        str = item.city;
        for (NSString *s in _cityArray) {
            if ([s isEqualToString:str]) {
                flag = 1;
                break;
            }
        }
        if (flag == 0) {
            [_cityArray addObject:item.city];
        }
        flag = 0;
    }
    flag = 0;
    str = nil;
    
    for (OneItem *item in _dataArray) {
        str = item.category_Fine;
        for (NSString *s in _categoryArray) {
            if ([s isEqualToString:str] == YES) {
                flag = 1;
                break;
            }
        }
        if (flag == 0) {
            [_categoryArray addObject:item.category_Fine];
        }
        flag = 0;
    }

    
    
}

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
    
    //增加地图按钮
    UIBarButtonItem *mapButton = [[UIBarButtonItem alloc] initWithTitle:@"地图" style:UIBarButtonItemStyleDone target:self action:@selector(showMap:)];
    self.navigationItem.rightBarButtonItem = mapButton;
    [mapButton release];
    
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
    
    _categoryArray = [[NSMutableArray alloc] initWithCapacity:10];
    _cityArray = [[NSMutableArray alloc] initWithCapacity:10];
    _distanceArray = [[NSMutableArray alloc] initWithObjects:@"100", @"500", @"1000", @"3000", nil];
    
    [self configPickerArray];
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
//    detailViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
    
}

- (void)generateActionSheet {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"\n\n\n\n\n\n\n\n\n\n\n\n\n" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;

    PickerView *pickerView;
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"PickerView" owner:self options:nil];
    pickerView = [array objectAtIndex:0];
    pickerView.delegate = self;
    switch (choosenTag) {
        case 1:
            pickerView.pickerDataArray = _cityArray;
            break;
        case 2:
            pickerView.pickerDataArray = _categoryArray;
            break;
        default:
            break;
    }
//    pickerView.pickerDataArray = _pickerArray;

    kPicker = pickerView.pickerView;
    [actionSheet addSubview:pickerView];
    [actionSheet showInView:self.view];
    CGRect rect = pickerView.pickerView.bounds;
    rect.size.width = 320;
    pickerView.pickerView.bounds = rect;
    CGPoint point = pickerView.pickerView.center;
    point.x = 160;
    pickerView.pickerView.center = point;
    kActionSheet = actionSheet;
    [actionSheet release];
}

- (IBAction)cityButtonPressed:(id)sender {
//    [self generateActionSheet];
    
}

- (IBAction)selectButtonPressed:(id)sender {
//    if (pickerOpen == YES) {
//        return;
//    }
    UIBarButtonItem *button = (UIBarButtonItem *)sender;
    [_pickerArray removeAllObjects];
    choosenTag = button.tag;
    
//    NSString *str;
//    NSInteger flag = 0;
    

    
//    //根据分类显示选取器内可供选择的数据
//    switch (choosenTag) {
//        case 1:
//            for (OneItem *item in _dataArray) {
//                str = item.city;
//                for (NSString *s in _pickerArray) {
//                    if ([s isEqualToString:str]) {
//                        flag = 1;
//                        break;
//                    }
//                }
//                if (flag == 0) {
//                    [_pickerArray addObject:item.city];
//                }
//                flag = 0;
//            }
//            break;
//        case 2:
//            for (OneItem *item in _dataArray) {
//                str = item.category_Fine;
//                for (NSString *s in _pickerArray) {
//                    if ([s isEqualToString:str] == YES) {
//                        flag = 1;
//                        break;
//                    }
//                }
//                if (flag == 0) {
//                    [_pickerArray addObject:item.category_Fine];
//                }
//                flag = 0;
//            }
//            break;
//        case 3:
//            for (OneItem *item in _dataArray) {
//                str = item.category_Coarse;
//                for (NSString *s in _pickerArray) {
//                    if ([s isEqualToString:str]) {
//                        flag = 1;
//                        break;
//                    }
//                }
//                if (flag == 0) {
//                    [_pickerArray addObject:item.category_Coarse];
//                }
//                flag = 0;
//            }
//        case 4:
//            for (OneItem *item in _dataArray) {
//                str = item.category_Coarse;
//                for (NSString *s in _pickerArray) {
//                    if ([s isEqualToString:str]) {
//                        flag = 1;
//                        break;
//                    }
//                }
//                if (flag == 0) {
//                    [_pickerArray addObject:item.category_Coarse];
//                }
//                flag = 0;
//            }
//        case 5:
//            for (OneItem *item in _dataArray) {
//                str = item.category_Coarse;
//                for (NSString *s in _pickerArray) {
//                    if ([s isEqualToString:str]) {
//                        flag = 1;
//                        break;
//                    }
//                }
//                if (flag == 0) {
//                    [_pickerArray addObject:item.category_Coarse];
//                }
//                flag = 0;
//            }
//            break;
//        default:
//            break;
//    }
    
    
//
//    
//    PickerViewController *pickerView;
//    NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"PickerViewController" owner:self options:nil];
//    pickerView = [array objectAtIndex:0];
//    pickerView.backgroundColor = [UIColor clearColor];
//    
//    pickerView.pickerArray = _pickerArray;
//    pickerView.delegate = self;
//    
//    CGRect rect = pickerView.frame;
//    rect.origin.y = 156;
//    pickerView.frame = rect;
//    
//    [self.view addSubview:pickerView];
//    pickerOpen = YES;

    
    
    [self generateActionSheet];
}

- (void)buttonPressed:(NSUInteger)tag withStringInPicker:(NSString *)string{
    //更改按钮为选中的文字
    UIBarButtonItem *barButton = (UIBarButtonItem *)[self.view viewWithTag:choosenTag];
    [barButton setTitle:string];
    [kActionSheet dismissWithClickedButtonIndex:tag animated:YES];
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
//    if (buttonIndex == [actionSheet destructiveButtonIndex]) {
//        NSUInteger choosen = [_picker selectedRowInComponent:0];
//        [_showArray removeAllObjects];  //先清空要显示的数据
//        
//        //按点击的分类查询刷新数据
//        switch (choosenTag) {
//            case 1:
//                for (OneItem *item in _dataArray) {
//                    if ([item.city isEqualToString:[_pickerArray objectAtIndex:choosen]]) {
//                        [_showArray addObject:item];
//                    }
//                }
//                break;
//
//            default:
//                break;
//        }
//
//        [_tableView reloadData];
//    }

    
    NSUInteger choosen = [kPicker selectedRowInComponent:0];
    switch (buttonIndex) {
        case 1:
            [_showArray removeAllObjects];
            switch (choosenTag) {
                case 1:
                    for (OneItem *item in _dataArray) {
                        if ([item.city isEqualToString:[_cityArray objectAtIndex:choosen]]) {
                            [_showArray addObject:item];
                        }
                    }
                    break;
                case 2:
                    for (OneItem *item in _dataArray) {
                        if ([item.category_Fine isEqualToString:[_categoryArray objectAtIndex:choosen]]) {
                            [_showArray addObject:item];
                        }
                    }
                    break;
                case 3:
                    for (OneItem *item in _dataArray) {
                        if ([item.distance isEqualToString:[_pickerArray objectAtIndex:choosen]]) {
                            [_showArray addObject:item];
                        }
                    }
                    break;
                case 4:
                    for (OneItem *item in _dataArray) {
                        if ([item.category_Coarse isEqualToString:[_pickerArray objectAtIndex:choosen]]) {
                            [_showArray addObject:item];
                        }
                    }
                    break;
                default:
                    break;
            }
//            [_showArray retain];
            [_tableView reloadData];
            break;
            
        default:
            break;
    }
    
    kPicker = nil;
    kActionSheet = nil;
}

//- (void)selectedOneInPicker:(NSUInteger)choosen {
//    pickerOpen = NO;
//    if (choosen == 10000) {
//        return;
//    }
//    [_showArray removeAllObjects];
//    switch (choosenTag) {
//        case 1:
//            for (OneItem *item in _dataArray) {
//                if ([item.city isEqualToString:[_pickerArray objectAtIndex:choosen]]) {
//                    [_showArray addObject:item];
//                }
//            }
//            break;
//        case 2:
//            for (OneItem *item in _dataArray) {
//                if ([item.category_Fine isEqualToString:[_pickerArray objectAtIndex:choosen]]) {
//                    [_showArray addObject:item];
//                }
//            }
//            break;
//        default:
//            break;
//    }
//    [_tableView reloadData];
//}
@end
