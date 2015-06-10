//
//  LargeCell.m
//  bahaomi
//
//  Created by  王国众 on 15/6/10.
//  Copyright (c) 2015年 yuedongxinji. All rights reserved.
//

#import "LargeCell.h"

@implementation LargeCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){}
    return self;
}

- (void) setInfoDic:(NSDictionary *) infoDic{
    _infoDic = infoDic;
    self.mainTitle.text = [_infoDic objectForKey:@"title"];
    NSLog(@"%@",self.mainTitle.text);
    self.subTitle.text = [NSString stringWithFormat:@"%@/%@",[_infoDic objectForKey:@"accountName"],[_infoDic objectForKey:@"pubDate"]];
    [self.mainImage setImageWithURL:[NSURL URLWithString:[_infoDic objectForKey:@"largeImg"]]];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
