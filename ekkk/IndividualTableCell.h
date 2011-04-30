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
//    UILabel *_areaLabel;
//    UILabel *_cityLabel;
    UIImageView *_imageSeller;
    UIImageView *_imageBank;
    UILabel *_discountLabel;
    UILabel *_addressLabel;
    
}

@property (nonatomic, retain) IBOutlet RatingView *ratingView;
@property (nonatomic, retain) IBOutlet UILabel *sellerLabel;
//@property (nonatomic, retain) IBOutlet UILabel *cityLabel;
//@property (nonatomic, retain) IBOutlet UILabel *areaLabel;
@property (nonatomic, retain) IBOutlet UIImageView *imageSeller;
@property (nonatomic, retain) IBOutlet UIImageView *imageBank;
@property (nonatomic, retain) IBOutlet UILabel *discountLabel;
@property (nonatomic, retain) IBOutlet UILabel *addressLabel;

@end
