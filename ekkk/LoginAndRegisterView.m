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
@synthesize userTextField = _userTextField;
@synthesize passTextField = _passTextField;

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
//    [_userTextField release];
//    [_passTextField release];
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
                _userTextField = textField;
                textField.tag = 1;
                textField.placeholder = NSLocalizedString(@"Type User Name", @"Type User Name");
                break;
            case 1:
                _passTextField = textField;
                textField.tag = 2;
                textField.placeholder = NSLocalizedString(@"Type Password", @"Type Password");
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
        cell.textLabel.text = NSLocalizedString(@"Create An Account", @"Create An Account");
        cell.textLabel.textAlignment = UITextAlignmentLeft;
        UIFont *font = [UIFont systemFontOfSize:14];
        cell.textLabel.font = font;
        
    }

    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return NSLocalizedString(@"User Sign In", @"User Sign In");
            break;
        case 1:
            return NSLocalizedString(@"Sign Up", @"User Sign Up");
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
