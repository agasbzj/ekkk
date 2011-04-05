//
//  LocateOperation.m
//  ekkk
//
//  Created by 卞 中杰 on 11-4-5.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "LocateOperation.h"


@implementation LocateOperation
@synthesize locationManager;

- (id)init {
    if ((self = [super init])) {
        
    }
    return self;
}

- (void)main {
    [self startStandardUpdates];
    
}

- (void)startStandardUpdates
{
    // Create the location manager if this object does not
    // already have one.
    if (nil == locationManager)
        locationManager = [[CLLocationManager alloc] init];
    
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    // Set a movement threshold for new events.
    locationManager.distanceFilter = kCLHeadingFilterNone;
    
    [locationManager startUpdatingLocation];
}
     
 - (void)locationManager:(CLLocationManager *)manager
 didUpdateToLocation:(CLLocation *)newLocation
 fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"latitude %+.6f, longitude %+.6f\n",
          newLocation.coordinate.latitude,
          newLocation.coordinate.longitude);
    // If it's a relatively recent event, turn off updates to save power
    NSDate* eventDate = newLocation.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    if (abs(howRecent) < 15.0)
    {
        NSLog(@"latitude %+.6f, longitude %+.6f\n",
              newLocation.coordinate.latitude,
              newLocation.coordinate.longitude);
    }
    // else skip the event and process the next one.
}
@end
