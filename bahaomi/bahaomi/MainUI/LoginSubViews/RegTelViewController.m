//
//  RegTelViewController.m
//  bahaomi
//
//  Created by  王国众 on 15/6/9.
//  Copyright (c) 2015年 yuedongxinji. All rights reserved.
//

#import "RegTelViewController.h"

@interface RegTelViewController ()

@end

@implementation RegTelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildLayout];
}

- (void)buildLayout{
    [self.telNum setLeftViewMode:UITextFieldViewModeAlways];
    [self.telNum setLeftView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"telnum"]]];
    [self.password setLeftViewMode:UITextFieldViewModeAlways];
    [self.password setLeftView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"password"]]];
    [self.navigationItem setLeftBarButtonItem:self.closeItem];
    [self.navigationItem setRightBarButtonItem:self.rightBtn];
}

- (RegPwdViewController *)pwdController{
    if (!_pwdController) {
        _pwdController = [[RegPwdViewController alloc] init];
        [_pwdController setTitle:@"验证码"];
    }
    return _pwdController;
}

- (UIBarButtonItem *) rightBtn{
    if (!_rightBtn) {
        _rightBtn = [[UIBarButtonItem alloc] initWithTitle:@"下一步" style:UIBarButtonItemStylePlain target:self action:@selector(rightBtnClick:)];
    }
    
    return _rightBtn;
}

- (void)rightBtnClick:(UIBarButtonItem *)item{
    NSString *telnumber = self.telNum.text;
    NSString *pwd = self.password.text;
    if ([telnumber length] > 0 && [pwd length] > 0 ) {
        [self.pwdController setTelNum:telnumber andPwd:pwd];
        [self.navigationController pushViewController:self.pwdController animated:YES];
    }else{
        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入电话号码和密码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertview show];
    }
    
}

- (UIBarButtonItem *)closeItem{
    if (!_closeItem) {
        _closeItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backimg"] style:UIBarButtonItemStylePlain target:self action:@selector(closeTelLoginView:)];
    }
    return _closeItem;
}

- (void)closeTelLoginView:(UIBarButtonItem *)item{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
