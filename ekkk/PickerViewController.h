//
//  PickerViewController.h
//  ekkk
//
//  Created by 卞 中杰 on 11-4-27.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PickerViewDelegate
- (void)selectedOneInPicker:(NSUInteger)choosen;

@end
@interface PickerViewController : UIView <UIPickerViewDelegate, UIPickerViewDataSource> {
    UIPickerView *_picker;
    NSMutableArray *_pickerArray;
    NSArray *_dataArray;
    id <PickerViewDelegate> delegate;
}
@property (nonatomic, retain) IBOutlet UIPickerView *picker;
@property (nonatomic, retain) NSMutableArray *pickerArray;
@property (nonatomic, retain) NSArray *dataArray;
@property (assign) id <PickerViewDelegate> delegate;

- (IBAction)selectButtonPressed:(id)sender;
@end
