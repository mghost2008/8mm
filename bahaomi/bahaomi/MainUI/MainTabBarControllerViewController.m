//
//  MainTabBarControllerViewController.m
//  bahaomi
//
//  Created by  王国众 on 15/6/8.
//  Copyright (c) 2015年 yuedongxinji. All rights reserved.
//

#import "MainTabBarControllerViewController.h"
#import "AppDelegate.h"

@interface MainTabBarControllerViewController ()

@end

@implementation MainTabBarControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildLayout];
}

- (void)buildLayout{
    [self setDelegate:self];
    self.viewControllers = [NSArray arrayWithObjects:self.firstNavController, self.secNavController, self.thirdNavController, self.fourthNavController, nil];
}

- (UINavigationController *) firstNavController{
    if (!_firstNavController) {
        _firstNavController = [[UINavigationController alloc] initWithRootViewController:self.indexRootController];
        UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:@"首页" image:[UIImage imageNamed:@"index"] tag:1001];
        _firstNavController.tabBarItem = item;
        //        [_firstNavController.navigationBar setBarTintColor:UIColorFromRGB(0x57acde)];
    }
    return _firstNavController;
}

- (IndexRootViewController *) indexRootController{
    if (!_indexRootController) {
        _indexRootController = [[IndexRootViewController alloc] init];
        [_indexRootController setTitle:@"首页"];
    }
    return _indexRootController;
}

- (UINavigationController *) secNavController{
    if (!_secNavController) {
        _secNavController = [[UINavigationController alloc] initWithRootViewController:self.subRootController];
        UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:@"订阅" image:[UIImage imageNamed:@"subscribe"] tag:1002];
        _secNavController.tabBarItem = item;
    }
    return _secNavController;
}

- (SubscribeRootViewController *)  subRootController{
    if (!_subRootController) {
        _subRootController = [[SubscribeRootViewController alloc] init];
        [_subRootController setTitle:@"订阅"];
    }
    return _subRootController;
}

- (UINavigationController *) thirdNavController{
    if (!_thirdNavController) {
        _thirdNavController = [[UINavigationController alloc] initWithRootViewController:self.actRootController];
        UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:@"活动" image:[UIImage imageNamed:@"activity"] tag:1003];
        _thirdNavController.tabBarItem = item;
    }
    return _thirdNavController;
}

- (EventRootViewController *) actRootController{
    if (!_actRootController) {
        _actRootController = [[EventRootViewController alloc] init];
        [_actRootController setTitle:@"活动"];
    }
    return _actRootController;
}

- (UINavigationController *) fourthNavController{
    if (!_fourthNavController) {
        _fourthNavController = [[UINavigationController alloc] initWithRootViewController:self.myRootController];
        UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:@"我的" image:[UIImage imageNamed:@"my"] tag:1004];
        _fourthNavController.tabBarItem = item;
    }
    return _fourthNavController;
}

- (MyRootViewController *) myRootController{
    if (!_myRootController) {
        _myRootController = [[MyRootViewController alloc] init];
        [_myRootController setTitle:@"我的"];
    }
    return _myRootController;
}

-  (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (viewController.tabBarItem.tag == 1004 && !delegate.isLogin) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NEED_LOGIN object:nil];
        return NO;
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
