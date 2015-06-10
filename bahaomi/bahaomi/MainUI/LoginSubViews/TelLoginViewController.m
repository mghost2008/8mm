//
//  TelLoginViewController.m
//  bahaomi
//
//  Created by  王国众 on 15/6/9.
//  Copyright (c) 2015年 yuedongxinji. All rights reserved.
//

#import "TelLoginViewController.h"
#import "AppDelegate.h"

@interface TelLoginViewController ()

@end

@implementation TelLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildLayout];
}

- (void)buildLayout{
    [self.telNumField setLeftViewMode:UITextFieldViewModeAlways];
    [self.pwdField setLeftViewMode:UITextFieldViewModeAlways];
    [self.telNumField setLeftView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"telnum"]]];
    [self.pwdField setLeftView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"password"]]];
    [self.navigationItem setLeftBarButtonItem:self.closeItem];
}

- (IBAction)loginBtnClick:(UIButton *)sender {
    NSString *telval = self.telNumField.text;
    NSString *pwdval = self.pwdField.text;
    if (telval != nil && pwdval != nil && [telval length]>0 && [pwdval length]>0) {
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:telval forKey:@"phoneNum"];
        [params setObject:pwdval forKey:@"password"];
        [NetworkUtil postJSONWithUrl:TEL_PWD_LOGIN parameters:params success:^(id responseObject){
            NSMutableDictionary *result = responseObject;
            if ([[result objectForKey:@"id"] integerValue]==0) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"用户名或者密码错误，请验证" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alert show];
            }else{
                AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                [appDelegate setUserInfo:result];
                [appDelegate setIsLogin:YES];
                [self dismissViewControllerAnimated:NO completion:^(void){
                    [[NSNotificationCenter defaultCenter] postNotificationName:CLOSE_LOGINVIEW object:nil];
                    if ([appDelegate isLogin]) {
                        [appDelegate.rootTabController setSelectedIndex:3];
                    }
                }];
            }
        } fail:^(void){
            NSLog(@"USER LOGIN FIELD");
        }];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"用户名或密码不能为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }
}

- (UIBarButtonItem *)closeItem{
    if (!_closeItem) {
        _closeItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backimg"] style:UIBarButtonItemStylePlain target:self action:@selector(closeTelLoginView)];
    }
    return _closeItem;
}

- (void)closeTelLoginView{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
