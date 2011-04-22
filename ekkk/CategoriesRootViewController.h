//
//  CategoriesRootViewController.h
//  ekkk
//
//  Created by Wu Jianjun on 11-4-3.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoriesRootViewController : UITableViewController {
    NSArray *_categoryArray;
    NSDictionary *_plistKey;
}

@property (nonatomic, retain) NSArray *categoryArray;
@property (nonatomic, retain) NSDictionary *plistKey;

@end
