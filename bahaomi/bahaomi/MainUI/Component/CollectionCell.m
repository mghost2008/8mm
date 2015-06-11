//
//  CollectionCell.m
//  bahaomi
//
//  Created by lamto on 15/5/26.
//  Copyright (c) 2015年 yuedongxinji. All rights reserved.
//

#import "CollectionCell.h"

@implementation CollectionCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // 初始化时加载collectionCell.xib文件
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"CollectionCell" owner:self options:nil];
        
        // 如果路径不存在，return nil
        if (arrayOfViews.count < 1)
        {
            return nil;
        }
        // 如果xib中view不属于UICollectionViewCell类，return nil
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]])
        {
            return nil;
        }
        // 加载nib
        self = [arrayOfViews objectAtIndex:0];
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}

- (void)setInfoDic:(NSMutableDictionary *)infoDic{
    _infoDic = infoDic;
    self.mainLabel.text = [_infoDic objectForKey:@"accountName"];
    [self.mainImage setImageWithURL:[NSURL URLWithString:[_infoDic objectForKey:@"img"]]];
}

- (void)awakeFromNib {
    // Initialization code
}

@end
