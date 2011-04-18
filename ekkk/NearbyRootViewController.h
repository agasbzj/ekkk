//
//  NearbyRootViewController.h
//  ekkk
//
//  Created by 卞 中杰 on 11-4-18.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NearbyRootViewController : UITableViewController {

    NSArray *_categoryArray;
    NSDictionary *_plistKey;
}
@property (nonatomic, retain) NSArray *categoryArray;
@property (nonatomic, retain) NSDictionary *plistKey;

@end
