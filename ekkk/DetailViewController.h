//
//  DetailViewController.h
//  ekkk
//
//  Created by Wu Jianjun on 11-4-5.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OneItem;

@interface DetailViewController : UIViewController {
@private
    NSDateFormatter *dateFormatter;
    OneItem *OneItem;
}

@property (nonatomic, retain) OneItem *oneItem;
@property (nonatomic, readonly, retain) NSDateFormatter *dateFormatter;

@end
