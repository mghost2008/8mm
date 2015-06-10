//
//  DynamicListViewController.h
//  bahaomi
//
//  Created by  王国众 on 15/6/10.
//  Copyright (c) 2015年 yuedongxinji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Info.h"
#import "LargeCell.h"
#import "SmallCell.h"
#import "MJRefresh.h"
#import "DetailViewController.h"

@interface DynamicListViewController : UITableViewController

@property (nonatomic, strong) NSDate *curDate;
@property (nonatomic, strong) NSDate *lastDate;
@property (nonatomic, strong) NSMutableArray *infodic;
@property (strong, nonatomic) UINavigationController *navController;

@end
