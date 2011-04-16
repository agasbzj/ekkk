//
//  MapViewController.h
//  ekkk
//
//  Created by Wu Jianjun on 11-4-5.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "OneItem.h"
#import "ItemAnnotation.h"
@interface MapViewController : UIViewController <MKMapViewDelegate, MKAnnotation> {
    MKMapView *_mapView;
    UINavigationItem *_navItem;
    OneItem *_theItem;
    ItemAnnotation *_itemAnnotation;
}
@property (nonatomic, retain) IBOutlet MKMapView *mapView;
@property (nonatomic, retain) IBOutlet UINavigationItem *navItem;
@property (nonatomic, retain) ItemAnnotation *itemAnnotation;
@property (nonatomic, retain) OneItem *theItem;

- (IBAction)setMapStyle:(id)sender;
- (IBAction)back:(id)sender;
- (void)startLocating:(OneItem *)item;
@end
