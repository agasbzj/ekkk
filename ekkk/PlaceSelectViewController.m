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
#import "LocateAndDownload.h"

@implementation PlaceSelectViewController

@synthesize mapView = _mapView;
@synthesize searchBar = _searchBar;
@synthesize searchString = _searchString;
@synthesize delegate;
@synthesize segmentedControl = _segmentedControl;
@synthesize selectBaseView = _selectBaseView;
@synthesize nearbyButton = _nearbyButton;

static NSString *kGoogleGeoApi = @"http://maps.google.com/maps/api/geocode/json?address=";
static NSString *kGoogleDecApi = @"http://maps.google.com/maps/api/geocode/json?latlng=";
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
    [_segmentedControl release];
    [_selectBaseView release];
//    [_nearbyButton release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)mapLongPressed:(UILongPressGestureRecognizer *)touch {
    if (_segmentedControl.selectedSegmentIndex == 1) {
        return;
    }
    CGPoint touchPoint = [touch locationInView:_mapView];
    PlaceAnnotation *anno = [[PlaceAnnotation alloc] init];
    anno.title = NSLocalizedString(@"User Selected Place", @"User Selected Place");
    anno.subtitle = @"";
    anno.coordinate = [_mapView convertPoint:touchPoint toCoordinateFromView:_mapView];
    [_mapView removeAnnotations:_mapView.annotations];
    [_mapView addAnnotation:anno];
}

- (void)switchSelectMode {
    switch (_segmentedControl.selectedSegmentIndex) {
        case 0:
        {   
            self.navigationItem.prompt = NSLocalizedString(@"Please Long Press A Point On The Map", @"Long Press On The Map");
            [_searchBar resignFirstResponder];
            _searchBar.hidden = YES;
            break;
        }
        case 1:
        {   
            self.navigationItem.prompt = nil;
            _searchBar.hidden = NO;
            break;
        }
        default:
            break;
    }
}

//按下附近按钮，还原备份数据，当前数据为附近的数据
- (IBAction)nearbyButtonPressed:(id)sender {
    LocateAndDownload *lAndD = [[LocateAndDownload alloc] init];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfURL:[lAndD itemBackupDataFilePath]];
    [dic writeToURL:[lAndD itemDataFilePath] atomically:YES];
    [[ekkkManager sharedManager] setSelectedPlace:NSLocalizedString(@"Nearby", @"Nearby")];
    [self.navigationController popViewControllerAnimated:YES];
//    [lAndD release];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UILongPressGestureRecognizer *tgr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(mapLongPressed:)];
    [_mapView addGestureRecognizer:tgr];
    [tgr release];
    
    
    _segmentedControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects: NSLocalizedString(@"Appoint", @"Appoint"), NSLocalizedString(@"Search", @"Search"), nil]];
    [_segmentedControl addTarget:self action:@selector(switchSelectMode) forControlEvents:UIControlEventValueChanged];
    _segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
    _segmentedControl.selectedSegmentIndex = 0;
    UIBarButtonItem *segItem = [[UIBarButtonItem alloc] initWithCustomView:_segmentedControl];
    self.navigationItem.rightBarButtonItem = segItem;
    [segItem release];
    
    
    [_nearbyButton setTitle:NSLocalizedString(@"Nearby", @"Nearby") forState:UIControlStateNormal];
//    UIButton *nearbyBtn = [[UIButton alloc] initWithFrame:CGRectMake(200, 200, 85, 37)];
//    [nearbyBtn setTitle:NSLocalizedString(@"Nearby", @"Nearby") forState:UIControlStateNormal];
//    [nearbyBtn addTarget:self action:@selector(nearbyButtonPressed) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:nearbyBtn];
//    [nearbyBtn release];
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
	self.navigationController.navigationBar.translucent = YES;
    [self.navigationItem setTitle:NSLocalizedString(@"Appoint", @"Appoint")];
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent];
    self.searchBar.placeholder = NSLocalizedString(@"Type An Address To Search", @"Type An Address To Search");
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
	self.navigationController.navigationBar.translucent = NO;
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];

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
    if (_segmentedControl.selectedSegmentIndex == 1) {
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
        [ekkkManager sharedManager].selectedPlace = kSelectedAnnotation.title;
        NSNumber *latitude = [NSNumber numberWithDouble:kSelectedAnnotation.coordinate.latitude];
        NSNumber *longitude = [NSNumber numberWithDouble:kSelectedAnnotation.coordinate.longitude];
        
        //如果是用户在地图上长按来选择地点，则反向解析，获取城市／省名
        if (_segmentedControl.selectedSegmentIndex == 0) {
            NSMutableString *url = [NSMutableString stringWithString:kGoogleDecApi];
            [url appendString:[NSString stringWithFormat:@"%@,%@&language=zh-CN&sensor=true", latitude, longitude]];
            
            NSLog(@"%@", url);
            ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
            [request startSynchronous];
            
            NSError *error = [request error];
            if (!error) {
                NSString *responseString = [request responseString];
                NSLog(@"%@", responseString);
                NSData *responseData = [request responseData];
                NSDictionary *dict = [[CJSONDeserializer deserializer] deserializeAsDictionary:responseData error:NULL];
                [dict writeToURL:[self itemDataFilePath] atomically:YES];
            }
        }
        
        NSLog(@"lat:%lf, lon:%lf, city:%@", kSelectedAnnotation.coordinate.latitude, kSelectedAnnotation.coordinate.longitude, kSelectedAnnotation.city);
        NSLog(@"ekkk:%@", [ekkkManager sharedManager].selectedPlace);
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:latitude, @"latitude", longitude, @"longitude", nil];
        
        LocateAndDownload *locate = [[LocateAndDownload alloc] init];
        [locate downloadInfoWithCoordinate:dic];
        
        [self.navigationController popViewControllerAnimated:YES];
//        [locate release];
    }

}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    kSelectedAnnotation = view.annotation;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Place Selection", @"Place Selection") message:NSLocalizedString(@"Are you sure about the place?", @"Are You Sure About The Place?") delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", @"Cancel") otherButtonTitles:NSLocalizedString(@"OK", @"OK"), nil];
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
                                               initWithAnnotation:annotation reuseIdentifier:nil] autorelease];
        pinView.pinColor = MKPinAnnotationColorRed;
        pinView.canShowCallout = YES;
        pinView.animatesDrop = YES;
        
        if (_segmentedControl.selectedSegmentIndex == 0) {
            pinView.pinColor = MKPinAnnotationColorPurple;
        }
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
