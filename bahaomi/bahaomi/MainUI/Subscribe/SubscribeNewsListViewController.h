//
//  SubscribeNewsListViewController.h
//  bahaomi
//
//  Created by lamto on 15/5/27.
//  Copyright (c) 2015年 yuedongxinji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"
#import "Util.h"
#import "NetworkUtil.h"
#import "SmallCell.h"
#import "LargeCell.h"
#import "DetailViewController.h"

@interface SubscribeNewsListViewController : UITableViewController

@property (nonatomic, copy) NSMutableDictionary *infoDic;
@property (nonatomic, strong) NSDate *curDate;
@property (nonatomic, strong) NSDate *lastDate;
@property (nonatomic, strong) NSMutableArray *infoArr;

@end
