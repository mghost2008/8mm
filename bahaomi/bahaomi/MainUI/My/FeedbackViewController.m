//
//  FeedbackViewController.m
//  bahaomi
//
//  Created by  王国众 on 15/6/22.
//  Copyright (c) 2015年 yuedongxinji. All rights reserved.
//

#import "FeedbackViewController.h"
#import "AppDelegate.h"

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
    [self.navigationItem setRightBarButtonItem:self.submitBtn];
    
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        [self setAutomaticallyAdjustsScrollViewInsets:NO];
    }
}

- (UIBarButtonItem *)submitBtn{
    if (!_submitBtn) {
        _submitBtn = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(submitBtnClick:)];
    }
    return _submitBtn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submitBtnClick:(UIBarButtonItem *)btn {
    if ([self.feedbackTextView.text length] == 0) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:@"请填写反馈内容" forKey:@"subtitle"];
        [[NSNotificationCenter defaultCenter] postNotificationName:SHOW_HUD object:dic];
        return;
    }else{
        NSString *content = self.feedbackTextView.text;
        NSString *contactInfo = self.contactTextView.text;
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:[appDelegate.userInfo objectForKey:@"id" ]  forKey:@"userId"];
        [params setObject:content forKey:@"content"];
        [params setObject:contactInfo forKey:@"contactInfo"];
        [NetworkUtil postJSONWithUrl:FEED_BACK_CREATE parameters:params success:^(id responseObject){
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setValue:@"已提交" forKey:@"subtitle"];
            [[NSNotificationCenter defaultCenter] postNotificationName:SHOW_HUD object:dic];
            [self.navigationController popViewControllerAnimated:YES];
        }fail:^(void){
            NSLog(@"NETWORK ERROR");
        }];
        

    }
}
@end
