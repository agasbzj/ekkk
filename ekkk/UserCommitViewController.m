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
            _environmentLabel.text = [NSString stringWithFormat:@"%d", (int)slider.value];
            break;
        case 2:
            _serviceLabel.text = [NSString stringWithFormat:@"%d", (int)slider.value];
            break;
        case 3:
            _discountLabel.text = [NSString stringWithFormat:@"%d", (int)slider.value];
            break;
        case 4:
            _generalLabel.text = [NSString stringWithFormat:@"%d", (int)slider.value];
            break;
        default:
            break;
    }
}

- (void)commit {
    
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navigationItem setTitle:@"请您点评"];
    
    UIBarButtonItem *commitBtn = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStyleBordered target:self action:@selector(commit)];
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

@end
