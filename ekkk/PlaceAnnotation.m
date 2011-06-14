//
//  PlaceAnnotation.m
//  ekkk
//
//  Created by 卞中杰 on 11-6-14.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "PlaceAnnotation.h"


@implementation PlaceAnnotation
@synthesize title = _title;
@synthesize subtitle = _subtitle;
@synthesize city = _city;
@synthesize coordinate;

- (void)dealloc {
    [_title release];
    [_subtitle release];
    [_city release];
    [super dealloc];
}

#pragma mark - Delegate
- (NSString *)title {
    return _title;
}
- (NSString *)subtitle {
    return _subtitle;   
}

- (CLLocationCoordinate2D)coordinate
{
    return coordinate;
}
@end
