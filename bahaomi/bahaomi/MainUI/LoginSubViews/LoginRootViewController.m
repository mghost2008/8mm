//
//  LoginRootViewController.m
//  bahaomi
//
//  Created by  王国众 on 15/6/8.
//  Copyright (c) 2015年 yuedongxinji. All rights reserved.
//

#import "LoginRootViewController.h"
#import "AppDelegate.h"

@interface LoginRootViewController ()

@end

@implementation LoginRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    // Do any additional setup after loading the view from its nib.
}

- (TelLoginViewController *) telLoginController{
    if (!_telLoginController) {
        _telLoginController = [[TelLoginViewController alloc] init];
    }
    return _telLoginController;
}

- (RegTelViewController *) regTelControler{
    if (!_regTelControler) {
        _regTelControler = [[RegTelViewController alloc] init];
    }
    return _regTelControler;
}

- (UINavigationController *) loginNav{
    if (!_loginNav) {
        _loginNav = [[UINavigationController alloc] initWithRootViewController:self.telLoginController];
    }
    return  _loginNav;
}

- (UINavigationController *) regNav{
    if (!_regNav) {
        _regNav = [[UINavigationController alloc] initWithRootViewController:self.regTelControler];
    }
    return _regNav;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closeLoginView:(UIButton *)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:CLOSE_LOGINVIEW object:nil];
}

- (IBAction)telLogin:(UIButton *)sender {
    [self.telLoginController setTitle:@"手机号登陆"];
    [self presentViewController:self.loginNav animated:YES completion:nil];
}

- (IBAction)weiboLogin:(UIButton *)sender {
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = WEIBO_APP_REDIRECT_URI;
    request.scope = @"all";
    [WeiboSDK sendRequest:request];
}

- (IBAction)weixinLogin:(UIButton *)sender {
    //构造SendAuthReq结构体
    SendAuthReq* req =[[SendAuthReq alloc ] init ];
    req.scope = @"snsapi_userinfo" ;
    req.state = @"123" ;
    //第三方向微信终端发送一个SendAuthReq消息结构
    //检测是否安装微信
    if ([WXApi isWXAppInstalled]) {
        [WXApi sendReq:req];
    }else{
        [WXApi sendAuthReq:req viewController:self delegate:(AppDelegate *)[[UIApplication sharedApplication] delegate] ];
    }
}

- (IBAction)regUser:(UIButton *)sender {
    [self.regTelControler setTitle:@"注册"];
    [self presentViewController:self.regNav animated:YES completion:nil];
}

@end
