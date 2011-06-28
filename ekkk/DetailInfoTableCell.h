//
//  DetailInfoTableCell.h
//  ekkk
//
//  Created by 卞中杰 on 11-6-28.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DetailInfoTableCell : UITableViewCell {
    UILabel *_typeLabel;
    UILabel *_detailLabel;
    UIImageView *_icon;
}
@property (nonatomic, retain) IBOutlet UILabel *typeLabel;
@property (nonatomic, retain) IBOutlet UILabel *detailLabel;
@property (nonatomic, retain) IBOutlet UIImageView *icon;
@end
