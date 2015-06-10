//
//  ReportViewController.h
//  bahaomi
//
//  Created by lamto on 15/6/10.
//  Copyright (c) 2015年 yuedongxinji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Message.h"
#import "ALAlertBanner.h"

@interface ReportViewController : UIViewController

- (IBAction)firstClick:(UIButton *)sender;
- (IBAction)secondClick:(UIButton *)sender;
- (IBAction)thirdClick:(UIButton *)sender;
- (IBAction)fourthClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *firstBtn;
@property (weak, nonatomic) IBOutlet UIButton *secondBtn;
@property (weak, nonatomic) IBOutlet UIButton *thirdBtn;
@property (weak, nonatomic) IBOutlet UIButton *fourthBtn;
@property (nonatomic, strong) UIBarButtonItem *backItem;
@property (nonatomic, strong) UIBarButtonItem *comitItem;

@end
