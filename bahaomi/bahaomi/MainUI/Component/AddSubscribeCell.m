//
//  AddSubscribeCell.m
//  bahaomi
//
//  Created by  王国众 on 15/5/28.
//  Copyright (c) 2015年 yuedongxinji. All rights reserved.
//

#import "AddSubscribeCell.h"

@implementation AddSubscribeCell

- (void)awakeFromNib {
    // Initialization code
}

- (void) setInfoDic:(NSDictionary *) infoDic{
    _infoDic = infoDic;
    self.mainTitle.text = [_infoDic objectForKey:@"accountName"];
    NSString *imgurl = [_infoDic objectForKey:@"img"];
    NSLog(@"%@", imgurl);
    if (![[_infoDic objectForKey:@"img"] isKindOfClass:[NSNull class]]) {
        [self.mainImg setImageWithURL:[NSURL URLWithString:[_infoDic objectForKey:@"img"]]];
    }
    [self.addBtn setImage:[UIImage imageNamed:@"addsubimg"] forState:UIControlStateNormal];
    [self.addBtn setImage:[UIImage imageNamed:@"addedimg"] forState:UIControlStateSelected];
    [self.addBtn setUserInteractionEnabled:NO];
}

- (void)setSubscribed:(BOOL)status{
    self.addBtn.selected = status;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)addBtnClick:(UIButton *)sender {
    self.addBtn.selected = !self.addBtn.selected;
}
@end
