//
//  ParseOperation.h
//  ekkk
//
//  Created by Wu Jianjun on 11-4-5.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBXML.h"
#import "OneItem.h"
@interface ParseOperation : NSObject {

    NSMutableArray *itemList;
    TBXML *tbxml;
}


@property (nonatomic, retain) NSMutableArray *itemList;

- (void)parseLocalXML;
- (void)saveParsedItems:(NSArray *)items;
@end
