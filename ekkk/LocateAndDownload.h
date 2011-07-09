//
//  LocateAndDownload.h
//  ekkk
//
//  Created by 卞中杰 on 11-6-15.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@class InterconnectWithServer;

@interface LocateAndDownload : NSObject <CLLocationManagerDelegate> {
    CLLocationManager *locationManager;
    NSOperationQueue *interConnectOperationQueue;
    InterconnectWithServer *interconnectOperation;
    NSMutableArray *_parsedItems;   //存放解析完回传过来的新数据，其中每个元素为OneItem类
    NSMutableDictionary *_coodToLocate; //用于定位的坐标 
    BOOL locateCustomPosition;  //是否定位用户指定的地方，默认是NO，即按当前位置下载信息
}
@property (nonatomic, retain, readonly) NSOperationQueue *interConnectOperationQueue;
@property (nonatomic, retain) InterconnectWithServer *interconnectOperation;
@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain, readonly) NSMutableArray *parsedItems;
@property (nonatomic, retain) NSMutableDictionary *coodToLocate;
@property (nonatomic, assign) BOOL locateCustomPosition;

- (void)startStandardUpdates;

//Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory;
- (NSURL *)locationDataFilePath;
- (NSURL *)userCardsFilePath;
- (NSURL *)itemDataFilePath;
- (NSURL *)itemBackupDataFilePath;
//写入解析完的数据
- (void)loadItems:(NSNotification *)itemList;

//读取数据到_parsedItems，初始是附近数据，根据选择的地点而改变
- (void)loadDataWithParsedItems:(NSArray *)items;

//把坐标发到服务器下载数据
- (void)downloadInfoWithCoordinate:(NSDictionary *)coordinateDict;


@end
