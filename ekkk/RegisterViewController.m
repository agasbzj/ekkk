//
//  RegisterViewController.m
//  ekkk
//
//  Created by 卞 中杰 on 11-6-1.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "RegisterViewController.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

#define REGISTER_URL @"http://xiaochen-shi.com/ckk_forServer/api/register.php"    //注册网址

@implementation RegisterViewController
@synthesize userName = _userName;
@synthesize password = _password;
@synthesize email = _email;
#pragma mark -
#pragma mark UIViewController delegate methods

//用于核对密码
static NSString *confirmPassword = @"";

// called after this controller's view was dismissed, covered or otherwise hidden
//- (void)viewWillDisappear:(BOOL)animated
//{		
//
//    [super viewWillDisappear:animated];
//}

// called after this controller's view will appear
//- (void)viewWillAppear:(BOOL)animated
//{		
//
//    [super viewWillAppear:animated];
//}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
//    [_userName release];
//    [_password release];
//    [_email release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

//- (void)doRegistation {
//    ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:REGISTER_URL]];
//    [request setRequestMethod:@"POST"];
//    [request addRequestHeader:@"user" value:_userName];
//    [request addRequestHeader:@"pass" value:_password];
//    [request addRequestHeader:@"email" value:_email];
//    
//    [request setDelegate:self];
//    NSDictionary *dic = [request responseHeaders];
//    [request startAsynchronous];
//    
//}

- (void)doRegistation {
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:REGISTER_URL]];
    [request setTimeOutSeconds:30];
    [request setRequestMethod:@"POST"];
    [request setPostValue:_userName forKey:@"user"];
    [request setPostValue:_password forKey:@"pass"];
    [request setPostValue:_email forKey:@"email"];
    [request setDelegate:self];
    [request startAsynchronous];
}

#pragma mark - ASIHTTPRequest
- (void)requestFinished:(ASIHTTPRequest *)request {
    NSString *resultStr = [request responseString];
    NSLog(@"Register:%@", resultStr);
}


//注册
- (void)registerButtonPressed {
    _userName = ((UITextField *)[self.view viewWithTag:1]).text;
    _password = ((UITextField *)[self.view viewWithTag:2]).text;
    confirmPassword = ((UITextField *)[self.view viewWithTag:3]).text;
    _email = ((UITextField *)[self.view viewWithTag:4]).text;

    if (![_userName length]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"Type User Name", @"Type User Name") delegate:self cancelButtonTitle:NSLocalizedString(@"OK", @"OK") otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        return;
    }
    else if (![_password length]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"Type Password", @"Please Type Password") delegate:self cancelButtonTitle:NSLocalizedString(@"OK", @"OK") otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        return;
    }
    else if (![confirmPassword length]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"Confirm Password", @"Confirm Password") delegate:self cancelButtonTitle:NSLocalizedString(@"OK", @"OK") otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        return;
    }
    else if (![_email length]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"Type Email", @"Type Email") delegate:self cancelButtonTitle:NSLocalizedString(@"OK", @"OK") otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        return;
    }
    else if ([_password isEqualToString:confirmPassword] == NO) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"Password Dosen't Match", @"Password Dosen't Match") delegate:self cancelButtonTitle:NSLocalizedString(@"OK", @"OK") otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        return;
    }
    //注册流程
    else {
        NSLog(@"ID:%@\nPass:%@\nEmail:%@", _userName, _password, _email);
        [self doRegistation];
    }
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 70)];
    footerView.backgroundColor = [UIColor clearColor];
    UIButton *registerButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, 300, 50)];
    
    [registerButton setTitle:NSLocalizedString(@"Sign Up!", @"Sign Up!") forState:UIControlStateNormal];
    [registerButton addTarget:self action:@selector(registerButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    UIImage *oriImage = [UIImage imageNamed:@"blueButton.png"];
    UIImage *stretchableButtonImage = [oriImage stretchableImageWithLeftCapWidth:12 topCapHeight:0];
    [registerButton setBackgroundImage:stretchableButtonImage forState:UIControlStateNormal];
    [footerView addSubview:registerButton];
    [self.tableView setTableFooterView:footerView];
    [registerButton release];
    [footerView release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationItem.title = NSLocalizedString(@"Sign Up", @"User Sign Up");
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)hideKeyboard {
    [self.view becomeFirstResponder];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 2;
            break;
        case 2:
            return 1;
            break;
        default:
            return 0;
            break;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return NSLocalizedString(@"User Name", @"User Name");
            break;
        case 1:
            return NSLocalizedString(@"Password", @"Password");
            break;
        case 2:
            return NSLocalizedString(@"Email", @"Email");
            break;
        default:
            return nil;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(20, 0, 280, 44)];

    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField.borderStyle = UITextBorderStyleNone;
    textField.backgroundColor = [UIColor clearColor];
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.keyboardAppearance = UIKeyboardAppearanceAlert;
    textField.returnKeyType = UIReturnKeyDone;
    [textField addTarget:self action:@selector(hideKeyboard) forControlEvents:UIControlEventEditingDidEndOnExit];   
    switch (indexPath.section) {
        case 0:
            textField.keyboardType = UIKeyboardTypeAlphabet;
            textField.tag = 1;
            textField.placeholder = NSLocalizedString(@"User Name Limit", Type User Name 6 ~ 12 Charactors);
            break;
        case 1:
        {
            textField.secureTextEntry = YES;
            textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
            switch (indexPath.row) {
                case 0:
                {
                    textField.tag = 2;
                    textField.placeholder = NSLocalizedString(@"Type Password", @"Type Password");
                    break;
                }
                case 1:
                {
                    textField.tag = 3;
                    textField.placeholder = NSLocalizedString(@"Confirm Password", @"Confirm Password");
                    break;
                }
                default:
                    break;
            }
            break;
        }
        case 2:
        {
            textField.tag = 4;
            textField.keyboardType = UIKeyboardTypeEmailAddress;
            textField.placeholder = NSLocalizedString(@"Type Email", @"Type Email");
            break;
        }
        default:

            break;
    }
    [cell.contentView addSubview:textField];
    [textField release];
    
    // Configure the cell...
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}



@end
