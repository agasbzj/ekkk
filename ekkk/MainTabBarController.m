//
//  MainTabBarController.m
//  ekkk
//
//  Created by 卞中杰 on 11-6-12.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "MainTabBarController.h"
#import "OffersRootViewController.h"
#import "NearbyRootViewController.h"
#import "CategoriesRootViewController.h"
#import "CardsRootViewController.h"
#import "ManagementRootViewController.h"

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    OffersRootViewController *offersRootViewController = [[OffersRootViewController alloc] init];
    NearbyRootViewController *nearbyRootViewController = [[NearbyRootViewController alloc] init];
    CategoriesRootViewController *categoryRootViewController = [[CategoriesRootViewController alloc] init];
    CardsRootViewController *cardsRootViewController = [[CardsRootViewController alloc] init];
    ManagementRootViewController *managementRootViewController = [[ManagementRootViewController alloc] init];
    NSArray *array = [NSArray arrayWithObjects:offersRootViewController, nearbyRootViewController, categoryRootViewController, cardsRootViewController, managementRootViewController, nil];
    [self setViewControllers:array animated:YES];
}
@end
