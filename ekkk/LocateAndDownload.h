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
}
@property (nonatomic, retain, readonly) NSOperationQueue *interConnectOperationQueue;
@property (nonatomic, retain) InterconnectWithServer *interconnectOperation;
@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain, readonly) NSMutableArray *parsedItems;

- (void)startStandardUpdates;
- (NSURL *)applicationDocumentsDirectory;
- (NSURL *)locationDataFilePath;
- (void)loadItems:(NSNotification *)itemList;
- (void)loadData;
@end
