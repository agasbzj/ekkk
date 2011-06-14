//
//  GoogleApi.m
//  ekkk
//
//  Created by 卞中杰 on 11-6-14.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "GoogleApi.h"
#import "ASIHTTPRequest.h"
#import "CJSONDeserializer.h"

@implementation GoogleApi
@synthesize placeDecoded = _placeDecoded;

- (id)init {
    if ((self = [super init])) {
        
    }
    return self;
}

- (void)dealloc {
    [_placeDecoded release];
    [super dealloc];
}

- (NSDictionary *)decodePlacesWithJson:(NSData *)jsonData {
    NSDictionary *dict = [[CJSONDeserializer deserializer] deserializeAsDictionary:jsonData error:NULL];
    return dict;
}
@end
