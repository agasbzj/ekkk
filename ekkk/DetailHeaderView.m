//
//  DetailHeaderView.m
//  ekkk
//
//  Created by Wu Jianjun on 11-4-30.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "DetailHeaderView.h"


@implementation DetailHeaderView

@synthesize category_Fine = _category_Fine;
@synthesize comments_Discount = _comments_Discount;
@synthesize comments_Enviroment = _comments_Enviroment;
@synthesize comments_General = _comments_General;
@synthesize comments_Service = _comments_Service;
@synthesize seller = _seller;
@synthesize imageView = _imageView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc
{
    [_imageView release];
    [_comments_Service release];
    [_comments_General release];
    [_comments_Discount release];
    [_comments_Enviroment release];
    [_seller release];
    [_category_Fine release];
    [super dealloc];
}

@end
