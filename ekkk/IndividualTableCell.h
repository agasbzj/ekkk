//
//  IndividualTableCell.h
//  ekkk
//
//  Created by Wu Jianjun on 11-4-15.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IndividualTableCell : UITableViewCell {

    UILabel *_sellerLabel;
    UIImageView *_imageSeller;
    UIImageView *_imageBank;
    UIImageView *_subImageBank;
    UILabel *_discountLabel;
    UILabel *_addressLabel;
    UILabel *_distanceLabel;
    
}

@property (nonatomic, retain) IBOutlet UILabel *sellerLabel;
@property (nonatomic, retain) IBOutlet UIImageView *imageSeller;
@property (nonatomic, retain) IBOutlet UIImageView *imageBank;
@property (nonatomic, retain) IBOutlet UIImageView *subImageBank;
@property (nonatomic, retain) IBOutlet UILabel *discountLabel;
@property (nonatomic, retain) IBOutlet UILabel *addressLabel;
@property (nonatomic, retain) IBOutlet UILabel *distanceLabel;

@end
