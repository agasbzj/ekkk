//
//  DetailFooterView.h
//  ekkk
//
//  Created by Wu Jianjun on 11-4-30.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DetailFooterViewDelegate 

- (void)shareButtonPressed;     //分享按钮按下
- (void)commitButtonPressed;    //点评按钮按下

@end

@interface DetailFooterView : UIView {
    UITextView *_textView;
    id <DetailFooterViewDelegate> delegate;
    NSString *_detailString;
}

@property (nonatomic, assign) id <DetailFooterViewDelegate> delegate;
@property (nonatomic, retain) NSString *detailString;

- (IBAction)shareButton:(id)sender;
- (IBAction)commitButton:(id)sender;

- (void)configFooterView;
@end
