//
//  SubscribeCollectionController.h
//  bahaomi
//
//  Created by lamto on 15/6/11.
//  Copyright (c) 2015年 yuedongxinji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Info.h"
#import "CollectionCell.h"
#import "SubscribeNewsListViewController.h"

@interface SubscribeCollectionController : UICollectionViewController

//所有公众号列表
@property (nonatomic, strong) NSMutableArray *commendArr;
//系统推荐公众号列表
@property (nonatomic, strong) NSMutableArray *sysCommendArr;
//该用户订阅的公众号列表id索引
@property (nonatomic, strong) NSMutableArray *infoArr;
@property (nonatomic, strong) NSMutableArray *userBookArr;
@property (strong, nonatomic) UINavigationController *navController;

@end
