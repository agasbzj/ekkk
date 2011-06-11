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
@interface MapViewController : UIViewController <MKMapViewDelegate> {
    MKMapView *_mapView;
    OneItem *_theItem;
    ItemAnnotation *_itemAnnotation;    //显示的单个标记
    BOOL _showMultiItems;    //是否显示多个标记
    NSArray *_itemAnnotations;  //传入的所有标记（OneItem* ）
    NSMutableArray *_showItemAnnotations;   //显示的所有标记
}
@property (nonatomic, retain) IBOutlet MKMapView *mapView;

@property (nonatomic, retain) ItemAnnotation *itemAnnotation;
@property (nonatomic, retain) NSArray *itemAnnotations;
@property (nonatomic, retain) NSMutableArray *showItemAnnotations;
@property (nonatomic, assign) BOOL showMultiItems;
@property (nonatomic, retain) OneItem *theItem;

- (IBAction)setMapStyle:(id)sender;
- (IBAction)back:(id)sender;
- (void)startLocating:(OneItem *)item;
@end
