//
//  GoogleApi.h
//  ekkk
//
//  Created by 卞中杰 on 11-6-14.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GoogleApi : NSObject {
    NSDictionary *_placeDecoded;
}
@property (nonatomic, retain) NSDictionary *placeDecoded;

- (NSDictionary *)decodePlacesWithJson:(NSData *)jsonData;
@end
