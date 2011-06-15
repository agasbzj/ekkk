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
    UILabel *_label;
    UIButton *_leftButton;
    UIButton *_rightButton;
    id <DetailFooterViewDelegate> delegate;
}

@property (nonatomic, retain) IBOutlet UITextView *textView;
@property (nonatomic, retain) IBOutlet UILabel *label;
@property (nonatomic, retain) IBOutlet UIButton *leftButton;
@property (nonatomic, retain) IBOutlet UIButton *rightButton;
@property (nonatomic, assign) id <DetailFooterViewDelegate> delegate;
- (IBAction)shareButton:(id)sender;
- (IBAction)commitButton:(id)sender;
@end
