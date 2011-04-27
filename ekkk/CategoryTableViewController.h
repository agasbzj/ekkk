//
//  CategoryTableViewController.h
//  ekkk
//
//  Created by Wu Jianjun on 11-4-19.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PickerViewController.h"

@class IndividualTableCell;

@interface CategoryTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate, UIPickerViewDelegate, UIPickerViewDataSource, PickerViewDelegate> {
    NSArray *_dataArray;    //初始传入的值
    NSMutableArray *_showArray;    //表视图用来显示的数据
    NSMutableArray *_pickerArray;
    
    UITableView *_tableView;
    UIToolbar *_toolBar;
    UIBarButtonItem *_cityButton;

    UIPickerView *_picker;
}
@property (nonatomic, retain) NSArray *dataArray;
@property (nonatomic, retain) NSMutableArray *showArray;
@property (nonatomic, retain) NSMutableArray *pickerArray;
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) IBOutlet UIToolbar *toolBar;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *cityButton;

@property (nonatomic, retain) UIPickerView *picker;
- (IBAction)cityButtonPressed:(id)sender;
- (IBAction)selectButtonPressed:(id)sender;
@end

