//
//  RatingView.h
//  ekkk
//
//  Created by Wu Jianjun on 11-4-15.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RatingView : UIView
{
    float rating;
    UIImageView *backgroundImageView;
    UIImageView *foregroundImageView;
}

@property float rating;

@end
