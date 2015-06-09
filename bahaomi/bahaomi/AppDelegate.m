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
    [self initWeibo];
    [self initWeixin];
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
    _isLogin = [self.userInfo objectForKey:@"id"]?YES:NO;
}

//初始化微博
- (void) initWeibo{
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:WEIBO_APP_KEY];
}

//初始化微信
- (void) initWeixin{
    [WXApi registerApp:WEIXIN_APP_ID];
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
    [UIView animateKeyframesWithDuration:0.3f delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        [self.loginController.view setFrame:CGRectMake(0, self.window.frame.size.height, self.loginController.view.frame.size.width, self.loginController.view.frame.size.height)];
    } completion:^(BOOL finish){
        [self.loginController.view removeFromSuperview];
        if (self.isLogin) {
            [self.rootTabController setSelectedIndex:3];
        }
    }];
}

- (void)setIsLogin:(BOOL)isLogin{
    _isLogin = isLogin;
    if (_isLogin) {
        [[NSNotificationCenter defaultCenter] postNotificationName:USER_LOGINED object:nil];
        [[NSUserDefaults standardUserDefaults] setObject:self.userInfo forKey:@"USER_INFO"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }else{
        [[NSNotificationCenter defaultCenter] postNotificationName:USER_LOGOUT object:nil];
        self.userInfo = [NSMutableDictionary dictionary];
        [[NSUserDefaults standardUserDefaults] setObject:self.userInfo forKey:@"USER_INFO"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
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

#pragma weixinSDK delegate method
- (void) onReq:(BaseReq *)req{}

- (void) onResp:(BaseResp *)resp {
    if([resp isKindOfClass:[SendAuthResp class]])
    {
        SendAuthResp *temp = (SendAuthResp*)resp;
        
        NSString *strTitle = [NSString stringWithFormat:@"Auth结果"];
        NSString *strMsg = [NSString stringWithFormat:@"code:%@,state:%@,errcode:%d", temp.code, temp.state, temp.errCode];
        NSLog(@"%@%@", strTitle, strMsg);
        [self getAccess_token:temp.code];
    }
}

-(void)getAccess_token:(NSString *)code{
    NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",WEIXIN_APP_ID,WEIXIN_APP_SECRET,code];
    NSURL *zoneUrl = [NSURL URLWithString:url];
    NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
    NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
    if (data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@", dic);
        //保持用户的sina微博信息,设置登陆成功
        [self.userInfo setValue:dic forKey:@"wx_info"];
        self.isLogin = YES;
        //持久化用户信息
        [self.userDefaults setObject:self.userInfo forKey:@"USER_INFO"];
        [self.userDefaults synchronize];
        [self postMessage];
    }
}

#pragma weiboSDK delegate method
- (void) didReceiveWeiboResponse:(WBBaseResponse *)response{
    
    if ([response isKindOfClass:WBAuthorizeResponse.class])
    {
        NSString *title = NSLocalizedString(@"认证结果", nil);
        NSString *message = [NSString stringWithFormat:@"%@: %d\nresponse.userId: %@\nresponse.accessToken: %@\n%@: %@\n%@: %@", NSLocalizedString(@"响应状态", nil), (int)response.statusCode,[(WBAuthorizeResponse *)response userID], [(WBAuthorizeResponse *)response accessToken],  NSLocalizedString(@"响应UserInfo数据", nil), response.userInfo, NSLocalizedString(@"原请求UserInfo数据", nil), response.requestUserInfo];
        NSLog(@"%@",title);
        NSLog(@"%@",message);
        [self performSelectorOnMainThread:@selector(loginSuccess) withObject:self waitUntilDone:NO];
        //保持用户的sina微博信息,设置登陆成功
        [self.userInfo setValue:response.userInfo forKey:@"wb_info"];
        self.isLogin = YES;
        //持久化用户信息
        [self.userDefaults setObject:self.userInfo forKey:@"USER_INFO"];
        [self.userDefaults synchronize];
        [self postMessage];
    }
}

- (void) didReceiveWeiboRequest:(WBBaseRequest *)request{}

@end
