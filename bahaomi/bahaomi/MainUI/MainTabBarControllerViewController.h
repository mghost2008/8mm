//
//  MainTabBarControllerViewController.h
//  bahaomi
//
//  Created by  王国众 on 15/6/8.
//  Copyright (c) 2015年 yuedongxinji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "info.h"
#import "Message.h"
#import "IndexRootViewController.h"
#import "SubscribeRootViewController.h"
#import "EventRootViewController.h"
#import "MyRootViewController.h"


@interface MainTabBarControllerViewController : UITabBarController<UITabBarControllerDelegate>

@property (strong, nonatomic) UINavigationController *firstNavController;
@property (strong, nonatomic) UINavigationController *secNavController;
@property (strong, nonatomic) UINavigationController *thirdNavController;
@property (strong, nonatomic) UINavigationController *fourthNavController;
//首页
@property (strong, nonatomic) IndexRootViewController *indexRootController;
//订阅
@property (strong, nonatomic) SubscribeRootViewController *subRootController;
//活动
@property (strong, nonatomic) EventRootViewController *actRootController;
//我的
@property (strong, nonatomic) MyRootViewController *myRootController;

@end
