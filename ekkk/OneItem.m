//
//  OneItem.m
//  ekkk
//
//  Created by 卞 中杰 on 11-3-27.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "OneItem.h"

@implementation OneItem

@synthesize city,area,category_Coarse,category_Fine,seller,image,details,start_Date,end_Date,comments_Enviroment,comments_Service, comments_Discount, comments_General, telephone, address, www_Address,latitude, longitude, coordinate, hot, bank, card, source,distance;

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
    [category_Fine release];
    [category_Coarse release];
    [seller release];
    [details release];
    [start_Date release];
    [end_Date release];
    [comments_Enviroment release];
    [comments_General release];
    [comments_Discount release];
    [comments_Service release];
    [telephone release];
    [latitude release];
    [longitude release];
    [address release];
    [www_Address release];
    [hot release];
    [image release];
    [bank release];
    [card release];
    [source release];
    [distance release];
    [super dealloc];

}

@end
