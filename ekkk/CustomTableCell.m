//
//  CustomTableCell.m
//  ekkk
//
//  Created by 卞中杰 on 11-7-10.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "CustomTableCell.h"


@implementation CustomTableCell
@synthesize iconImageView = _iconImageView;

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
    [_iconImageView release];
    [super dealloc];
}

@end
