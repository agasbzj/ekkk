//
//  IndividualTableCell.h
//  ekkk
//
//  Created by Wu Jianjun on 11-4-15.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RatingView.h"

@interface IndividualTableCell : UITableViewCell {
    RatingView *_ratingView;
    UILabel *_sellerLabel;
    UILabel *_areaLabel;
    UILabel *_cityLabel;
    UIImageView *_image;
    UILabel *_discountLabel;
    
}

@property (nonatomic, retain) IBOutlet RatingView *ratingView;
@property (nonatomic, retain) IBOutlet UILabel *sellerLabel;
@property (nonatomic, retain) IBOutlet UILabel *cityLabel;
@property (nonatomic, retain) IBOutlet UILabel *areaLabel;
@property (nonatomic, retain) IBOutlet UIImageView *image;
@property (nonatomic, retain) IBOutlet UILabel *discountLable;

@end
