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
    [self initCommend];
    [self initUserBookInfo];
    [self initCollectInfo];
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showALAlertBanner:) name:SHOW_BANNER object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showAlertView:) name:SHOW_HUD object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userInfoChanged) name:USER_INFO_CHANGED object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userUnbound) name:USER_UNBOUND object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userCollectChanged) name:USER_COLLECT_CHANGE object:nil];
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

//初始化公众号列表
- (void) initCommend{
    [NetworkUtil JSONDataWithUrl:SUBSCRIBE_FIND_ALL success:^(id json){
        self.commendArr = json;
        //清空数据库
        [[DBUtil sharedManager] deleteAllCommend];
        [[DBUtil sharedManager] insertAllCommend:self.commendArr];
        self.commendArr = [[DBUtil sharedManager] getAllCommend];
    }fail:^(void){
        NSLog(@"初始化公众列表失败");
    }];
}

//初始化用户订阅的公众号,需要用户登录
- (void) initUserBookInfo{
    if (self.isLogin) {
        NSString *url = [NSString stringWithFormat:SUBSCRIBE_BY_USER, [self.userInfo objectForKey:@"id"]];
        [NetworkUtil JSONDataWithUrl:url success:^(id json){
            self.bookArr = json;
            //清空用户订阅列表
            [[DBUtil sharedManager] deleteAllBook];
            [[DBUtil sharedManager] insertAllBook:self.bookArr];
            self.bookArr = [[DBUtil sharedManager] getAllBook];
        }fail:^(void){
            NSLog(@"初始化用户订阅列表失败");
        }];
    }
}

//初始化用户收藏列表
- (void) initCollectInfo{
    if (self.isLogin) {
        NSString *url = [NSString stringWithFormat:USER_COLLECT_LIST, [self.userInfo objectForKey:@"id"]];
        [NetworkUtil JSONDataWithUrl:url success:^(id json){
            self.collectArr = json;//暂时不存数据库，每次启动读取
            //清空用户订阅列表
//            [[DBUtil sharedManager] deleteAllCollect];
//            [[DBUtil sharedManager] insertAllCollect:self.collectArr];
//            self.collectArr = [[DBUtil sharedManager] getAllCollect];
        }fail:^(void){
            NSLog(@"初始化用户订阅列表失败");
        }];
    }
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
    }];
}

//用户信息改变
- (void)userInfoChanged{
    [NetworkUtil postJSONWithUrl:UPDATE_USER_INFO parameters:self.userInfo success:^(id responseObject){
        self.isLogin = YES;
        [[NSNotificationCenter defaultCenter] postNotificationName:USER_SETTING_REBIND object:nil];
    } fail:^(void){
        NSLog(@"NETWORK ERROR");
    }];
}

//用户解绑社会化分享
- (void)userUnbound{
    [NetworkUtil postJSONWithUrl:UNBOUND_USER parameters:self.userInfo success:^(id responseObject){
        self.isLogin = YES;
        [[NSNotificationCenter defaultCenter] postNotificationName:USER_SETTING_REBIND object:nil];
    } fail:^(void){
        NSLog(@"NETWORK ERROR");
    }];
}

//用户收藏改变
- (void)userCollectChanged{
    if (self.isLogin) {
        NSString *url = [NSString stringWithFormat:USER_COLLECT_LIST, [self.userInfo objectForKey:@"id"]];
        [NetworkUtil JSONDataWithUrl:url success:^(id json){
            self.collectArr = json;//暂时不存数据库，每次启动读取
            [[NSNotificationCenter defaultCenter] postNotificationName:USER_COLLECT_CHANGED object:nil];
        }fail:^(void){
            NSLog(@"初始化用户订阅列表失败");
        }];
    }
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

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    return [WeiboSDK handleOpenURL:url delegate:self] || [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return [WeiboSDK handleOpenURL:url delegate:self] || [WXApi handleOpenURL:url delegate:self];
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
        if (temp.errCode == 0) {
            [self getAccess_token:temp.code];
        }
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
        self.weixinInfo = [NSMutableDictionary dictionaryWithDictionary:dic];
        [[NSUserDefaults standardUserDefaults] setObject:self.weixinInfo forKey:@"WX_INFO"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        if (self.isLogin) {//已经登录为绑定
            [self.userInfo setObject:[self.weixinInfo objectForKey:@"openid"] forKey:@"weixin"];
            [[NSNotificationCenter defaultCenter] postNotificationName:USER_INFO_CHANGED object:nil];
            [[NSUserDefaults standardUserDefaults] setObject:self.userInfo forKey:@"USER_INFO"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }else{
            NSMutableDictionary *newUser = [NSMutableDictionary dictionary];
            [newUser setObject:[self.weixinInfo objectForKey:@"openid"] forKey:@"weixin"];
            self.userInfo = newUser;
            [self registerUser];
        }
    }
}

#pragma weiboSDK delegate method
- (void) didReceiveWeiboResponse:(WBBaseResponse *)response{
    
    if ([response isKindOfClass:WBAuthorizeResponse.class])
    {
        WBAuthorizeResponse *responseObj = (WBAuthorizeResponse *)response;
        self.weiboInfo  = [NSMutableDictionary dictionaryWithDictionary:responseObj.userInfo];
        [[NSUserDefaults standardUserDefaults] setObject:self.weiboInfo forKey:@"WB_INFO"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        if (self.isLogin) {//已经登录为绑定
            [self.userInfo setObject:[self.weiboInfo objectForKey:@"uid"] forKey:@"weibo"];
            [[NSNotificationCenter defaultCenter] postNotificationName:USER_INFO_CHANGED object:nil];
            [[NSUserDefaults standardUserDefaults] setObject:self.userInfo forKey:@"USER_INFO"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }else{
            NSMutableDictionary *newUser = [NSMutableDictionary dictionary];
            [newUser setObject:[self.weiboInfo objectForKey:@"uid"] forKey:@"weibo"];
            self.userInfo = newUser;
            [self registerUser];
        }
    }
}

- (void) didReceiveWeiboRequest:(WBBaseRequest *)request{}

- (void) registerUser{
    [NetworkUtil postJSONWithUrl:REG_OAUTH_USER parameters:self.userInfo success:^(id responseObj){
        self.userInfo = responseObj;
        NSLog(@"%@", self.userInfo);
        self.isLogin = YES;
        [[NSNotificationCenter defaultCenter] postNotificationName:CLOSE_LOGINVIEW object:nil];
        [self.rootTabController setSelectedIndex:3];
    }fail:^(void){
        
    }];
}

- (void) showALAlertBanner:(NSNotification*)aNotification{
    NSMutableDictionary *param = [aNotification object];
    ALAlertBannerStyle randomStyle = (ALAlertBannerStyle)[[param objectForKey:@"style"] integerValue];
    ALAlertBannerPosition position = ALAlertBannerPositionUnderNavBar;
    ALAlertBanner *banner = [ALAlertBanner alertBannerForView:self.window style:randomStyle position:position title:[param objectForKey:@"title"] subtitle:[param objectForKey:@"subtitle"] tappedBlock:^(ALAlertBanner *alertBanner) {
        [alertBanner hide];
    }];
    banner.secondsToShow = 3.5;
    banner.showAnimationDuration = 0.25;
    banner.hideAnimationDuration = 0.2;
    [banner show];
}

- (void) showAlertView:(NSNotification*)aNotification{
    NSMutableDictionary *param = [aNotification object];
    [HUD showUIBlockingIndicatorWithText:[param objectForKey:@"subtitle"] withTimeout:2.0];
}

@end
