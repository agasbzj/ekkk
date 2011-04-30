//
//  ParseOperation.m
//  ekkk
//
//  Created by Wu Jianjun on 11-4-5.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "ParseOperation.h"
#define kFileName @"Data.plist"

@implementation ParseOperation
@synthesize itemList;


- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        [self parseLocalXML];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"LocalXMLParsed" object:self userInfo:[NSDictionary dictionaryWithObject:self.itemList forKey:@"Items"]];
        
    }
    
    return self;
}


- (void)dealloc
{
    [super dealloc];
}

- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
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
static NSString *kSourceElem = @"source";
static NSString *kDistanceElem = @"distance";

#pragma mark - Parse Local XML File
//解析xml文件
- (void)parseLocalXML {
    itemList = [[NSMutableArray alloc] initWithCapacity:50];
    tbxml = [[TBXML tbxmlWithXMLFile:@"credit_information.xml"] retain];
    TBXMLElement *root = tbxml.rootXMLElement; 
    
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    
    if (root) {
        TBXMLElement *index = [TBXML childElementNamed:@"index" parentElement:root];
        while (index != nil) {
            OneItem *oneItem = [[OneItem alloc] init];
            oneItem.bank = [[NSMutableArray alloc] init];
            
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
            
            TBXMLElement *hot = [TBXML childElementNamed:kHotElem parentElement:index];
            oneItem.hot = [TBXML textForElement:hot];
            
            
            TBXMLElement *details = [TBXML childElementNamed:kDetailsElem parentElement:index];
            oneItem.details = [TBXML textForElement:details];


            
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
            

            
            TBXMLElement *bank = [TBXML childElementNamed:@"bank" parentElement:index];
            
            while (bank != nil) {
                TBXMLElement *bank_name = [TBXML childElementNamed:@"bank_name" parentElement:bank];
                NSString *bankName = [TBXML textForElement:bank_name];
                
                TBXMLElement *card = [TBXML childElementNamed:@"card" parentElement:bank];
                
                NSMutableArray *cardArray = [[NSMutableArray alloc] init];
                while (card != nil) {
                    TBXMLElement *card_name = [TBXML childElementNamed:@"card_name" parentElement:card];
                    NSString *cardName = [TBXML textForElement:card_name];
                    
                    NSDictionary *cardDic = [NSDictionary dictionaryWithObjectsAndKeys:cardName, @"card_name",
                                             nil];
                    [cardArray addObject:cardDic];
                    card = [TBXML nextSiblingNamed:@"card" searchFromElement:card];
                }
                TBXMLElement *discount = [TBXML childElementNamed:kDiscountElem parentElement:bank];
                NSString *discountS = [TBXML textForElement:discount];
                NSDictionary *bankDic = [NSDictionary dictionaryWithObjectsAndKeys:bankName, @"bank_name", cardArray, @"card", discountS, @"discount", nil];
                [oneItem.bank addObject:bankDic];
                bank = [TBXML nextSiblingNamed:@"bank" searchFromElement:bank];
            }
            
            TBXMLElement *source = [TBXML childElementNamed:kSourceElem parentElement:index];
            oneItem.source = [TBXML textForElement:source];
            
            TBXMLElement *distance = [TBXML childElementNamed:kDistanceElem parentElement:index];
            oneItem.distance = [TBXML textForElement:distance];
            
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
            
            [tempArray addObject:oneItem.city];
        }
    }
    [tbxml release];
    
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"LocalXMLParsed" object:self userInfo:[NSDictionary dictionaryWithObject:itemList forKey:@"Items"]];
    
//    [self performSelectorOnMainThread:@selector(saveParsedItems:) withObject:itemList waitUntilDone:YES];
    
    NSMutableArray *arrayToSave = [[[NSMutableArray alloc] init] autorelease];
    
    for (OneItem *item in itemList) {
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:item.city, @"city",
                             item.area, @"area",
                             item.category_Fine, @"category_Fine",
                             item.category_Coarse, @"category_Coarse",
                             item.seller, @"seller",
                             item.image, @"image",
                             item.telephone, @"telephone",
                             item.address, @"address",
                             item.latitude, @"latitude",
                             item.longitude, @"longitude",
                             item.details, @"details",
                             item.hot, @"hot",
                             item.comments_Service, @"comments_Service",
                             item.comments_General, @"comments_General",
                             item.comments_Enviroment, @"comments_Enviroment",
                             item.comments_Discount, @"comments_Discount",
                             item.bank, @"bank",
                             item.source, @"source",
                             item.distance, @"distance",
                             nil];
        [arrayToSave addObject:dic];
    }
    
    NSDictionary *dc = [NSDictionary dictionaryWithObject:arrayToSave forKey:@"data_Array"];
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:kFileName];
    [dc writeToURL:storeURL atomically:YES];
}

- (void)saveParsedItems:(NSArray *)items {
    assert([NSThread isMainThread]);
    //解析完成，把数据发回。
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LocalXMLParsed" object:self userInfo:[NSDictionary dictionaryWithObject:items forKey:@"Items"]];
}


@end
