//
//  LoginRootViewController.m
//  bahaomi
//
//  Created by  王国众 on 15/6/8.
//  Copyright (c) 2015年 yuedongxinji. All rights reserved.
//

#import "LoginRootViewController.h"

@interface LoginRootViewController ()

@end

@implementation LoginRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (TelLoginViewController *) telLoginController{
    if (!_telLoginController) {
        _telLoginController = [[TelLoginViewController alloc] init];
    }
    return _telLoginController;
}

- (UINavigationController *) loginNav{
    if (!_loginNav) {
        _loginNav = [[UINavigationController alloc] initWithRootViewController:self.telLoginController];
    }
    return  _loginNav;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)closeLoginView:(UIButton *)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:CLOSE_LOGINVIEW object:nil];
}

- (IBAction)telLogin:(UIButton *)sender {
    [self.telLoginController setTitle:@"手机号登陆"];
    [self presentViewController:self.loginNav animated:YES completion:nil];
}

- (IBAction)weiboLogin:(UIButton *)sender {
}

- (IBAction)weixinLogin:(UIButton *)sender {
}

- (IBAction)regUser:(UIButton *)sender {
}

@end
