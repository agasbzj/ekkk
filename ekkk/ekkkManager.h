//
//  ekkkManager.h
//  ekkk
//
//  Created by 卞中杰 on 11-6-14.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BankSelectViewController.h"


@interface ekkkManager : NSObject <UserCardsSelectedDelegate> {
    NSMutableArray *_userCardsArray;

}
@property (nonatomic, retain) NSMutableArray *userCardsArray;

+ (ekkkManager *)sharedManager;

- (NSURL *)applicationDocumentsDirectory;
- (NSURL *)locationDataFilePath;
@end
