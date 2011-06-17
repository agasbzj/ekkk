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

static NSInteger kItemIndex = 0;
static UIProgressView *kProgressView = nil;

// called after this controller's view was dismissed, covered or otherwise hidden
- (void)viewWillDisappear:(BOOL)animated
{		
	// restore the nav bar and status bar color to default
	self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
//	[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackOpaque;
    [super viewWillDisappear:animated];
}

// called after this controller's view will appear
- (void)viewWillAppear:(BOOL)animated
{		
	// for aesthetic reasons (the background is black), make the nav bar black for this particular page
	self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
	
	// match the status bar with the nav bar
//	[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackTranslucent;
    
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

- (void)reflashArrayWithButton:(id)sender {
    UIBarButtonItem *button = (UIBarButtonItem *)sender;
    NSInteger maxCount = [_itemAnnotations count];
    float fMaxCount = 10.f / (float)maxCount;
    if (maxCount <= 10) {
        return;
    }
    switch (button.tag) {
        case 1:
        {
            if (kItemIndex == 0) {
                return;
            }
            kItemIndex--;
            [self.mapView removeAnnotations:self.mapView.annotations];
            [_showItemAnnotations removeAllObjects];
            for (int i = kItemIndex * 10; (i < kItemIndex * 10 + 10) && (i < [_itemAnnotations count]); i++) {
                OneItem *oneItem = [_itemAnnotations objectAtIndex:i];
                ItemAnnotation *item = [[[ItemAnnotation alloc] init] autorelease];
                item.seller = oneItem.seller;
                item.address = oneItem.address;
                item.coordinate = oneItem.coordinate;
                item.theItem = oneItem;
                [_showItemAnnotations addObject:item];
            }
            [self.mapView addAnnotations:_showItemAnnotations];
            kProgressView.progress -= fMaxCount;
            break;
        }
        case 2:
        {    
            if (kItemIndex == [_itemAnnotations count] / 10) {
                return;
            }
            kItemIndex++;
            [self.mapView removeAnnotations:self.mapView.annotations];
            [_showItemAnnotations removeAllObjects];
            for (int i = kItemIndex * 10; (i < kItemIndex * 10 + 10) && (i < [_itemAnnotations count]); i++) {
                OneItem *oneItem = [_itemAnnotations objectAtIndex:i];
                ItemAnnotation *item = [[[ItemAnnotation alloc] init] autorelease];
                item.seller = oneItem.seller;
                item.address = oneItem.address;
                item.coordinate = oneItem.coordinate;
                item.theItem = oneItem;
                [_showItemAnnotations addObject:item];

            }
            [self.mapView addAnnotations:_showItemAnnotations];
            kProgressView.progress += fMaxCount;
            break;
        }
            
        default:
            break;
    }
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
    
    NSInteger maxCount = [_itemAnnotations count];
    
    UISegmentedControl *seg = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:NSLocalizedString(@"Map", @"Map"), NSLocalizedString(@"Satellite", @"Satellite"), nil]];
    [seg addTarget:self action:@selector(setMapStyle:) forControlEvents:UIControlEventValueChanged];
    seg.segmentedControlStyle = UISegmentedControlStyleBar;
    seg.selectedSegmentIndex = 0;
    
    UIBarButtonItem *segItem = [[UIBarButtonItem alloc] initWithCustomView:seg];
    [seg release];
    self.navigationItem.rightBarButtonItem = segItem;
    [segItem release];
    
//    self.navigationItem.prompt = @"点击图钉以显示详细信息";
    
    self.navigationItem.title = _theItem.seller;
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    
    if (_showMultiItems) {
        UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 436, 320, 44)];
        toolBar.barStyle = UIBarStyleBlackTranslucent;
        
        UIBarButtonItem *last = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Last 10", @"Last 10") style:UIBarButtonItemStyleBordered target:self action:@selector(reflashArrayWithButton:)];
        last.tag = 1;
        
        UIBarButtonItem *flexLeft = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
//        UIBarButtonItem *info = [[UIBarButtonItem alloc] initWithTitle:[NSString stringWithFormat:@"显示第1～%d个", [_itemAnnotations count] > 10 ? 10 : [_itemAnnotations count]] style:UIBarButtonItemStylePlain target:self action:nil];
        
        UIProgressView *progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];
        progressView.progress = (10.f / (float)maxCount) >= 1 ? 1.f : (10.f / (float)maxCount);
        kProgressView = progressView;
        UIBarButtonItem *progressItem = [[UIBarButtonItem alloc] initWithCustomView:progressView];
        [progressView release];
        
        
        UIBarButtonItem *flexRight = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
        UIBarButtonItem *next = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Next 10", @"Next 10") style:UIBarButtonItemStyleBordered target:self action:@selector(reflashArrayWithButton:)];
        next.tag = 2;
        
        [toolBar setItems:[NSArray arrayWithObjects:last, flexLeft, progressItem, flexRight, next, nil] animated:YES];
        [self.mapView addSubview:toolBar];
        
        [toolBar release];
        [last release];
        [flexRight release];
//        [info release];
        [progressItem release];
        [flexLeft release];
        [next release];
    }
    
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
                                               initWithAnnotation:annotation reuseIdentifier:nil] autorelease];
        customPinView.pinColor = MKPinAnnotationColorRed;
        customPinView.canShowCallout = YES;
        customPinView.animatesDrop = YES;
        
        // add a detail disclosure button to the callout which will open a new view controller page
        //
        // note: you can assign a specific call out accessory view, or as MKMapViewDelegate you can implement:
        //  - (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control;
        //
        if (_showMultiItems) {
            UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            customPinView.rightCalloutAccessoryView = rightButton;
        }
        else 
            customPinView.animatesDrop = YES;


        return customPinView;
    }
    else
    {
        pinView.annotation = annotation;
    }
    return pinView;
}


@end
