//
//  InterconnectWithServer.m
//  ekkk
//
//  Created by 卞 中杰 on 11-4-5.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "InterconnectWithServer.h"


@implementation InterconnectWithServer
@synthesize latitude;
@synthesize longitude;

- (id)initWithCoordinate:(NSDictionary *)dictionary {
    if ((self = [super init])) {
        self.latitude = [dictionary valueForKey:@"latitude"];
        self.longitude = [dictionary valueForKey:@"longitude"];
    }
    return self;
}

- (void)main {
    

}
@end
