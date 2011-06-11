//
//  ItemAnnotation.h
//  ekkk
//
//  Created by 卞 中杰 on 11-4-16.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//


//地图上的指示器的类

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MKAnnotation.h>

@class OneItem;
@interface ItemAnnotation : NSObject <MKAnnotation>{
    CLLocationCoordinate2D coordinate;
    NSString *_seller;
    NSString *_address;
    OneItem *_theItem;
}

@property (nonatomic, retain) NSString *seller;
@property (nonatomic, retain) NSString *address;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, retain) OneItem *theItem;
@end
