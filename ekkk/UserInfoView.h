//
//  UserInfoView.h
//  ekkk
//
//  Created by 卞 中杰 on 11-6-10.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

//登录之后显示用户信息界面

#import <UIKit/UIKit.h>


@interface UserInfoView : UIView {
    NSString *_userName;
}
@property (nonatomic, retain) NSString *userName;
@end
