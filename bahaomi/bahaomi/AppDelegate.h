//
//  AppDelegate.h
//  bahaomi
//
//  Created by lamto on 15/6/8.
//  Copyright (c) 2015年 yuedongxinji. All rights reserved.
//
#import "Info.h"
#import "MainTabBarControllerViewController.h"
#import "LoginRootViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) MainTabBarControllerViewController *rootTabController;
//用户信息，包含用户基本信息，和设置信息
@property (strong, nonatomic) NSMutableDictionary *userInfo;
//网络状态
@property NSInteger networkStatusCode;
@property (nonatomic) BOOL isLogin;
@property (strong, nonatomic) LoginRootViewController *loginController;

@end

