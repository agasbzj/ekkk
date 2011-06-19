//
//  PlaceSelectViewController.h
//  ekkk
//
//  Created by 卞中杰 on 11-6-14.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "ASIHTTPRequest.h"
@class PlaceAnnotation;
@protocol PlaceSelectDelegate <NSObject>

- (void)placeSelected:(PlaceAnnotation *)thePlace;

@end
@interface PlaceSelectViewController : UIViewController <MKMapViewDelegate, UISearchBarDelegate> {
    id <PlaceSelectDelegate> delegate;
    
@private
    MKMapView *_mapView;
    UISearchBar *_searchBar;
    NSString *_searchString;
    UISegmentedControl *_segmentedControl;
    UIView *_selectBaseView;
}
@property (nonatomic, retain) IBOutlet MKMapView *mapView;
@property (nonatomic, retain) IBOutlet UISearchBar *searchBar;
@property (nonatomic, retain) NSString *searchString;
@property (nonatomic, retain) UISegmentedControl *segmentedControl;
@property (nonatomic, retain) UIView *selectBaseView;
@property (nonatomic, assign) id <PlaceSelectDelegate> delegate;

@end
