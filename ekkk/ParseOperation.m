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
        

        
    }
    
    return self;
}


- (void)dealloc
{
    [super dealloc];
}

#pragma mark - Element Name Define

static NSString *kCityElem = @"city";
static NSString *kAreaElem = @"area";
static NSString *kCategoryCoarseElem = @"category_coarse";
static NSString *kCategoryFineElem = @"category_fine";
static NSString *kSellerElem = @"seller";
static NSString *kAddressElem = @"address";
static NSString *kImageElem = @"image";
static NSString *kWwwAddressElem = @"www_address";
static NSString *kLatitudeElem = @"latitude";
static NSString *kLongitudeElem = @"longitude";
static NSString *kDiscountElem = @"discount";
static NSString *kDetailsElem = @"details";
static NSString *kStartDateElem = @"start_date";
static NSString *kEndDateElem = @"end_date";
static NSString *kTelephoneElem = @"telephone";
static NSString *kCommentsEnviromentElem = @"comments_Enviroment";
static NSString *kCommentsServiceElem = @"comments_Service";
static NSString *kCommentsDiscountElem = @"comments_Discount";
static NSString *kCommentsGeneralElem = @"comments_General";
static NSString *kHotElem = @"hot";

#pragma mark - Parse Local XML File
//解析xml文件
- (void)parseLocalXML {
    itemList = [[NSMutableArray alloc] initWithCapacity:50];
    tbxml = [[TBXML tbxmlWithXMLFile:@"credit_information.xml"] retain];
    TBXMLElement *root = tbxml.rootXMLElement; 
    
    if (root) {
        TBXMLElement *index = [TBXML childElementNamed:@"Row" parentElement:root];
        while (index != nil) {
            OneItem *oneItem = [[OneItem alloc] init];
            
            TBXMLElement *city = [TBXML childElementNamed:kCityElem parentElement:index];
            oneItem.city = [TBXML textForElement:city];
            
            TBXMLElement *area = [TBXML childElementNamed:kAreaElem parentElement:index];
            oneItem.area = [TBXML textForElement:area];
            
            TBXMLElement *address = [TBXML childElementNamed:kAddressElem parentElement:index];
            oneItem.address = [TBXML textForElement:address];

            TBXMLElement *wwwAddress = [TBXML childElementNamed:kWwwAddressElem parentElement:index];
            oneItem.www_Address = [TBXML textForElement:wwwAddress];
            
            TBXMLElement *image = [TBXML childElementNamed:kImageElem parentElement:index];
            oneItem.image = [TBXML textForElement:image];
            
            TBXMLElement *categoryCoarse = [TBXML childElementNamed:kCategoryCoarseElem parentElement:index];
            oneItem.category_Coarse = [TBXML textForElement:categoryCoarse];
            
            TBXMLElement *categoryFine = [TBXML childElementNamed:kCategoryFineElem parentElement:index];
            oneItem.category_Fine = [TBXML textForElement:categoryFine];
            
            TBXMLElement *seller = [TBXML childElementNamed:kSellerElem parentElement:index];
            oneItem.seller = [TBXML textForElement:seller];
            
//            TBXMLElement *hot = [TBXML childElementNamed:kHotElem parentElement:index];
//            oneItem.hot = [[TBXML textForElement:hot] boolValue];
            
            TBXMLElement *discount = [TBXML childElementNamed:kDiscountElem parentElement:index];
            oneItem.discount = [TBXML textForElement:discount];
            
            TBXMLElement *details = [TBXML childElementNamed:kDetailsElem parentElement:index];
            oneItem.details = [TBXML textForElement:details];

            TBXMLElement *endDate = [TBXML childElementNamed:kEndDateElem parentElement:index];
            oneItem.end_Date = [TBXML textForElement:endDate];
            
            TBXMLElement *startDate = [TBXML childElementNamed:kStartDateElem parentElement:index];
            oneItem.start_Date = [TBXML textForElement:startDate];
            
            TBXMLElement *commentsEnviroment = [TBXML childElementNamed:kCommentsEnviromentElem parentElement:index];
            oneItem.comments_Enviroment = [TBXML textForElement:commentsEnviroment];
            
            TBXMLElement *commentsService = [TBXML childElementNamed:kCommentsServiceElem parentElement:index];
            oneItem.comments_Service = [TBXML textForElement:commentsService];
            
            TBXMLElement *commentsDiscount = [TBXML childElementNamed:kCommentsDiscountElem parentElement:index];
            oneItem.comments_Discount = [TBXML textForElement:commentsDiscount];
            
            TBXMLElement *commentsGeneral = [TBXML childElementNamed:kCommentsGeneralElem parentElement:index];
            oneItem.comments_General = [TBXML textForElement:commentsGeneral];
            
            
            TBXMLElement *tel = [TBXML childElementNamed:kTelephoneElem parentElement:index];
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
    
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"LocalXMLParsed" object:self userInfo:[NSDictionary dictionaryWithObject:itemList forKey:@"Items"]];
    
//    [self performSelectorOnMainThread:@selector(saveParsedItems:) withObject:itemList waitUntilDone:YES];

}

- (void)saveParsedItems:(NSArray *)items {
    assert([NSThread isMainThread]);
    //解析完成，把数据发回。
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LocalXMLParsed" object:self userInfo:[NSDictionary dictionaryWithObject:items forKey:@"Items"]];
}


@end
