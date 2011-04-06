//
//  ParseOperation.m
//  ekkk
//
//  Created by Wu Jianjun on 11-4-5.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "ParseOperation.h"


@implementation ParseOperation
@synthesize itemList;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        [self parseLocalXML];
        
        //解析完成，把数据发回。
        [[NSNotificationCenter defaultCenter] postNotificationName:@"LocalXMLParsed" object:self userInfo:[NSDictionary dictionaryWithObject:self.itemList forKey:@"Items"]];
        
    }
    
    return self;
}


- (void)dealloc
{
    [super dealloc];
}

#pragma mark - Element Name Define

static NSString *kCityElem = @"city";
static NSString *kAreaElem = @"location";
static NSString *kCategoryCoarseElem = @"category_coarse";
static NSString *kCategoryFine = @"category_fine";
static NSString *kSellerElem = @"seller";
static NSString *kAddressElem = @"address";
static NSString *kLatitudeElem = @"latitude";
static NSString *kLongitudeElem = @"longitude";
static NSString *kDiscountElem = @"discount";
static NSString *kStartDateElem = @"start_date";
static NSString *kEndDateElem = @"end_date";
static NSString *kTelElem = @"tel";
static NSString *kCommentsElem = @"comments";
static NSString *kDescriptionElem = @"description";
static NSString *kHotElem = @"hot";

#pragma mark - Parse Local XML File
//解析xml文件
- (void)parseLocalXML {
    itemList = [[NSMutableArray alloc] initWithCapacity:10];
    tbxml = [[TBXML tbxmlWithXMLFile:@"test.xml"] retain];
    TBXMLElement *root = tbxml.rootXMLElement; 
    
    if (root) {
        TBXMLElement *index = [TBXML childElementNamed:@"index" parentElement:root];
        while (index != nil) {
            OneItem *oneItem = [[OneItem alloc] init];
            
            TBXMLElement *city = [TBXML childElementNamed:kCityElem parentElement:index];
            oneItem.city = [TBXML textForElement:city];
            
            TBXMLElement *area = [TBXML childElementNamed:kAreaElem parentElement:index];
            oneItem.area = [TBXML textForElement:area];
            
            TBXMLElement *categoryCoarse = [TBXML childElementNamed:kCategoryCoarseElem parentElement:index];
            oneItem.categoryCoarse = [TBXML textForElement:categoryCoarse];
            
            TBXMLElement *categoryFine = [TBXML childElementNamed:kCategoryFine parentElement:index];
            oneItem.categoryFine = [TBXML textForElement:categoryFine];
            
            TBXMLElement *seller = [TBXML childElementNamed:kSellerElem parentElement:index];
            oneItem.seller = [TBXML textForElement:seller];
            
            TBXMLElement *discount = [TBXML childElementNamed:kDiscountElem parentElement:index];
            oneItem.discount = [TBXML textForElement:discount];
            
            TBXMLElement *comments = [TBXML childElementNamed:kCommentsElem parentElement:index];
            oneItem.comment = [TBXML textForElement:comments];
            
            TBXMLElement *tel = [TBXML childElementNamed:kTelElem parentElement:index];
            oneItem.telephone = [TBXML textForElement:tel];
            
            TBXMLElement *latitude = [TBXML childElementNamed:kLatitudeElem parentElement:index];            
            NSNumber *lat = [NSNumber numberWithFloat:[[TBXML textForElement:latitude] floatValue]];            
            oneItem.latitude = lat;
            
            TBXMLElement *longitude = [TBXML childElementNamed:kLongitudeElem parentElement:index];
            NSNumber *lon = [NSNumber numberWithFloat:[[TBXML textForElement:longitude] floatValue]];
            oneItem.longitude = lon;
            
            oneItem.coordinate = CLLocationCoordinate2DMake(lat.doubleValue, lon.doubleValue);
            
            
            [itemList addObject:oneItem];
            [oneItem release];
            
            index = [TBXML nextSiblingNamed:@"index" searchFromElement:index];
        }
    }
    [tbxml release];

}


@end
