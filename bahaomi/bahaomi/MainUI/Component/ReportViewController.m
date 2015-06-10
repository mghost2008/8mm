//
//  ReportViewController.m
//  bahaomi
//
//  Created by lamto on 15/6/10.
//  Copyright (c) 2015年 yuedongxinji. All rights reserved.
//

#import "ReportViewController.h"

@interface ReportViewController ()

@end

@implementation ReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildLayout];
}

- (void)buildLayout{
    [self.firstBtn setImage:[UIImage imageNamed:@"selectedimg"] forState:UIControlStateSelected];
    [self.secondBtn setImage:[UIImage imageNamed:@"selectedimg"] forState:UIControlStateSelected];
    [self.thirdBtn setImage:[UIImage imageNamed:@"selectedimg"] forState:UIControlStateSelected];
    [self.fourthBtn setImage:[UIImage imageNamed:@"selectedimg"] forState:UIControlStateSelected];
    [self.navigationItem setLeftBarButtonItem:self.backItem];
    [self.navigationItem setRightBarButtonItem:self.comitItem];
}

- (UIBarButtonItem *)backItem{
    if (!_backItem) {
        _backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backimg"] style:UIBarButtonItemStylePlain target:self action:@selector(backItemClick:)];
    }
    return _backItem;
}

- (void) backItemClick:(UIBarButtonItem *)item{
    [self.navigationController setToolbarHidden:NO];
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIBarButtonItem *)comitItem{
    if (!_comitItem) {
        _comitItem = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(comitItemClick:)];
    }
    return _comitItem;
}

- (void) comitItemClick:(UIBarButtonItem *)item{
    [self.navigationController setToolbarHidden:NO];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)firstClick:(UIButton *)sender {
    [self.firstBtn setSelected:YES];
    [self.secondBtn setSelected:NO];
    [self.thirdBtn setSelected:NO];
    [self.fourthBtn setSelected:NO];
}

- (IBAction)secondClick:(UIButton *)sender {
    [self.firstBtn setSelected:NO];
    [self.secondBtn setSelected:YES];
    [self.thirdBtn setSelected:NO];
    [self.fourthBtn setSelected:NO];
}

- (IBAction)thirdClick:(UIButton *)sender {
    [self.firstBtn setSelected:NO];
    [self.secondBtn setSelected:NO];
    [self.thirdBtn setSelected:YES];
    [self.fourthBtn setSelected:NO];
}

- (IBAction)fourthClick:(UIButton *)sender {
    [self.firstBtn setSelected:NO];
    [self.secondBtn setSelected:NO];
    [self.thirdBtn setSelected:NO];
    [self.fourthBtn setSelected:YES];
}
@end
