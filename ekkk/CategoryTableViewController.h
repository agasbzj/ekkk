//
//  CategoryTableViewController.h
//  ekkk
//
//  Created by Wu Jianjun on 11-4-19.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PickerView.h"
#import "PlaceSelectViewController.h"

@class IndividualTableCell;

@interface CategoryTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate, UIPickerViewDelegate, UIPickerViewDataSource, MyPickViewDelegate, PlaceSelectDelegate> {
    NSString *_categoryCoarse;
    NSArray *_dataArray;    //初始传入的值
    NSMutableArray *_showArray;    //表视图用来显示的数据
    NSMutableArray *_pickerArray;
    
    UITableView *_tableView;
    
    UIBarButtonItem *_bankButton;
    UIBarButtonItem *_placeButton;
    UIBarButtonItem *_categoryButton;
    UIBarButtonItem *_distanceButton;
    
    UIPickerView *_picker;
    
    NSMutableArray *_categoryArray, *_distanceArray, *_bankArray, *_categoryCArray;
    NSMutableDictionary *_sortKeyDictionary;   //排序用的键值
    
}
@property (nonatomic, retain) NSString *categoryCoarse;
@property (nonatomic, retain) NSArray *dataArray;
@property (nonatomic, retain) NSMutableArray *showArray;
@property (nonatomic, retain) NSMutableArray *pickerArray;
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *bankButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *categoryButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *distanceButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *placeButton;
@property (nonatomic, retain) NSMutableArray *categoryArray;    //细分类
@property (nonatomic, retain) NSMutableArray *distanceArray;
@property (nonatomic, retain) NSMutableArray *bankArray;
@property (nonatomic, retain) NSMutableArray *categoryCArray;   //粗分类
@property (nonatomic, retain) UIPickerView *picker;
@property (nonatomic, retain) NSMutableDictionary *sortKeyDictionary;

- (void)generateActionSheet;
- (IBAction)selectButtonPressed:(id)sender;
- (void)sortTableViewWithCategory;
@end

