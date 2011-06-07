//
//  TextFieldTableViewCell.h
//  ekkk
//
//  Created by 卞 中杰 on 11-6-7.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TextFieldTableViewCell : UITableViewCell {
    UITextField *_textField;
}
@property (nonatomic, retain) UITextField *textField;
- (void)hideKeyboard;
@end
