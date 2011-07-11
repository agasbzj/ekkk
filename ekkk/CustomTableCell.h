//
//  CustomTableCell.h
//  ekkk
//
//  Created by 卞中杰 on 11-7-10.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CustomTableCell : UITableViewCell {
    UIImageView *_iconImageView;
}
@property (nonatomic, retain) IBOutlet UIImageView *iconImageView;
@end
