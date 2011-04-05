//
//  OneItem.h
//  ekkk
//
//  Created by 卞 中杰 on 11-3-27.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

//每一项所要包含的所有信息。

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface OneItem : NSObject {
    NSString *city;             //城市
    NSString *location;         //地段
    NSString *categoryCoarse;   //大分类
    NSString *categoryFine;     //子分类
    NSString *seller;           //商家
    NSString *discount;         //折扣
    
    NSDate *startDate;          //开始日期
    NSDate *endDate;            //结束日期
    
    NSString *details;          //细节
    NSString *comment;          //评论
    
    NSString *telephone;         //电话
    NSNumber *latitude;         //经度
    NSNumber *longitude;        //纬度
    CLLocationCoordinate2D coordinate;      //坐标
    
}

@property (nonatomic, retain) NSString *city;
@property (nonatomic, retain) NSString *location;
@property (nonatomic, retain) NSString *categoryCoarse;
@property (nonatomic, retain) NSString *categoryFine;
@property (nonatomic, retain) NSString *seller;
@property (nonatomic, retain) NSString *discount;
@property (nonatomic, retain) NSString *details;
@property (nonatomic, retain) NSString *comment;
@property (nonatomic, retain) NSString *telephone;
@property (nonatomic, retain) NSDate *startDate;
@property (nonatomic, retain) NSDate *endDate;
@property (nonatomic, retain) NSNumber *latitude;
@property (nonatomic, retain) NSNumber *longitude;

@property (nonatomic, assign, readonly) CLLocationCoordinate2D coordinate;

@end
