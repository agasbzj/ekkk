//
//  IndividualTableCell.m
//  ekkk
//
//  Created by Wu Jianjun on 11-4-15.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "IndividualTableCell.h"


@implementation IndividualTableCell


@synthesize sellerLabel = _sellerLabel;
@synthesize distanceLabel = _distanceLabel;
//@synthesize imageSeller = _imageSeller;
@synthesize imageBank = _imageBank;
@synthesize subImageBank = _subImageBank;
@synthesize discountLabel = _discountLabel;
@synthesize addressLabel = _addressLabel;

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

    [_distanceLabel release];
    [_sellerLabel release];
    [_discountLabel release];
    //[_imageSeller release];
    [_imageBank release];
    [_subImageBank release];
    [_addressLabel release];
    [super dealloc];
}

@end
