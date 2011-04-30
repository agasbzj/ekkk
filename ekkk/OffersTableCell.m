//
//  OffersTableCell.m
//  ekkk
//
//  Created by Wu Jianjun on 11-4-29.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "OffersTableCell.h"

@implementation OffersTableCell

@synthesize sellerLabel = _sellerLabel;
@synthesize discountLabel = _discountLabel;
@synthesize sourceLabel = _sourceLabel;
@synthesize image = _image;

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
    [_sellerLabel release];
    [_discountLabel release];
    [_image release];
    [_sourceLabel release];

    [super dealloc];
}

@end
