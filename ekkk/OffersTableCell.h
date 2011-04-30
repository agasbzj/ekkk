//
//  OffersTableCell.h
//  ekkk
//
//  Created by Wu Jianjun on 11-4-29.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface OffersTableCell : UITableViewCell {
    UILabel *_sellerLabel;
    UIImageView *_image;
    UILabel *_discountLabel;
    UILabel *_sourceLabel;
}

@property (nonatomic, retain) IBOutlet UILabel *sellerLabel;
@property (nonatomic, retain) IBOutlet UILabel *sourceLabel;
@property (nonatomic, retain) IBOutlet UILabel *discountLabel;
@property (nonatomic, retain) IBOutlet UIImageView *image;

@end
