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
@synthesize parseOperation;

- (id)initWithCoordinate:(NSDictionary *)dictionary {
    if ((self = [super init])) {
        self.latitude = [dictionary valueForKey:@"latitude"];
        self.longitude = [dictionary valueForKey:@"longitude"];
    }
    return self;
}

- (void)main {
    //于服务器交互完毕开始解析获得的xml文件
    //打开状态栏网络提示
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    parseOperation = [[ParseOperation alloc] init];

}

- (void)dealloc {
    [parseOperation release];
    [super dealloc];
}
@end
