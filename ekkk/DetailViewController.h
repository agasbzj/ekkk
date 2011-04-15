//
//  DetailViewController.h
//  ekkk
//
//  Created by Wu Jianjun on 11-4-5.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OneItem.h"
@class OneItem;

@interface DetailViewController : UIViewController {
    OneItem *_oneItem;
    UILabel *_seller, *_category_Fine, *_comments_General, *_comments_Service, *_comments_Enviroment, *_comments_Discount, *_telephone, *_address;
}

@property (nonatomic, retain) OneItem *oneItem;
@property (nonatomic, retain) IBOutlet UILabel *seller;
@property (nonatomic, retain) IBOutlet UILabel *category_Fine;
@property (nonatomic, retain) IBOutlet UILabel *comments_General;
@property (nonatomic, retain) IBOutlet UILabel *comments_Service;
@property (nonatomic, retain) IBOutlet UILabel *comments_Enviroment;
@property (nonatomic, retain) IBOutlet UILabel *comments_Discount;
@property (nonatomic, retain) IBOutlet UILabel *telephone;
@property (nonatomic, retain) IBOutlet UILabel *address;


@end
