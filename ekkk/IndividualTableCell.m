//
//  IndividualTableCell.m
//  ekkk
//
//  Created by Wu Jianjun on 11-4-15.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "IndividualTableCell.h"


@implementation IndividualTableCell

@synthesize ratingView = _ratingView;
@synthesize sellerLabel = _sellerLabel;
@synthesize areaLabel = _areaLabel;
@synthesize cityLabel = _cityLabel;
@synthesize image = _image;
@synthesize discountLable = _discountLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc
{
    [_ratingView release];
    [_areaLabel release];
    [_cityLabel release];
    [_sellerLabel release];
    [_discountLabel release];
    [_image release];
    [super dealloc];
}

@end
