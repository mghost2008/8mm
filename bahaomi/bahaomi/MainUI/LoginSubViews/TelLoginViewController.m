//
//  TelLoginViewController.m
//  bahaomi
//
//  Created by  王国众 on 15/6/9.
//  Copyright (c) 2015年 yuedongxinji. All rights reserved.
//

#import "TelLoginViewController.h"

@interface TelLoginViewController ()

@end

@implementation TelLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildLayout];
    NSLog(@"%f  %f ", self.view.frame.origin.x, self.view.frame.origin.y);
}

- (void)buildLayout{
    [self.telNumField setLeftViewMode:UITextFieldViewModeAlways];
    [self.pwdField setLeftViewMode:UITextFieldViewModeAlways];
    [self.telNumField setLeftView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"telnum"]]];
    [self.pwdField setLeftView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"password"]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
