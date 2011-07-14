//
//  DetailFooterView.m
//  ekkk
//
//  Created by Wu Jianjun on 11-4-30.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "DetailFooterView.h"


@implementation DetailFooterView
@synthesize delegate;
@synthesize detailString = _detailString;

- (void)configFooterView {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 20)];
    label.text = NSLocalizedString(@"Detail Information", @"Detail Information");
    label.textColor = [UIColor whiteColor];
    label.layer.cornerRadius = 3.f;
    label.backgroundColor = [UIColor lightGrayColor];
    label.alpha = .5f;
    [self addSubview:label];
    [label release];
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 45, 300, 100)];
    _textView.userInteractionEnabled = NO;
    CGSize _size = [_detailString sizeWithFont:[UIFont systemFontOfSize:17]];
    int w = _textView.frame.size.width;
    int row = (int)_size.width / w + 1;
    [_textView setFrame:CGRectMake(10, 45, w, row * _size.height + 15)];
    _textView.text = _detailString;
    _textView.textColor = [UIColor whiteColor];
    _textView.font = [UIFont systemFontOfSize:17];
    _textView.backgroundColor = [UIColor clearColor];
    [self addSubview:_textView];
    [_textView release];
    
    UIImage *oriImage = [UIImage imageNamed:@"whiteButton.png"];
    UIImage *stretchableButtonImage = [oriImage stretchableImageWithLeftCapWidth:12 topCapHeight:0];
    
    CGRect leftBtnFrame = CGRectMake(10, _textView.frame.origin.y + _textView.frame.size.height + 10, 130, 37);
    UIButton *commitBtn = [[UIButton alloc] initWithFrame:leftBtnFrame];
    [commitBtn setTitle:NSLocalizedString(@"Commit This", @"Commit This") forState:UIControlStateNormal];
    [commitBtn setBackgroundImage:stretchableButtonImage forState:UIControlStateNormal];
    [commitBtn addTarget:self action:@selector(commitButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:commitBtn];
    [commitBtn release];
    
    CGRect rightBtnFrame = CGRectMake(180, _textView.frame.origin.y + _textView.frame.size.height + 10, 130, 37);
    UIButton *shareBtn = [[UIButton alloc] initWithFrame:rightBtnFrame];
    [shareBtn setTitle:NSLocalizedString(@"Share This", @"Share This") forState:UIControlStateNormal];
    [shareBtn setBackgroundImage:stretchableButtonImage forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(shareButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:shareBtn];
    [shareBtn release];
}

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
    [_detailString release];
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
