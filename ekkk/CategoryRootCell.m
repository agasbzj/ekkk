//
//  CategoryRootCell.m
//  ekkk
//
//  Created by 卞中杰 on 11-6-17.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "CategoryRootCell.h"


@implementation CategoryRootCell
@synthesize iconImageView = _iconImageView;
@synthesize theLabel = _theLabel;

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
    [_theLabel release];
    [super dealloc];
}

@end
