//
//  CategoryTableViewController.h
//  ekkk
//
//  Created by Wu Jianjun on 11-4-19.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IndividualTableCell;

@interface CategoryTableViewController : UITableViewController {
    NSArray *_dataArray;
    IndividualTableCell *_individualCell;
}
@property (nonatomic, retain) NSArray *dataArray;
@property (nonatomic, retain) IndividualTableCell *individualCell;
@end

