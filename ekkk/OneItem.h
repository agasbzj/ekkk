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
    NSString *area;         //商家地段
    NSString *category_Coarse;   //大分类
    NSString *category_Fine;     //子分类
    NSString *seller;           //商家
    NSString *image;               //商家图像
    NSString *telephone;         //电话
    NSString *address;          //商家地址
    NSString *www_Address;         //商家网址
    
    NSNumber *latitude;         //经度
    NSNumber *longitude;        //纬度
    
    NSString *details;          //描述
    NSDate *start_Date;          //开始日期
    NSDate *end_Date;            //结束日期
    
    NSString *hot;          //是否热门，使用时转换为BOOL或NSInteger
    
    NSString *comments_Enviroment;       //评论
    NSString *comments_Service;          //评论
    NSString *comments_Discount;          //评论    
    NSString *comments_General;          //评论
    NSMutableArray *bank;                 //银行
    NSMutableArray *card;
//    NSString *discount;         //折扣
    NSString *source;
    NSString *distance;
    
    CLLocationCoordinate2D coordinate;      //坐标
    
}

@property (nonatomic, retain) NSString *city;             //城市
@property (nonatomic, retain) NSString *area;         //商家地段
@property (nonatomic, retain) NSString *category_Coarse;   //大分类
@property (nonatomic, retain) NSString *category_Fine;     //子分类
@property (nonatomic, retain) NSString *seller;           //商家
@property (nonatomic, retain) NSString *image;               //商家图像
@property (nonatomic, retain) NSString *telephone;         //电话
@property (nonatomic, retain) NSString *address;          //商家地址
@property (nonatomic, retain) NSString *www_Address;         //商家网址

@property (nonatomic, retain) NSNumber *latitude;         //经度
@property (nonatomic, retain) NSNumber *longitude;        //纬度

//@property (nonatomic, retain) NSString *discount;         //折扣
@property (nonatomic, retain) NSString *details;          //描述
@property (nonatomic, retain) NSDate *start_Date;          //开始日期
@property (nonatomic, retain) NSDate *end_Date;            //结束日期

@property (nonatomic, retain) NSString *hot;

@property (nonatomic, retain) NSString *comments_Enviroment;       //评论
@property (nonatomic, retain) NSString *comments_Service;          //评论
@property (nonatomic, retain) NSString *comments_Discount;          //评论    
@property (nonatomic, retain) NSString *comments_General;          //评论

@property (nonatomic, retain) NSMutableArray *bank;        //银行
@property (nonatomic, retain) NSMutableArray *card;
@property (nonatomic, retain) NSString *source;
@property (nonatomic, retain) NSString *distance;

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

@end
