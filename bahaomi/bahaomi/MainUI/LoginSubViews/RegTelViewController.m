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
    [self.navigationItem setLeftBarButtonItem:self.closeItem];
    [self.navigationItem setRightBarButtonItem:self.rightBtn];
}

- (RegPwdViewController *)pwdController{
    if (!_pwdController) {
        _pwdController = [[RegPwdViewController alloc] init];
        [_pwdController setTitle:@"密码"];
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
    [self.navigationController pushViewController:self.pwdController animated:YES];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
