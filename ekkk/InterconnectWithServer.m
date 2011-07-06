//
//  InterconnectWithServer.m
//  ekkk
//
//  Created by 卞 中杰 on 11-4-5.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "InterconnectWithServer.h"
#import "CJSONDeserializer.h"
#import "ASIHTTPRequest.h"

//#define kURL                        @"http://169.254.199.113/ckk/api/info.php?"
#define kURL                        @"http://169.254.199.113/ckk/index.php"


@implementation InterconnectWithServer
@synthesize latitude;
@synthesize longitude;
@synthesize parseOperation;

- (NSString *)_encodeString:(NSString *)string
{
    NSString *result = (NSString *)CFURLCreateStringByAddingPercentEscapes(NULL, 
																		   (CFStringRef)string, 
																		   NULL, 
																		   (CFStringRef)@";/?:@&=$+{}<>,",
																		   kCFStringEncodingUTF8);
    return [result autorelease];
}

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
//    parseOperation = [[ParseOperation alloc] init];
//    NSString *str = [NSString stringWithFormat:@"%@?lat=%f&long=%f", kURL, [latitude doubleValue], [longitude doubleValue]];
        NSString *str = [NSString stringWithFormat:@"%@?lat=100&long=200", kURL];
    NSLog(@"URLURL=%@", str);
    
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:kURL]];
//    request.delegate = self;
    [request setRequestMethod:@"POST"];
    [request startSynchronous];

    NSError *error = [request error];
    if (!error) {
        NSData *responseData = [request responseData];
//        NSString *resultStr = [request responseString];
        NSDictionary *dict = [[CJSONDeserializer deserializer] deserializeAsDictionary:responseData error:&error];
        [dict writeToFile:[NSString stringWithFormat:@"%@/Documents/Data.plist", NSHomeDirectory()] atomically:YES];
        parseOperation = [[ParseOperation alloc] init];
        [parseOperation parseLocalPlist:dict];
        [parseOperation release];
    }
    else {
        //处理error
        
        
    }



}

- (void)dealloc {
//    [parseOperation release];
    [super dealloc];
}

//#pragma mark - ASIHttpRequest
//- (void)requestFinished:(ASIHTTPRequest *)request {
//
//}
@end
