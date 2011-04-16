//
//  ItemAnnotation.m
//  ekkk
//
//  Created by 卞 中杰 on 11-4-16.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "ItemAnnotation.h"


@implementation ItemAnnotation
@synthesize seller = _seller;
@synthesize address = _address;
@synthesize coordinate;


- (void)dealloc {
    [_seller release];
    [_address release];
    [super dealloc];
}

#pragma mark - Delegate
- (NSString *)title {
    return _seller;
}
- (NSString *)subtitle {
    return _address;   
}

- (CLLocationCoordinate2D)coordinate
{
    return coordinate;
}
@end
