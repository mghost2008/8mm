//
//  AppDelegate.m
//  bahaomi
//
//  Created by lamto on 15/6/8.
//  Copyright (c) 2015年 yuedongxinji. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self initNetwork];
    [self initUserInfo];
    [self buildLayout];
    return YES;
}

//布局
- (void)buildLayout{
    //设置全局的navbar
    [[UINavigationBar appearance] setBarTintColor:UIColorFromRGB(0x57acde)];
    NSDictionary *dic = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[UIColor whiteColor], [UIFont systemFontOfSize:20], nil] forKeys:[NSArray arrayWithObjects:NSForegroundColorAttributeName, NSFontAttributeName, nil]];
    [[UINavigationBar appearance] setTitleTextAttributes:dic];
    [[UIBarButtonItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName] forState:UIControlStateNormal];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = self.rootTabController;
    [self.window makeKeyAndVisible];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(needLogin) name:NEED_LOGIN object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeLoginView) name:CLOSE_LOGINVIEW object:nil];
}

//网络初始化
- (void)initNetwork{
    // 如果要检测网络状态的变化,必须用检测管理器的单例的startMonitoring
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    // 检测网络连接的单例,网络变化时的回调方法
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        self.networkStatusCode = status;
        NSLog(@"网络：%@", self.networkStatusCode == 0 ? @"无连接":self.networkStatusCode == 1 ? @"3G" : self.networkStatusCode == 2 ? @"WIFI" : @"未知" );
    }];
    
}

- (void)initUserInfo{
    self.userInfo = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"USER_INFO"]];
    self.isLogin = [self.userInfo objectForKey:@"id"]?YES:NO;
}

- (MainTabBarControllerViewController *)rootTabController{
    if (!_rootTabController) {
        _rootTabController = [[MainTabBarControllerViewController alloc] init];
    }
    return _rootTabController;
}

- (LoginRootViewController *)loginController{
    if (!_loginController) {
        _loginController = [[LoginRootViewController alloc] init];
    }
    return _loginController;
}

- (void)needLogin{
    [self.loginController.view setFrame:CGRectMake(0, self.window.frame.size.height, self.loginController.view.frame.size.width, self.loginController.view.frame.size.height)];
    [self.window.rootViewController.view addSubview:self.loginController.view];
    [UIView animateKeyframesWithDuration:0.3f delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear  animations:^{
        [self.loginController.view setFrame:CGRectMake(0, 0, self.loginController.view.frame.size.width, self.loginController.view.frame.size.height)];
    } completion:^(BOOL finish){}];
}

- (void)closeLoginView{
    [UIView animateKeyframesWithDuration:0.3f delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear  animations:^{
        [self.loginController.view setFrame:CGRectMake(0, self.window.frame.size.height, self.loginController.view.frame.size.width, self.loginController.view.frame.size.height)];
    } completion:^(BOOL finish){
        [self.loginController.view removeFromSuperview];
    }];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
