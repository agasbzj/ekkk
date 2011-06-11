//
//  MapViewController.m
//  ekkk
//
//  Created by Wu Jianjun on 11-4-5.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "MapViewController.h"
#import "DetailController.h"

@implementation MapViewController
@synthesize mapView = _mapView;
@synthesize theItem = _theItem;
@synthesize itemAnnotations = _itemAnnotations;
@synthesize showItemAnnotations = _showItemAnnotations;
@synthesize itemAnnotation = _itemAnnotation;
@synthesize showMultiItems = _showMultiItems;

#pragma mark UIViewController delegate methods

static NSInteger kItemIndex = -1;

// called after this controller's view was dismissed, covered or otherwise hidden
- (void)viewWillDisappear:(BOOL)animated
{		
	// restore the nav bar and status bar color to default
	self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
	[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackOpaque;
    [super viewWillDisappear:animated];
}

// called after this controller's view will appear
- (void)viewWillAppear:(BOOL)animated
{		
	// for aesthetic reasons (the background is black), make the nav bar black for this particular page
	self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
	
	// match the status bar with the nav bar
	[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackTranslucent;
    
    if (_showMultiItems == NO) {
        self.navigationItem.title = _theItem.seller;
    }
    [super viewWillAppear:animated];
}

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

- (void)gotoLocation
{
    // start off by default in San Francisco
    MKCoordinateRegion newRegion;
    newRegion.center.latitude = 37.786996;
    newRegion.center.longitude = -122.440100;
    newRegion.span.latitudeDelta = 0.112872;
    newRegion.span.longitudeDelta = 0.109863;
    
    [self.mapView setRegion:newRegion animated:YES];
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
        item.theItem = theItem;
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
    
//    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(back:)];
//    self.navigationItem.leftBarButtonItem = backButton;
//    [backButton release];
    
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



#pragma mark -
#pragma mark MKMapViewDelegate

//点击了一个大头针的详细标记后，切换到对应item的detail页面。
- (void)showDetailWithItem:(OneItem *)theItem {
    NSLog(@"Annotation Detail Tapped!");


    DetailController *detailController = [[DetailController alloc] init];
    detailController.oneItem = theItem;
    [self.navigationController pushViewController:detailController animated:YES];
    [detailController release];

}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    DetailController *detailController = [[DetailController alloc] init];
    ItemAnnotation *itemAnnotation = view.annotation;
    detailController.oneItem = itemAnnotation.theItem;
    [self.navigationController pushViewController:detailController animated:YES];
    [detailController release];
}

- (MKAnnotationView *)mapView:(MKMapView *)theMapView viewForAnnotation:(id <MKAnnotation>)annotation {
    // try to dequeue an existing pin view first
    static NSString* AnnotationIdentifier = @"AnnotationIdentifier";
    MKPinAnnotationView* pinView = (MKPinAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationIdentifier];
    if (!pinView)
    {
        // if an existing pin view was not available, create one
        MKPinAnnotationView* customPinView = [[[MKPinAnnotationView alloc]
                                               initWithAnnotation:annotation reuseIdentifier:AnnotationIdentifier] autorelease];
        customPinView.pinColor = MKPinAnnotationColorRed;
        customPinView.animatesDrop = YES;
        customPinView.canShowCallout = YES;
        
        // add a detail disclosure button to the callout which will open a new view controller page
        //
        // note: you can assign a specific call out accessory view, or as MKMapViewDelegate you can implement:
        //  - (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control;
        //
        if (_showMultiItems) {
            UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
//            [rightButton addTarget:self
//                            action:@selector(showDetailWithItem:)
//                  forControlEvents:UIControlEventTouchUpInside];
            customPinView.rightCalloutAccessoryView = rightButton;
        }

        
        return customPinView;
    }
    else
    {
        pinView.annotation = annotation;
    }
    return pinView;
}


@end
