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
@synthesize selectedString;
@synthesize confirmButton = _confirmButton;
@synthesize cancelButton = _cancelButton;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, 320, 216)];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        _pickerView.showsSelectionIndicator = YES;
        [self addSubview:_pickerView];
        [_pickerView release];
        
        UIImage *oriImage = [UIImage imageNamed:@"blueButton.png"];
        UIImage *stretchableButtonImage = [oriImage stretchableImageWithLeftCapWidth:12 topCapHeight:0];
        _confirmButton = [[UIButton alloc] initWithFrame:CGRectMake(180, 4, 120, 37)];
        _confirmButton.tag = 1;
        [_confirmButton setTitle:NSLocalizedString(@"OK", @"OK") forState:UIControlStateNormal];
        [_confirmButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [_confirmButton setBackgroundImage:stretchableButtonImage forState:UIControlStateNormal];
        [self addSubview:_confirmButton];
        [_confirmButton release];
        
        UIImage *whiteImage = [UIImage imageNamed:@"whiteButton.png"];
        UIImage *stretchableButtonImage2 = [whiteImage stretchableImageWithLeftCapWidth:12 topCapHeight:0];
        _cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 4, 120, 37)];
        _cancelButton.tag = 2;
        [_cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_cancelButton setTitle:NSLocalizedString(@"Cancel", @"Cancel") forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [_cancelButton setBackgroundImage:stretchableButtonImage2 forState:UIControlStateNormal];
        [self addSubview:_cancelButton];
        [_cancelButton release];
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
    [_selectedString release];
    [super dealloc];
}

#pragma mark - PickerView Delegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [_pickerDataArray objectAtIndex:row];
}
//- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
//    return 260;
//}


//- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
//    _selectedString = [_pickerDataArray objectAtIndex:row];
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
    NSInteger row = [_pickerView selectedRowInComponent:0];
    _selectedString = [_pickerDataArray objectAtIndex:row];
    
    UIButton *button = (UIButton *)sender;
    [delegate buttonPressed:button.tag withStringInPicker:_selectedString];
}
@end
