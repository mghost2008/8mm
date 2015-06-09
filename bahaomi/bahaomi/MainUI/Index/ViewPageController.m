//
//  ViewPageController.m
//  bahaomi
//
//  Created by  王国众 on 15/6/10.
//  Copyright (c) 2015年 yuedongxinji. All rights reserved.
//

#import "ViewPageController.h"

@interface ViewPageController ()

@end

@implementation ViewPageController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildLayout];
}

- (void) buildLayout{
    [self.topView addSubview:self.buttomImg];
    [self.hotNewsBtn setSelected:YES];
    [self.tradeNewsBtn setSelected:NO];
}

- (UIImageView *) buttomImg{
    if (!_buttomImg) {
        _buttomImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"btnbottom"]];
        [_buttomImg setFrame:CGRectMake(0, 42, self.view.frame.size.width/2, 2)];
    }
    return _buttomImg;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)hotNewsBtnClick:(UIButton *)sender {
    [self.hotNewsBtn setSelected:YES];
    [self.tradeNewsBtn setSelected:NO];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2f];
    [self.buttomImg setFrame:CGRectMake(0, 42, self.view.frame.size.width/2, 2)];
    [UIView commitAnimations];
}

- (IBAction)tradeNewsBtnClick:(UIButton *)sender {
    [self.hotNewsBtn setSelected:NO];
    [self.tradeNewsBtn setSelected:YES];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2f];
    [self.buttomImg setFrame:CGRectMake(self.view.frame.size.width/2, 42, self.view.frame.size.width/2, 2)];
    [UIView commitAnimations];
    
}
@end
