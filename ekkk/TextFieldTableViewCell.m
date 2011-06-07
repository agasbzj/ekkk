//
//  TextFieldTableViewCell.m
//  ekkk
//
//  Created by 卞 中杰 on 11-6-7.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "TextFieldTableViewCell.h"


@implementation TextFieldTableViewCell
@synthesize textField = _textField;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;;
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(20, 0, 280, 44)];
        _textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _textField.borderStyle = UITextBorderStyleNone;
        _textField.backgroundColor = [UIColor clearColor];
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_textField addTarget:self action:@selector(hideKeyboard) forControlEvents:UIControlEventEditingDidEndOnExit];
        [self addSubview:_textField];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc
{
    [_textField release];
    [super dealloc];
}

- (void)hideKeyboard {
    [_textField resignFirstResponder];
}

@end
