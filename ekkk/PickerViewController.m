//
//  PickerViewController.m
//  ekkk
//
//  Created by 卞 中杰 on 11-4-27.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "PickerViewController.h"
#import "OneItem.h"

@implementation PickerViewController
@synthesize picker = _picker;
@synthesize pickerArray = _pickerArray;
@synthesize dataArray = _dataArray;
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
    [super dealloc];
}


#pragma mark - Picker
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [_pickerArray count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [_pickerArray objectAtIndex:row];
}


- (IBAction)selectButtonPressed:(id)sender {
    UIBarButtonItem *button = (UIBarButtonItem *)sender;
    switch (button.tag) {
        case 1:
            [delegate selectedOneInPicker:[_picker selectedRowInComponent:0]];
            break;
            
        default:
            break;
    }
    [self removeFromSuperview];
}


@end
