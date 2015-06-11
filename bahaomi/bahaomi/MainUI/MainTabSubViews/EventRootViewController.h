//
//  EventRootViewController.h
//  bahaomi
//
//  Created by  王国众 on 15/6/8.
//  Copyright (c) 2015年 yuedongxinji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventStartedListController.h"
#import "EventEndedListController.h"

@interface EventRootViewController : UIViewController

@property (strong, nonatomic) EventStartedListController *listViewCtl;
@property (strong, nonatomic) EventEndedListController *endListViewCtl;

@end