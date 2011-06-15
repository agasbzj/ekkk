//
//  ekkkManager.h
//  ekkk
//
//  Created by 卞中杰 on 11-6-14.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

//Singleton

#import <Foundation/Foundation.h>
#import "BankSelectViewController.h"


@interface ekkkManager : NSObject <UserCardsSelectedDelegate> {
    NSMutableArray *_userCardsArray;    //用户的卡片数组
    NSString *_selectedPlace;           //当前选择的查询地点
    NSMutableArray *_parsedItems;   //存放解析完回传过来的新数据，其中每个元素为OneItem类

}
@property (nonatomic, retain) NSMutableArray *userCardsArray;
@property (nonatomic, retain) NSString *selectedPlace;
@property (nonatomic, retain) NSMutableArray *parsedItems;

+ (ekkkManager *)sharedManager;

- (NSURL *)applicationDocumentsDirectory;
- (NSURL *)locationDataFilePath;
@end
