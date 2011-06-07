//
//  RegisterViewController.h
//  ekkk
//
//  Created by 卞 中杰 on 11-6-1.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UITableViewController {
    
@private
    NSString *_userName;
    NSString *_password;
    NSString *_email;
}
@property (nonatomic, retain) NSString *userName;
@property (nonatomic, retain) NSString *password;
@property (nonatomic, retain) NSString *email;
@end
