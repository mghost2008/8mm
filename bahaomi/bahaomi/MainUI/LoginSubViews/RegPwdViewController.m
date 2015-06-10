//
//  RegPwdViewController.m
//  bahaomi
//
//  Created by  王国众 on 15/6/9.
//  Copyright (c) 2015年 yuedongxinji. All rights reserved.
//

#import "RegPwdViewController.h"
#import "AppDelegate.h"

@interface RegPwdViewController ()

@end

@implementation RegPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildLayout];
}

- (void)buildLayout{
    [self.pwdField setLeftViewMode:UITextFieldViewModeAlways];
    [self.pwdField setLeftView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"password"]]];
    [self.navigationItem setRightBarButtonItem:self.complateBtn];
    
}

- (UIBarButtonItem *)complateBtn{
    if (!_complateBtn) {
        _complateBtn = [[UIBarButtonItem alloc] initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(complateBtnClick)];
    }
    return _complateBtn;
}

- (void)setTelNum:(NSString *)telNum{
    _telNum = telNum;
    NSString *vcodeUrl = [NSString stringWithFormat:REG_TEL_REQUEST_VCODE,_telNum];
    [NetworkUtil JSONDataWithUrl:vcodeUrl success:^(id json){
        NSLog(@"---------------短信已经下发");
    }fail:^(void){
        NSLog(@"---------------短信下发失败");
    }];
}

- (void)complateBtnClick{
    NSString *pwd = [self.pwdField text];
    if (pwd != nil && [pwd length] > 0) {
        NSString *url = [NSString stringWithFormat:REG_TEL_REQUEST_REG, pwd];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:self.telNum forKey:@"phoneNum"];
        [params setObject:pwd forKey:@"password"];
        [NetworkUtil postJSONWithUrl:url parameters:params success:^(id responseObject){
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            [appDelegate setUserInfo:responseObject];
            [appDelegate setIsLogin:YES];
    [self dismissViewControllerAnimated:NO completion:^(void){
                [[NSNotificationCenter defaultCenter] postNotificationName:CLOSE_LOGINVIEW object:nil];
            if ([appDelegate isLogin]) {
                [appDelegate.rootTabController setSelectedIndex:3];
            }
    }];
        }fail:^(void){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"注册失败，请联系管理员" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入密码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
