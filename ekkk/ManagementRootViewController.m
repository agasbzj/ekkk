//
//  ManagementRootViewController.m
//  ekkk
//
//  Created by 卞 中杰 on 11-4-23.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "ManagementRootViewController.h"
#import "BankSelectViewController.h"
#import "ekkkAppDelegate.h"
#import "ShowMyCardsViewController.h"

@implementation ManagementRootViewController

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
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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



- (IBAction)editMyCards:(id)sender {
    BankSelectViewController *bankSelectViewController = [[BankSelectViewController alloc] init];
    ekkkAppDelegate *ekkkDele = (ekkkAppDelegate *)[[UIApplication sharedApplication] delegate];

    bankSelectViewController.delegate = ekkkDele;
    
    //已保存的数据复制一份来进行修改
    bankSelectViewController.userArray = ekkkDele.userCardsArray;
    bankSelectViewController.readyToWriteArray = [[NSMutableArray alloc] initWithArray:bankSelectViewController.userArray copyItems:YES];
    [self presentModalViewController:bankSelectViewController animated:YES];
    [bankSelectViewController release];
}

- (IBAction)showMyCards:(id)sender {
    ShowMyCardsViewController *showController = [[ShowMyCardsViewController alloc] init];
    ekkkAppDelegate *ekkkDele = (ekkkAppDelegate *)[[UIApplication sharedApplication] delegate];
    showController.dataArray = ekkkDele.userCardsArray;
    [self presentModalViewController:showController animated:YES];
    [showController release];
}

@end
