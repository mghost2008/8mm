//
//  RegPwdViewController.m
//  bahaomi
//
//  Created by  王国众 on 15/6/9.
//  Copyright (c) 2015年 yuedongxinji. All rights reserved.
//

#import "RegPwdViewController.h"

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
