//
//  LoginRootViewController.h
//  bahaomi
//
//  Created by  王国众 on 15/6/8.
//  Copyright (c) 2015年 yuedongxinji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Message.h"

@interface LoginRootViewController : UIViewController

- (IBAction)closeLoginView:(UIButton *)sender;
- (IBAction)telLogin:(UIButton *)sender;
- (IBAction)weiboLogin:(UIButton *)sender;
- (IBAction)weixinLogin:(UIButton *)sender;
- (IBAction)regUser:(UIButton *)sender;


@end
