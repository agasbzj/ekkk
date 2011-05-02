//
//  PickerView.h
//  ekkk
//
//  Created by 卞 中杰 on 11-5-1.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyPickViewDelegate

- (void)buttonPressed:(NSUInteger)tag withStringInPicker:(NSString *)string;

@end
@interface PickerView : UIView <UIPickerViewDelegate, UIPickerViewDataSource>{
    UIPickerView *_pickerView;
    NSArray *_pickerDataArray;
    NSString *_selectedString;
    id <MyPickViewDelegate> delegate;
}
@property (nonatomic, retain) NSArray *pickerDataArray;
@property (nonatomic, retain) IBOutlet UIPickerView *pickerView;
@property (nonatomic, retain) NSString *selectedString;
@property (nonatomic, assign) id <MyPickViewDelegate> delegate;
- (IBAction)buttonPressed:(id)sender;
@end
