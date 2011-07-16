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
//@synthesize image = _image;

- (void)configCell {
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 7, 60, 60)];
    [self addSubview:_iconImageView];
    
    _sellerLabel = [[UILabel alloc] initWithFrame:CGRectMake(78, 5, 220, 21)];
    [self addSubview:_sellerLabel];
    
    _discountLabel = [[UILabel alloc] initWithFrame:CGRectMake(78, 27, 220, 21)];
    [self addSubview:_sellerLabel];
    
    NSString *from = @"来自于：";
    [from drawInRect:CGRectMake(78, 48, 45, 21) withFont:[UIFont systemFontOfSize:10]];
    
    _sourceLabel = [[UILabel alloc] initWithFrame:CGRectMake(115, 48, 487, 21)];
    [self addSubview:_sourceLabel];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
//        [self configCell];
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
    //[_image release];
    [_sourceLabel release];

    [super dealloc];
}

@end
