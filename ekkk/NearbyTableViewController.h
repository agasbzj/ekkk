//
//  NearbyTableViewController.h
//  ekkk
//
//  Created by 卞 中杰 on 11-4-19.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OneItem.h"

@interface NearbyTableViewController : UITableViewController {
    NSMutableArray *_dataArray;
    NSMutableArray *_nearbyArray;
    OneItem *_oneItem;
}
@property (nonatomic, retain) NSMutableArray *dataArray;
@property (nonatomic, retain) NSMutableArray *nearbyArray;
@property (nonatomic, retain) OneItem *oneItem;
@end
