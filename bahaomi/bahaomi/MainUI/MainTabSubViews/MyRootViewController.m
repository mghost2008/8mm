//
//  MyRootViewController.m
//  bahaomi
//
//  Created by  王国众 on 15/6/8.
//  Copyright (c) 2015年 yuedongxinji. All rights reserved.
//

#import "MyRootViewController.h"
#import "AppDelegate.h"

@interface MyRootViewController ()

@end

@implementation MyRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setLeftBarButtonItem:self.avataItem];
    [self.view addSubview:self.mainController.view];
}

- (MyMainViewController *)mainController{
        if (!_mainController) {
            _mainController = [[MyMainViewController alloc] init];
            [_mainController setNavController:self.navigationController];
            [_mainController.tableView setFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 108)];
        }
        return _mainController;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIBarButtonItem *)avataItem{
    if (!_avataItem) {
        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        _avataItem = [[UIBarButtonItem alloc] initWithCustomView:[[UIImageView alloc] initWithImage:delegate.avata]];
    }
    return _avataItem;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
