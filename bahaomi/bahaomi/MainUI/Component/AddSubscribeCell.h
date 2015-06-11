//
//  AddSubscribeCell.h
//  bahaomi
//
//  Created by  王国众 on 15/5/28.
//  Copyright (c) 2015年 yuedongxinji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+AFNetworking.h"

@interface AddSubscribeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *mainImg;
@property (weak, nonatomic) IBOutlet UILabel *mainTitle;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
- (IBAction)addBtnClick:(UIButton *)sender;

@property (strong, nonatomic) NSDictionary *infoDic;

- (void)setSubscribed:(BOOL)status;

@end
