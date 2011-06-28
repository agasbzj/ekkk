//
//  DetailInfoTableCell.m
//  ekkk
//
//  Created by 卞中杰 on 11-6-28.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "DetailInfoTableCell.h"


@implementation DetailInfoTableCell
@synthesize typeLabel = _typeLabel;
@synthesize detailLabel = _detailLabel;
@synthesize icon = _icon;

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
    [_typeLabel release];
    [_detailLabel release];
    [_icon release];
    [super dealloc];
}

@end
