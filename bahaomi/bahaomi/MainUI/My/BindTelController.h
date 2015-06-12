//
//  BindTelController.h
//  bahaomi
//
//  Created by lamto on 15/6/12.
//  Copyright (c) 2015年 yuedongxinji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BHM_TextField.h"

@interface BindTelController : UIViewController

@property (weak, nonatomic) IBOutlet BHM_TextField *telNum;
@property (strong, nonatomic) UIBarButtonItem *backItem;

@end
