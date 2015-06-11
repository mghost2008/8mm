//
//  EventRootViewController.m
//  bahaomi
//
//  Created by  王国众 on 15/6/8.
//  Copyright (c) 2015年 yuedongxinji. All rights reserved.
//

#import "EventRootViewController.h"

@interface EventRootViewController ()

@end

@implementation EventRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.listViewCtl.view];
}

- (EventStartedListController *) listViewCtl{
    if (!_listViewCtl) {
        _listViewCtl = [[EventStartedListController alloc] init];
        [_listViewCtl setNavController:self.navigationController];
        [_listViewCtl.tableView setFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 108)];
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"结束活动" style:UIBarButtonItemStylePlain target:self action:@selector(endedClick:)];
        [self.navigationItem setRightBarButtonItem: rightItem];
    }
    return _listViewCtl;
}

- (EventEndedListController *) endListViewCtl{
    if (!_endListViewCtl) {
        _endListViewCtl = [[EventEndedListController alloc] init];
        [_endListViewCtl setNavController:self.navigationController];
        [_endListViewCtl.tableView setFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 108)];
        [_endListViewCtl setNavController:self.navigationController];
    }
    return _endListViewCtl;
}

- (void) endedClick:(UIBarButtonItem *) item{
    [self.endListViewCtl setTitle:@"结束活动"];
    [self.navigationController pushViewController:self.endListViewCtl animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
