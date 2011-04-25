//
//  CardsSelectorViewController.h
//  ekkk
//
//  Created by Wu Jianjun on 11-4-5.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CardsTableViewController: UITableViewController {
    NSArray *_dataArray;
}
@property (nonatomic, retain) NSArray *dataArray;

@end
