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
}

- (UIScrollView *)getScrollView;
@end
