//
//  OneItem.m
//  ekkk
//
//  Created by 卞 中杰 on 11-3-27.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "OneItem.h"


@implementation OneItem
@synthesize city, area, categoryCoarse, categoryFine, seller, discount, details, startDate, endDate, descriptions, comment, telephone, address, latitude, longitude, coordinate;

+ (NSSet *)keyPathsForValuesAffectingCoordinate
{
    return [NSSet setWithObjects:@"latitude", @"longitude", nil];
}

- (CLLocationCoordinate2D)coordinate
{
    coordinate.latitude = self.latitude.doubleValue;
    coordinate.longitude = self.longitude.doubleValue;
    return coordinate;
}

- (id)init {
    if ((self = [super init])) {
        [self coordinate];
    }
    return self;
}

- (void)dealloc{
    [city release];
    [area release];
    [categoryFine release];
    [categoryCoarse release];
    [seller release];
    [discount release];
    [details release];
    [startDate release];
    [endDate release];
    [descriptions release];
    [comment release];
    [telephone release];
    [latitude release];
    [longitude release];
    [address release];
    
    [super dealloc];
}
@end
