//
//  IndexRootViewController.m
//  bahaomi
//
//  Created by  王国众 on 15/6/8.
//  Copyright (c) 2015年 yuedongxinji. All rights reserved.
//

#import "IndexRootViewController.h"

@interface IndexRootViewController ()

@end

@implementation IndexRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildLayout];
}

- (void) buildLayout{
    [self.view addSubview:self.viewPage.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (ViewPageController *) viewPage{
    if (!_viewPage) {
        _viewPage = [[ViewPageController alloc] init];
        NewsListViewController *hotnews = [[NewsListViewController alloc] init];
        hotnews.title = @"热文推荐";
        DynamicListViewController *dynamicnews = [[DynamicListViewController alloc] init];
        dynamicnews.title = @"行业动态";
        [_viewPage addChildViewController:hotnews];
        [_viewPage addChildViewController:dynamicnews];
    }
    return _viewPage;
}

@end
