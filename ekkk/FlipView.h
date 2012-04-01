//
//  FlipView.h
//  ekkk
//
//  Created by 卞 中杰 on 12-4-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlipView : UIView {
    UIImageView *_imageView;
    NSInteger _page;
}

- (id)initWithPageNumber:(NSInteger)page;
- (void)setImage:(UIImage *)image;
- (UIImageView *)imageView;
@end
