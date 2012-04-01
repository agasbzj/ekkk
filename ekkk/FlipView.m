//
//  FlipView.m
//  ekkk
//
//  Created by 卞 中杰 on 12-4-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FlipView.h"

@implementation FlipView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithPageNumber:(NSInteger)page
{
    self = [super initWithFrame:CGRectMake(0, 0, 320, 92)];
    if (self) {
        _page = page;
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

#pragma mark - Public Methods
- (void)setImage:(UIImage *)image
{
    _imageView = [[UIImageView alloc] initWithImage:image];
    [self addSubview:_imageView];
    [_imageView release];
}

@end
