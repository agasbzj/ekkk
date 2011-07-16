//
//  UserInfoView.m
//  ekkk
//
//  Created by 卞 中杰 on 11-6-10.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "UserInfoView.h"


@implementation UserInfoView
@synthesize userName = _userName;

- (id)initWithFrame:(CGRect)frame user:(NSString *)name
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 320, 60)];
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.font = [UIFont boldSystemFontOfSize:20];
        nameLabel.textAlignment = UITextAlignmentCenter;
        _userName = name;
        nameLabel.text = [NSString stringWithFormat:@"欢迎您：%@", _userName];
        [self addSubview:nameLabel];
        [nameLabel release];
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
//    [_userName release];
    [super dealloc];
}

@end
