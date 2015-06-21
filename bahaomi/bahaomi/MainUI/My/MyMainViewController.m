//
//  MyMainViewController.m
//  bahaomi
//
//  Created by  王国众 on 15/6/10.
//  Copyright (c) 2015年 yuedongxinji. All rights reserved.
//

#import "MyMainViewController.h"
#import "AppDelegate.h"

@interface MyMainViewController ()

@end

@implementation MyMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildLayout];
}

- (void)buildLayout{
    [self.view setFrame:CGRectMake(0, 108, self.view.frame.size.width, self.view.frame.size.height-140)];
    [self.view setBackgroundColor:UIColorFromRGB(0xF4F8FB)];
    [self.tableView setTableFooterView:[[UIView alloc] init]];
    [self.tableView setScrollEnabled:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 5;
    }else{
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:{
                [self.collectController setTitle:@"收藏"];
                [self.navController pushViewController:self.collectController animated:YES];
            }
                break;
            case 1:{
                
            }
                break;
            case 2:{
                
            }
                break;
            case 3:{
                [self.feedbackController setTitle:@"反馈"];
                [self.feedbackController.feedbackTextView setText:@""];
                [self.navController pushViewController:self.feedbackController animated:YES];
            }
                break;
            case 4:{
                [self.settingController setTitle:@"设置"];
                [self.navController pushViewController:self.settingController animated:YES];
            }
                break;
            default:
                break;
        }
    }
    if (indexPath.section == 1) {
        [self logout];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *mycellidentifier = @"MyMainCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:mycellidentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mycellidentifier];
    }
    [cell.textLabel setTextColor:UIColorFromRGB(0x5b5b5b)];
    [cell.textLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];
    if (indexPath.section == 0) {
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        switch (indexPath.row) {
            case 0:
                [cell.textLabel setText:@"收藏"];
                break;
            case 1:
                [cell.textLabel setText:@"活动"];
                break;
            case 2:
                [cell.textLabel setText:@"消息"];
                break;
            case 3:
                [cell.textLabel setText:@"反馈"];
                break;
            case 4:
                [cell.textLabel setText:@"设置"];
                break;
            default:
                break;
        }
    }else{
        [cell.textLabel setText:@"退出登录"];
        [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
    }
    
    return cell;
}

//section底部间距
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 15;
}
//section底部视图
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view;
    if (section == 0) {
        view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 15)];
    }else{
        view = [[UIView alloc] init];
    }
    return view;
}

- (void) logout{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [delegate setWeiboInfo:[NSMutableDictionary dictionary]];
    [[NSUserDefaults standardUserDefaults] setObject:delegate.weiboInfo forKey:@"WB_INFO"];
    [delegate setWeixinInfo:[NSMutableDictionary dictionary]];
    [[NSUserDefaults standardUserDefaults] setObject:delegate.weixinInfo forKey:@"WX_INFO"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [delegate.rootTabController setSelectedIndex:0];
    [delegate setIsLogin:NO];
}

- (MySettingsViewController *)settingController{
    if (!_settingController) {
        _settingController = [[MySettingsViewController alloc] init];
    }
    return _settingController;
}

- (CollectViewController *)collectController{
    if (!_collectController) {
        _collectController = [[CollectViewController alloc] init];
    }
    return _collectController;
}

- (FeedbackViewController *)feedbackController{
    if (!_feedbackController) {
        _feedbackController = [[FeedbackViewController alloc] init];
    }
    return _feedbackController;
}
                 
@end
