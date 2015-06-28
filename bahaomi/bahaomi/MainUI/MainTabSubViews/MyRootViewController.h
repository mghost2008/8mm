//
//  MyRootViewController.h
//  bahaomi
//
//  Created by  王国众 on 15/6/8.
//  Copyright (c) 2015年 yuedongxinji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyMainViewController.h"

@interface MyRootViewController : UIViewController

@property (strong, nonatomic) MyMainViewController *mainController;
@property (strong, nonatomic) UIBarButtonItem *avataItem;

@end
