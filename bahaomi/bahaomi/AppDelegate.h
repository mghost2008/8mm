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
#import "ALAlertBanner.h"
#import "HUD.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,WeiboSDKDelegate,WXApiDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *rootNavController;
@property (strong, nonatomic) MainTabBarControllerViewController *rootTabController;
//用户信息，包含用户基本信息，和设置信息
@property (strong, nonatomic) NSMutableDictionary *userInfo;
//用户头像信息
@property (strong, nonatomic) UIImage *avata;
//系统推荐公众号列表
@property (strong, nonatomic) NSMutableArray *commendArr;
//用户订阅关系
@property (strong, nonatomic) NSMutableArray *bookArr;
//用户收藏列表
@property (strong, nonatomic) NSMutableArray *collectArr;
//网络状态
@property NSInteger networkStatusCode;
@property (nonatomic) BOOL isLogin;
@property (strong, nonatomic) LoginRootViewController *loginController;
@property (strong, nonatomic) NSMutableDictionary *weiboInfo;
@property (strong, nonatomic) NSMutableDictionary *weixinInfo;
@property BOOL mastToSetting;

@end

