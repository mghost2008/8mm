//
//  ViewPageController.h
//  bahaomi
//
//  Created by  王国众 on 15/6/10.
//  Copyright (c) 2015年 yuedongxinji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewPageController : UIViewController

@property (strong, nonatomic) UIImageView *buttomImg;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIButton *hotNewsBtn;
@property (weak, nonatomic) IBOutlet UIButton *tradeNewsBtn;
- (IBAction)hotNewsBtnClick:(UIButton *)sender;
- (IBAction)tradeNewsBtnClick:(UIButton *)sender;

@end
