//
//  PlaceSelectViewController.m
//  ekkk
//
//  Created by 卞中杰 on 11-6-14.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "PlaceSelectViewController.h"
#import "PlaceAnnotation.h"
#import "CJSONDeserializer.h"
#import "GoogleApi.h"

@implementation PlaceSelectViewController

@synthesize mapView = _mapView;
@synthesize searchBar = _searchBar;
@synthesize searchString = _searchString;
@synthesize delegate;

const static NSString *kGoogleGeoApi = @"http://maps.google.com/maps/api/geocode/json?address=";
static PlaceAnnotation *kSelectedAnnotation = nil;

- (NSString *)_encodeString:(NSString *)string
{
    NSString *result = (NSString *)CFURLCreateStringByAddingPercentEscapes(NULL, 
																		   (CFStringRef)string, 
																		   NULL, 
																		   (CFStringRef)@";/?:@&=$+{}<>,",
																		   kCFStringEncodingUTF8);
    return [result autorelease];
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
    [_mapView release];
    [_searchBar release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

//- (void)mapTouched:(UITapGestureRecognizer *)touch {
//    CGPoint touchPoint = [touch locationInView:_mapView];
//    ItemAnnotation *anno = [[ItemAnnotation alloc] init];
//    anno.seller = @"指定的位置";
//    anno.coordinate = [_mapView convertPoint:touchPoint toCoordinateFromView:_mapView];
//    [_mapView addAnnotation:anno];
//}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(mapTouched:)];
//    [_mapView addGestureRecognizer:tgr];
//    [tgr release];
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

#pragma mark - ViewController Delegate
- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    [self.navigationItem setTitle:@"请指定一个位置"];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];

    [super viewWillDisappear:animated];
}

#pragma mark - UISearchBar Delegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    _searchString = _searchBar.text;
    [_searchBar resignFirstResponder];
    NSLog(@"Search:%@", _searchString);
    NSString *searchStr = [self _encodeString:_searchString];
    NSMutableString *url = [NSMutableString stringWithString:kGoogleGeoApi];
    [url appendString:searchStr];
    [url appendString:@"&language=zh-CN&sensor=true"];

    NSLog(@"%@", url);
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
    [request setDelegate:self];
    [request startAsynchronous];
}

- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSURL *)itemDataFilePath {
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"google.plist"];
    NSLog(@"%@", storeURL);
    return storeURL;
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    [self.mapView removeAnnotations:self.mapView.annotations];
    // Use when fetching text data
    NSString *responseString = [request responseString];
    NSLog(@"%@", responseString);
    // Use when fetching binary data
    NSData *responseData = [request responseData];
    NSDictionary *dict = [[CJSONDeserializer deserializer] deserializeAsDictionary:responseData error:NULL];
    [dict writeToURL:[self itemDataFilePath] atomically:YES];
    NSArray *array = [dict valueForKey:@"results"];
    for (NSDictionary *dic in array) {
        
        PlaceAnnotation *anno = [[PlaceAnnotation alloc] init];
        anno.title = [[[dic valueForKey:@"address_components"] objectAtIndex:0] valueForKey:@"long_name"];
        anno.subtitle = [dic valueForKey:@"formatted_address"];
        anno.city = [[[dic valueForKey:@"address_components"] objectAtIndex:1] valueForKey:@"long_name"];
        NSDictionary *loc = [[dic valueForKey:@"geometry"] valueForKey:@"location"];
        anno.coordinate = CLLocationCoordinate2DMake([[loc valueForKey:@"lat"] doubleValue], [[loc valueForKey:@"lng"] doubleValue]);
        [_mapView addAnnotation:anno];
        [anno release];
    }

}

- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar {

}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar {

}

#pragma mark - Touch
//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    UITouch *touch = [touches anyObject];
//    CGPoint touchPoint = [touch locationInView:_mapView];
//    ItemAnnotation *anno = [[ItemAnnotation alloc] init];
//    anno.seller = @"指定的位置";
//    anno.coordinate = [_mapView convertPoint:touchPoint toCoordinateFromView:_mapView];
//    [_mapView addAnnotation:anno];
//}

#pragma mark -
#pragma mark MKMapViewDelegate

//点击了一个大头针的详细标记后，切换到对应item的detail页面。

//传出一个annotation，其中包括坐标和城市名，发送此信息与服务器交互
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [delegate placeSelected:kSelectedAnnotation];
    }
    NSLog(@"lat:%lf, lon:%lf, city:%@", kSelectedAnnotation.coordinate.latitude, kSelectedAnnotation.coordinate.longitude, kSelectedAnnotation.city);
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    kSelectedAnnotation = view.annotation;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"地点选择" message:@"确定选择这个地点吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"好", nil];
    [alert show];
    [alert release];
}

- (MKAnnotationView *)mapView:(MKMapView *)theMapView viewForAnnotation:(id <MKAnnotation>)annotation {
    // try to dequeue an existing pin view first
    static NSString* AnnotationIdentifier = @"AnnotationIdentifier";
    MKPinAnnotationView* pinView = (MKPinAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationIdentifier];
    if (!pinView)
    {
        // if an existing pin view was not available, create one
        pinView = [[[MKPinAnnotationView alloc]
                                               initWithAnnotation:annotation reuseIdentifier:AnnotationIdentifier] autorelease];
        pinView.pinColor = MKPinAnnotationColorRed;
        pinView.canShowCallout = YES;
        pinView.animatesDrop = YES;
        
        // add a detail disclosure button to the callout which will open a new view controller page
        //
        // note: you can assign a specific call out accessory view, or as MKMapViewDelegate you can implement:
        //  - (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control;
        //

        UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        pinView.rightCalloutAccessoryView = rightButton;

    }

    return pinView;
}

@end
