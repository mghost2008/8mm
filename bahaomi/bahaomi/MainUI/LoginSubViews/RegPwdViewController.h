//
//  RegPwdViewController.h
//  bahaomi
//
//  Created by  王国众 on 15/6/9.
//  Copyright (c) 2015年 yuedongxinji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BHM_TextField.h"
#import "NetworkUtil.h"

@interface RegPwdViewController : UIViewController

@property (strong, nonatomic) UIBarButtonItem *complateBtn;
@property (weak, nonatomic) IBOutlet BHM_TextField *pwdField;
@property (strong, nonatomic) NSString *telNum;

@end
