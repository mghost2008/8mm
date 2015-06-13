//
//  BindTelController.m
//  bahaomi
//
//  Created by lamto on 15/6/12.
//  Copyright (c) 2015年 yuedongxinji. All rights reserved.
//

#import "BindTelController.h"
#import "AppDelegate.h"

@interface BindTelController (){
    AppDelegate *appDelegate;
}

@end

@implementation BindTelController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildLayout];
}

- (void)buildLayout{
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self.telNum setLeftViewMode:UITextFieldViewModeAlways];
    [self.telNum setKeyboardType:UIKeyboardTypeNumberPad];
    [self.telNum setLeftView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"telnum"]]];
    [self.telNum setText:[appDelegate.userInfo objectForKey:@"phoneNum"]?[appDelegate.userInfo objectForKey:@"phoneNum"]:@""];
    [self.navigationItem setLeftBarButtonItem:self.backItem];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIBarButtonItem *)backItem{
    if (!_backItem) {
        _backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backimg"] style:UIBarButtonItemStylePlain target:self action:@selector(backItemClick:)];
    }
    return _backItem;
}

- (void)backItemClick:(UIBarButtonItem *)item{
    NSString *numstr = self.telNum.text;
    NSString *oldnumstr = [appDelegate.userInfo valueForKey:@"phoneNum"];
    if ([numstr length] == 11) {//电话号码
        if (![numstr isEqualToString:oldnumstr]) {
            [appDelegate.userInfo setValue:numstr forKey:@"phoneNum"];
            [[NSNotificationCenter defaultCenter] postNotificationName:USER_INFO_CHANGED object:nil];
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
