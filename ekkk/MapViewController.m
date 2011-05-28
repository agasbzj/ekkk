//
//  MapViewController.m
//  ekkk
//
//  Created by Wu Jianjun on 11-4-5.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "MapViewController.h"


@implementation MapViewController
@synthesize mapView = _mapView;
@synthesize theItem = _theItem;
@synthesize itemAnnotations = _itemAnnotations;
@synthesize showItemAnnotations = _showItemAnnotations;
@synthesize itemAnnotation = _itemAnnotation;
@synthesize showMultiItems = _showMultiItems;
//切换地图模式
- (IBAction)setMapStyle:(id)sender {
    switch (((UISegmentedControl *)sender).selectedSegmentIndex) {
        case 0:
        {
            _mapView.mapType = MKMapTypeStandard;
            break;
        } 
        case 1:
        {
            _mapView.mapType = MKMapTypeSatellite;
            break;
        
        }
        default:
            break;
    }
}

- (IBAction)back:(id)sender {
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)startLocating:(OneItem *)item {
    MKCoordinateRegion current = _mapView.region;
    if (current.span.latitudeDelta < 10)
    {
        [self performSelector:@selector(animateToWorld:) withObject:item afterDelay:0.3];
        [self performSelector:@selector(animateToPlace:) withObject:item afterDelay:1.7];        
    }
    else
    {
        [self performSelector:@selector(animateToPlace:) withObject:item afterDelay:0.3];        
    }
}

- (void)animateToWorld:(OneItem *)item
{    
    MKCoordinateRegion current = _mapView.region;
    MKCoordinateRegion zoomOut = { { (current.center.latitude + item.coordinate.latitude)/2.0 , (current.center.longitude + item.coordinate.longitude)/2.0 }, {90, 90} };
    [_mapView setRegion:zoomOut animated:YES];
}

- (void)animateToPlace:(OneItem *)item
{
    MKCoordinateRegion region;
    region.center = item.coordinate;
    MKCoordinateSpan span = {0.5, 0.5}; //缩放大小
    region.span = span;
    [_mapView setRegion:region animated:YES];
    
}

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
    [_itemAnnotations release];
    [_showItemAnnotations release];
    [_mapView release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

//定位一个位置
- (void)locateOnePlace {
    [self startLocating:_theItem];
    _itemAnnotation = [[ItemAnnotation alloc] init];
    _itemAnnotation.seller = _theItem.seller;
    _itemAnnotation.address = _theItem.address;
    _itemAnnotation.coordinate = _theItem.coordinate;
    [self.mapView addAnnotation:_itemAnnotation];
//    [self.mapView selectAnnotation:_itemAnnotation animated:YES];
}

//定位多个位置
- (void)locationPlaces {
    _showItemAnnotations = [[NSMutableArray alloc] initWithCapacity:20];
    for (OneItem *theItem in _itemAnnotations) {
        ItemAnnotation *item = [[[ItemAnnotation alloc] init] autorelease];
        item.seller = theItem.seller;
        item.address = theItem.address;
        item.coordinate = theItem.coordinate;
        [_showItemAnnotations addObject:item];
    }
    [self.mapView addAnnotations:_showItemAnnotations];
}
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if (_showMultiItems == YES) {
        [self locationPlaces];
    }
    else
        [self locateOnePlace];
    
    UISegmentedControl *seg = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"地图", @"卫星", nil]];
    [seg addTarget:self action:@selector(setMapStyle:) forControlEvents:UIControlEventValueChanged];
    seg.segmentedControlStyle = UISegmentedControlStyleBar;
    seg.selectedSegmentIndex = 0;
    
    UIBarButtonItem *segItem = [[UIBarButtonItem alloc] initWithCustomView:seg];
    [seg release];
    self.navigationItem.rightBarButtonItem = segItem;
    [segItem release];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(back:)];
    self.navigationItem.leftBarButtonItem = backButton;
    [backButton release];
    
    self.navigationItem.title = _theItem.seller;
    
//    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    
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
