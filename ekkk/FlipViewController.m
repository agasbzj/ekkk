//
//  FlipViewController.m
//  ekkk
//
//  Created by 卞 中杰 on 12-4-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FlipViewController.h"

@interface FlipViewController ()

@end

@implementation FlipViewController


#pragma mark Lifecycle
- (id)init
{
    self = [super init];
    if (self) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 90)];
    }
    return self;
}

- (void)dealloc
{
    [_scrollView release];
    [super dealloc];
}

#pragma mark Public Methods
- (UIScrollView *)getScrollView
{
    return _scrollView;
}

@end
