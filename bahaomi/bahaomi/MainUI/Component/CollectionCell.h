//
//  CollectionCell.h
//  bahaomi
//
//  Created by lamto on 15/5/26.
//  Copyright (c) 2015年 yuedongxinji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+AFNetworking.h"

@interface CollectionCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *mainImage;
@property (weak, nonatomic) IBOutlet UILabel *mainLabel;

@property (strong, nonatomic) NSMutableDictionary *infoDic;

@end
