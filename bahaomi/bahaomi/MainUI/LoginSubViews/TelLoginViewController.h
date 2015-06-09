//
//  TelLoginViewController.h
//  bahaomi
//
//  Created by  王国众 on 15/6/9.
//  Copyright (c) 2015年 yuedongxinji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BHM_TextField.h"
#import "NetworkUtil.h"

@interface TelLoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet BHM_TextField *telNumField;
@property (weak, nonatomic) IBOutlet BHM_TextField *pwdField;
- (IBAction)loginBtnClick:(UIButton *)sender;
@property (strong, nonatomic) UIBarButtonItem *closeItem;

@end
