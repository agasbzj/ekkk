//
//  CategoryTableViewController.h
//  ekkk
//
//  Created by Wu Jianjun on 11-4-19.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "PickerViewController.h"
#import "PickerView.h"

@class IndividualTableCell;

@interface CategoryTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate, UIPickerViewDelegate, UIPickerViewDataSource, MyPickViewDelegate> {
    NSArray *_dataArray;    //初始传入的值
    NSMutableArray *_showArray;    //表视图用来显示的数据
    NSMutableArray *_pickerArray;
    
    UITableView *_tableView;
    UIToolbar *_toolBar;
    UIBarButtonItem *_cityButton;

    UIPickerView *_picker;
    
    NSMutableArray *_cityArray, *_categoryArray, *_distanceArray, *_sortbyArray;
    UIButton *_categoryButton, *_distanceButton, *_sortButton;
    
}
@property (nonatomic, retain) NSArray *dataArray;
@property (nonatomic, retain) NSMutableArray *showArray;
@property (nonatomic, retain) NSMutableArray *pickerArray;
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) IBOutlet UIToolbar *toolBar;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *cityButton;
@property (nonatomic, retain) IBOutlet UIButton *categoryButton;
@property (nonatomic, retain) IBOutlet UIButton *distanceButton;
@property (nonatomic, retain) IBOutlet UIButton *sortButton;
@property (nonatomic, retain) NSMutableArray *cityArray;
@property (nonatomic, retain) NSMutableArray *categoryArray;
@property (nonatomic, retain) NSMutableArray *distanceArray;
@property (nonatomic, retain) NSMutableArray *sortbyArray;
@property (nonatomic, retain) UIPickerView *picker;
- (IBAction)selectButtonPressed:(id)sender;
- (void)sortTableViewWithCategory:(NSString *)categoryKey range:(NSString *)range sortby:(NSString *)sortKey;
@end

