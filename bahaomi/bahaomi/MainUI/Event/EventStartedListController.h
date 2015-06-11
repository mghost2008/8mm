//
//  EventStartedListController.h
//  bahaomi
//
//  Created by lamto on 15/5/29.
//  Copyright (c) 2015年 yuedongxinji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"
#import "Util.h"
#import "NetworkUtil.h"
#import "LargeCell.h"
#import "EventDetailViewController.h"

@interface EventStartedListController : UITableViewController

@property (nonatomic, strong) NSMutableArray *infoArr;
@property (strong, nonatomic) UINavigationController *navController;
@property (nonatomic, strong) NSDate *curDate;
@property (nonatomic, strong) NSDate *lastDate;

@end
