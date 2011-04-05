//
//  LocateOperation.h
//  ekkk
//
//  Created by 卞 中杰 on 11-4-5.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface LocateOperation : NSOperation <CLLocationManagerDelegate>{
    CLLocationManager *locationManager;
}
@property (nonatomic, retain) CLLocationManager *locationManager;

- (void)startStandardUpdates;

@end
