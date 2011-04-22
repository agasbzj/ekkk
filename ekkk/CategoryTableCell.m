//
//  CategoryTableCell.m
//  ekkk
//
//  Created by 卞 中杰 on 11-4-22.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "CategoryTableCell.h"


@implementation CategoryTableCell

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
    [super dealloc];
}

@end
