//
//  CardsTableCell.h
//  ekkk
//
//  Created by 卞中杰 on 11-6-17.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CardsTableCell : UITableViewCell {
    UIImageView *_iconImageView;
    UILabel *theLabel;
}
@property (nonatomic, retain) IBOutlet UIImageView *iconImageView;
@property (nonatomic, retain) IBOutlet UILabel *theLabel;
@end
