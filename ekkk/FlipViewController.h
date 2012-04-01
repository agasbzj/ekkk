//
//  FlipViewController.h
//  ekkk
//
//  Created by 卞 中杰 on 12-4-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlipViewController : NSObject <UIScrollViewDelegate> {
    UIScrollView *_scrollView;
    NSMutableArray *_flipArray;
    UIPageControl *_pageControl;
    BOOL _pageControlUsed;
    UIView *_superView;
}

- (UIScrollView *)getScrollView;
- (id)initWithSuperView:(UIView *)view;
- (void)setHide:(BOOL)value;
@end
