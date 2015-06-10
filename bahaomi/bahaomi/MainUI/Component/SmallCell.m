//
//  SmallCell.m
//  bahaomi
//
//  Created by  王国众 on 15/6/10.
//  Copyright (c) 2015年 yuedongxinji. All rights reserved.
//

#import "SmallCell.h"

@implementation SmallCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){}
    return self;
}

- (void)setInfoDic:(NSDictionary *)infoDic{
    if (_infoDic != infoDic) {
        _infoDic = infoDic;
    }
    self.mainTitle.text = [_infoDic objectForKey:@"title"];
    self.subTitle.text = [NSString stringWithFormat:@"%@/%@",[_infoDic objectForKey:@"accountName"],[_infoDic objectForKey:@"pubDate"]];
    [self.mainImage setImageWithURL:[NSURL URLWithString:[_infoDic objectForKey:@"smallImg"]]];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
