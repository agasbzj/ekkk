//
//  PickerView.m
//  ekkk
//
//  Created by 卞 中杰 on 11-5-1.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "PickerView.h"


@implementation PickerView
@synthesize pickerView = _pickerView;
@synthesize pickerDataArray = _pickerDataArray;
@synthesize delegate;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc
{
    [_pickerDataArray release];
    [_pickerView release];
    [super dealloc];
}

#pragma mark - PickerView Delegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [_pickerDataArray objectAtIndex:row];
}
//- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
//    return 260;
//}

#pragma mark - Picker Data Source Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [_pickerDataArray count];
}

- (IBAction)buttonPressed:(id)sender {
    UIButton *button = (UIButton *)sender;
    [delegate buttonPressed:button.tag];
}
@end