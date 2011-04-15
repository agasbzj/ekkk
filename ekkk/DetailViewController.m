//
//  DetailViewController.m
//  ekkk
//
//  Created by Wu Jianjun on 11-4-5.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"

@implementation DetailViewController
@synthesize oneItem = _oneItem;
@synthesize address = _address;
@synthesize category_Fine = _category_Fine;
@synthesize comments_Discount = _comments_Discount;
@synthesize comments_Enviroment = _comments_Enviroment;
@synthesize comments_General = _comments_General;
@synthesize comments_Service = _comments_Service;
@synthesize seller = _seller;
@synthesize telephone = _telephone;

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
    [_oneItem release];
    [_address release];;
    [_comments_Service release];
    [_comments_General release];
    [_comments_Discount release];
    [_comments_Enviroment release];
    [_telephone release];
    [_seller release];
    [_category_Fine release];
    
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
    _address.text = _oneItem.address;
    _telephone.text = _oneItem.telephone;
    _comments_Discount.text = _oneItem.comments_Discount;
    _comments_General.text = _oneItem.comments_General;
    _comments_Service.text = _oneItem.comments_Service;
    _comments_Enviroment.text = _oneItem.comments_Enviroment;
    _seller.text = _oneItem.seller;
    _category_Fine.text = _oneItem.category_Fine;
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
