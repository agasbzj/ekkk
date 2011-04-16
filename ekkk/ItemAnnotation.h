//
//  ItemAnnotation.h
//  ekkk
//
//  Created by 卞 中杰 on 11-4-16.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MKAnnotation.h>

@interface ItemAnnotation : NSObject <MKAnnotation>{
    CLLocationCoordinate2D coordinate;
    NSString *_seller;
    NSString *_address;
}

@property (nonatomic, retain) NSString *seller;
@property (nonatomic, retain) NSString *address;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

@end
