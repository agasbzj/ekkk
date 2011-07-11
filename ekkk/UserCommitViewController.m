//
//  UserCommitViewController.m
//  ekkk
//
//  Created by 卞中杰 on 11-6-15.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "UserCommitViewController.h"


@implementation UserCommitViewController
@synthesize environmentLabel = _environmentLabel;
@synthesize serviceLabel = _serviceLabel;
@synthesize discountLabel = _discountLabel;
@synthesize generalLabel = _generalLabel;
@synthesize moneyTextField = _moneyTextField;
@synthesize commitTextView = _commitTextView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [_environmentLabel release];
    [_serviceLabel release];
    [_discountLabel release];
    [_generalLabel release];
    [_moneyTextField release];
    [_commitTextView release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (IBAction)backgroundTapped:(id)sender {
    [_moneyTextField resignFirstResponder];
    [_commitTextView resignFirstResponder];
}

- (IBAction)sliderChanged:(id)sender {
    UISlider *slider = (UISlider *)sender;
    switch (slider.tag) {
        case 1:
            _environmentLabel.text = [NSString stringWithFormat:@"%d", (int)(slider.value + 0.5)];
            break;
        case 2:
            _serviceLabel.text = [NSString stringWithFormat:@"%d", (int)(slider.value + 0.5)];
            break;
        case 3:
            _discountLabel.text = [NSString stringWithFormat:@"%d", (int)(slider.value + 0.5)];
            break;
        case 4:
            _generalLabel.text = [NSString stringWithFormat:@"%d", (int)(slider.value + 0.5)];
            break;
        default:
            break;
    }
}


//提交点评！！！
- (void)commit {
    [_moneyTextField resignFirstResponder];
    [_commitTextView resignFirstResponder];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navigationItem setTitle:NSLocalizedString(@"Please Commit This", @"Please Commit")];
    
    UIBarButtonItem *commitBtn = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Commit", @"Commit") style:UIBarButtonItemStyleBordered target:self action:@selector(commit)];
    self.navigationItem.rightBarButtonItem = commitBtn;
    [commitBtn release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - UITextView Delegate

- (void)textViewDidBeginEditing:(UITextView *)textView {
    CGPoint point = self.view.center;
    point.y -= 200;
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationDuration:.3f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self.view cache:YES];
    self.view.transform = CGAffineTransformIdentity;
    self.view.center = point;
    [UIView commitAnimations];
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    CGPoint point = self.view.center;
    point.y += 200;
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationDuration:.3f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self.view cache:YES];
    self.view.transform = CGAffineTransformIdentity;
    self.view.center = point;
    [UIView commitAnimations];
}






#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    CGPoint point = self.view.center;
    point.y -= 50;
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationDuration:.3f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self.view cache:YES];
    self.view.transform = CGAffineTransformIdentity;
    self.view.center = point;
    [UIView commitAnimations];
}


- (void)textFieldDidEndEditing:(UITextField *)textField {
    CGPoint point = self.view.center;
    point.y += 50;
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationDuration:.3f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self.view cache:YES];
    self.view.transform = CGAffineTransformIdentity;
    self.view.center = point;
    [UIView commitAnimations];
}
@end
