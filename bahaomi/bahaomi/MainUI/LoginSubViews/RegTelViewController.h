//
//  RegTelViewController.h
//  bahaomi
//
//  Created by  王国众 on 15/6/9.
//  Copyright (c) 2015年 yuedongxinji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BHM_TextField.h"
#import "RegPwdViewController.h"

@interface RegTelViewController : UIViewController

@property (weak, nonatomic) IBOutlet BHM_TextField *telNum;
@property (strong, nonatomic) RegPwdViewController *pwdController;
@property (strong, nonatomic) UIBarButtonItem *closeItem;
@property (strong, nonatomic) UIBarButtonItem *rightBtn;

@end
