//
//  LoginAndRegisterView.m
//  ekkk
//
//  Created by 卞 中杰 on 11-6-10.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "LoginAndRegisterView.h"
#import "RegisterViewController.h"

@implementation LoginAndRegisterView
@synthesize tableView = _tableView;
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 240) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.bounces = NO;
        [self addSubview:_tableView];
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
    [_tableView release];
    [super dealloc];
}

- (void)hideKeyboard {
    [self becomeFirstResponder];
}

#pragma mark - tableView Delegate
#pragma mark - TableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 2;
            break;
        case 1:
            return 1;
            break;
        default:
            return 0;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger section = [indexPath section];
    NSUInteger row = [indexPath row];
    
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {

        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    if (section == 0) {
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(20, 0, 280, 44)];

        textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        textField.borderStyle = UITextBorderStyleNone;
        textField.backgroundColor = [UIColor clearColor];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.keyboardAppearance = UIKeyboardAppearanceAlert;
        textField.returnKeyType = UIReturnKeyDone;
        [textField addTarget:self action:@selector(hideKeyboard) forControlEvents:UIControlEventEditingDidEndOnExit];
        switch (row) {
            case 0:
                textField.placeholder = @"请输入用户名";
                break;
            case 1:
                textField.placeholder = @"请输入密码";
                textField.secureTextEntry = YES;
                break;
            default:
                break;
        }
        [cell.contentView addSubview:textField];
        [textField release];
        
    }
    else if (section == 1) {
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
        cell.textLabel.textColor = [UIColor blueColor];
        cell.textLabel.text = @"创建新帐户";
        cell.textLabel.textAlignment = UITextAlignmentLeft;
        UIFont *font = [UIFont systemFontOfSize:14];
        cell.textLabel.font = font;
        
    }

    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"用户登录：";
            break;
        case 1:
            return @"用户注册：";
            break;
        default:
            return nil;
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section == 0) {
        //        [_tableView deselectRowAtIndexPath:indexPath animated:YES];
        
    }
    
    if (indexPath.section == 1) {

        [delegate pushRegisterViewController];
    }
    
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];

}

@end
