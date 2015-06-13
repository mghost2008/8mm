//
//  MyMainViewController.h
//  bahaomi
//
//  Created by  王国众 on 15/6/10.
//  Copyright (c) 2015年 yuedongxinji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Info.h"
#import "Message.h"
#import "MySettingsViewController.h"
#import "CollectViewController.h"

@interface MyMainViewController : UITableViewController

@property (strong, nonatomic) UINavigationController *navController;
@property (strong, nonatomic) MySettingsViewController *settingController;
@property (strong, nonatomic) CollectViewController *collectController;

@end
