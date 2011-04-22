//
//  NearbyTableViewController.h
//  ekkk
//
//  Created by 卞 中杰 on 11-4-19.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NearbyTableViewController : UITableViewController {
    NSArray *_dataArray;
}
@property (nonatomic, retain) NSArray *dataArray;
@end
