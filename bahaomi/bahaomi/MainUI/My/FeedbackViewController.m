//
//  FeedbackViewController.m
//  bahaomi
//
//  Created by  王国众 on 15/6/22.
//  Copyright (c) 2015年 yuedongxinji. All rights reserved.
//

#import "FeedbackViewController.h"

@interface FeedbackViewController ()

@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildLayout];
}

- (void)buildLayout{
    self.feedbackTextView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.feedbackTextView.layer.borderWidth = 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submitBtnClick:(id)sender {
    if ([self.feedbackTextView.text length] == 0) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:@"请填写反馈内容" forKey:@"subtitle"];
        [[NSNotificationCenter defaultCenter] postNotificationName:SHOW_HUD object:dic];
        return;
    }else{
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:@"已提交" forKey:@"subtitle"];
        [[NSNotificationCenter defaultCenter] postNotificationName:SHOW_HUD object:dic];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
@end
