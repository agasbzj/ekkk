//
//  InterconnectWithServer.h
//  ekkk
//
//  Created by 卞 中杰 on 11-4-5.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ParseOperation.h"

@interface InterconnectWithServer : NSOperation {
    NSNumber *latitude;
    NSNumber *longitude;
    
    ParseOperation *parseOperation;
}

@property (nonatomic, retain) NSNumber *latitude;
@property (nonatomic, retain) NSNumber *longitude;
@property (nonatomic, retain) ParseOperation *parseOperation;
- (id)initWithCoordinate:(NSDictionary *)dictionary;

@end
