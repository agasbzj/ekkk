//
//  ekkkManager.m
//  ekkk
//
//  Created by 卞中杰 on 11-6-14.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "ekkkManager.h"

#define kLocationFileName @"location.plist"
#define kDataFileName @"Data.plist"
#define kUserCardsFileName @"UserCards.plist"


static ekkkManager *instance = nil;

@implementation ekkkManager
@synthesize userCardsArray = _userCardsArray;
@synthesize selectedPlace = _selectedPlace;
@synthesize parsedItems = _parsedItems;

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

+ (ekkkManager *)sharedManager {
    if (instance == nil) {
        [[self alloc] init];

    }
    return instance;
}

+ (id)allocWithZone:(NSZone *)zone {
    if (instance == nil) {
        instance = [super allocWithZone:zone];
        return instance;
    }
    return nil;
}

- (id)init {
    if ((self = [super init])) {
        _userCardsArray = [[[NSDictionary dictionaryWithContentsOfURL:[self userCardsFilePath]] valueForKey:@"cards"] retain];
        _selectedPlace = NSLocalizedString(@"Nearby", @"Nearby");
        _parsedItems = [[NSMutableArray alloc] init];
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}



//retain返回单例本身

- (id)retain {
    
    return self;
    
}



//引用计数总是为1

- (unsigned)retainCount {
    
    return 1;
    
}



//release不做任何处理

- (void)release {

    [super release];
}



//autorelease返回单例本身

- (id)autorelease {
    
    return self;
    
}

-(void)dealloc {
    [_selectedPlace release];
    [_userCardsArray release];
    [_parsedItems release];
    [super dealloc];
    
}



#pragma mark - Application's Documents directory

/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

#pragma mark - 
- (void)userCardsSelected:(NSMutableArray *)userCards {
    NSDictionary *dic = [NSDictionary dictionaryWithObject:userCards forKey:@"cards"];
    [dic writeToURL:[self userCardsFilePath] atomically:YES];
    //保存完数据要重新读取新数据
    _userCardsArray = nil;
    [_userCardsArray release];
    _userCardsArray = [[[NSDictionary dictionaryWithContentsOfURL:[self userCardsFilePath]] valueForKey:@"cards"] retain];
}
@end
