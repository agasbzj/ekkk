//
//  OneItem.m
//  ekkk
//
//  Created by 卞 中杰 on 11-3-27.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "OneItem.h"


@implementation OneItem
@synthesize city, location, categoryCoarse, categoryFine, seller, discount, startDate, endDate, details, comment, telephone, latitude, longitude;

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

- (void)dealloc{
    [city release];
    [location release];
    [categoryFine release];
    [categoryCoarse release];
    [seller release];
    [discount release];
    [startDate release];
    [endDate release];
    [details release];
    [comment release];
    [telephone release];
    [latitude release];
    [longitude release];
    [super dealloc];
}
@end
