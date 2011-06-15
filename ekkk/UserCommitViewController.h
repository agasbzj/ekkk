//
//  UserCommitViewController.h
//  ekkk
//
//  Created by 卞中杰 on 11-6-15.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UserCommitViewController : UIViewController {
    UILabel *_environmentLabel;
    UILabel *_serviceLabel;
    UILabel *_discountLabel;
    UILabel *_generalLabel;
    UITextField *_moneyTextField;
    UITextView *_commitTextView;
}
@property (nonatomic, retain) IBOutlet UILabel *environmentLabel;
@property (nonatomic, retain) IBOutlet UILabel *serviceLabel;
@property (nonatomic, retain) IBOutlet UILabel *discountLabel;
@property (nonatomic, retain) IBOutlet UILabel *generalLabel;
@property (nonatomic, retain) IBOutlet UITextField *moneyTextField;
@property (nonatomic, retain) IBOutlet UITextView *commitTextView;

- (IBAction)backgroundTapped:(id)sender;
- (IBAction)sliderChanged:(id)sender;
@end
