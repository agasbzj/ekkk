//
//  DetailFooterView.m
//  ekkk
//
//  Created by Wu Jianjun on 11-4-30.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "DetailFooterView.h"


@implementation DetailFooterView
@synthesize textView = _textView;
@synthesize label = _label;
@synthesize leftButton = _leftButton;
@synthesize rightButton = _rightButton;
@synthesize delegate;

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
    [_leftButton release];
    [_rightButton release];
    [_textView release];
    [_label release];
    [super dealloc];
}

- (IBAction)shareButton:(id)sender
{
    [delegate shareButtonPressed];

}

- (IBAction)commitButton:(id)sender
{
    [delegate commitButtonPressed];
    
}

@end
