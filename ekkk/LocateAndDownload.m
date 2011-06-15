//
//  LocateAndDownload.m
//  ekkk
//
//  Created by 卞中杰 on 11-6-15.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "LocateAndDownload.h"
#import "InterconnectWithServer.h"

#define kLocationFileName           @"location.plist"
#define kDataBackupFileName         @"DataBackup.plist"
#define kDataFileName               @"Data.plist"
#define kUserCardsFileName          @"UserCards.plist"

@implementation LocateAndDownload
@synthesize locationManager;
@synthesize interConnectOperationQueue;
@synthesize parsedItems = _parsedItems;
@synthesize interconnectOperation;
@synthesize coodToLocate = _coodToLocate;
@synthesize locateCustomPosition;

- (id)init {
    if ((self = [super init])) {
        _parsedItems = [[NSMutableArray alloc] initWithCapacity:50];
        _coodToLocate = [[NSMutableDictionary alloc] init];
        locateCustomPosition = NO;
        
        [ekkkManager sharedManager];
        
//        [self loadData];
        //注册为观察者，用于接受新线程解析的数据。
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadItems:) name:@"LocalXMLParsed" object:nil];
        
        
        //开始定位
//        [self startStandardUpdates];
    }
    return self;
}

- (void)dealloc {
    [_coodToLocate release];
    [_parsedItems release];
    [locationManager release];
    [super dealloc];
}

- (NSURL *)userCardsFilePath {
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:kUserCardsFileName];
    NSLog(@"%@", storeURL);
    return storeURL;
}

- (NSURL *)locationDataFilePath {
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:kLocationFileName];
    NSLog(@"%@", storeURL);
    return storeURL;
}

- (NSURL *)itemDataFilePath {
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:kDataFileName];
    NSLog(@"%@", storeURL);
    return storeURL;
}

- (NSURL *)itemBackupDataFilePath {
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:kDataBackupFileName];
    NSLog(@"%@", storeURL);
    return storeURL;
}

//用备份数据（附近）替换当前使用的文件，即切换回附近信息
- (void)loadBackupData {
    NSURL *url = [self itemDataFilePath];
    NSURL *backupUrl = [self itemBackupDataFilePath];
    NSArray *array = [NSArray arrayWithContentsOfURL:backupUrl];
    [array writeToURL:url atomically:YES];
    [self loadData];
}

//读取数据到_parsedItems，初始是附近数据，根据选择的地点而改变
- (void)loadData {
    [_parsedItems removeAllObjects];
    NSURL *url = [self itemDataFilePath];
    NSArray *tempArray = [[NSDictionary dictionaryWithContentsOfURL:url] valueForKey: @"data_Array"];
    
    for (NSDictionary *dic in tempArray) {
        OneItem *oneItem = [[OneItem alloc] init];
        oneItem.city = [dic valueForKey:@"city"];
        oneItem.area = [dic valueForKey:@"area"];
        oneItem.seller = [dic valueForKey:@"seller"];
        oneItem.image = [dic valueForKey:@"image"];
        oneItem.category_Fine = [dic valueForKey:@"category_Fine"];
        oneItem.category_Coarse = [dic valueForKey:@"category_Coarse"];
        oneItem.telephone = [dic valueForKey:@"telephone"];
        oneItem.address = [dic valueForKey:@"address"];
        oneItem.www_Address = [dic valueForKey:@"www_Address"];
        oneItem.latitude = [dic valueForKey:@"latitude"];
        oneItem.longitude = [dic valueForKey:@"longitude"];
        oneItem.details = [dic valueForKey:@"details"];
        oneItem.hot = [dic valueForKey:@"hot"];
        oneItem.comments_General = [dic valueForKey:@"comments_General"];
        oneItem.comments_Discount = [dic valueForKey:@"comments_Discount"];
        oneItem.comments_Service = [dic valueForKey:@"comments_Service"];
        oneItem.comments_Enviroment = [dic valueForKey:@"comments_Enviroment"];
        oneItem.bank = [dic valueForKey:@"bank"];
        oneItem.card = [dic valueForKey:@"card"];
        oneItem.source = [dic valueForKey:@"source"];
        oneItem.distance = [dic valueForKey:@"distance"];
        [_parsedItems addObject:oneItem];
        [oneItem release];
    }
    
    [ekkkManager sharedManager].parsedItems = _parsedItems;
}

//写入解析完的数据
- (void)loadItems:(NSNotification *)items {
    
    //关闭状态栏小菊花
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"LocalXMLParsed" object:nil];
    
    
    
    
    [self loadData];
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NewDataSaved" object:self];
    [interConnectOperationQueue release];
}

- (void)startStandardUpdates
{
    // Create the location manager if this object does not
    // already have one.
    if (nil == locationManager)
        locationManager = [[CLLocationManager alloc] init];
    
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    // Set a movement threshold for new events.
    locationManager.distanceFilter = kCLHeadingFilterNone;
    
    [locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"latitude %+.6f, longitude %+.6f\n",
          newLocation.coordinate.latitude,
          newLocation.coordinate.longitude);
    // If it's a relatively recent event, turn off updates to save power
    //    NSDate* eventDate = newLocation.timestamp;
    //    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    //    if (abs(howRecent) < 15.0)
    //    {
    //        NSLog(@"latitude %+.6f, longitude %+.6f\n",
    //              newLocation.coordinate.latitude,
    //              newLocation.coordinate.longitude);
    //    }
    // else skip the event and process the next one.
    [locationManager stopUpdatingLocation];
    
    
    NSMutableDictionary *ddd = [NSMutableDictionary dictionaryWithCapacity:2];
    NSNumber *lat = [NSNumber numberWithFloat:newLocation.coordinate.latitude];
    NSNumber *log = [NSNumber numberWithFloat:newLocation.coordinate.longitude];
    [ddd setValue:lat forKey:@"latitude"];
    [ddd setValue:log forKey:@"longitude"];
    [ddd writeToURL:[self locationDataFilePath] atomically:YES];
    
    
//    //新建线程
//    interConnectOperationQueue = [NSOperationQueue new];
//    
//    //定位完成开始和服务器交互
//    interconnectOperation = [[[InterconnectWithServer alloc] initWithCoordinate:ddd] autorelease];
//    [self.interConnectOperationQueue addOperation: interconnectOperation];
    
    [self downloadInfoWithCoordinate:ddd];
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    // The location "unknown" error simply means the manager is currently unable to get the location.
    // We can ignore this error for the scenario of getting a single location fix, because we already have a 
    // timeout that will stop the location manager to save power.
    NSLog(@"Error:%@", [error userInfo]);
}

//把坐标发到服务器下载数据
- (void)downloadInfoWithCoordinate:(NSDictionary *)coordinateDict {
    //新建线程
    interConnectOperationQueue = [NSOperationQueue new];
    
    //定位完成开始和服务器交互
    interconnectOperation = [[[InterconnectWithServer alloc] initWithCoordinate:coordinateDict] autorelease];
    [self.interConnectOperationQueue addOperation: interconnectOperation];
}

#pragma mark - Application's Documents directory

/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}
@end
