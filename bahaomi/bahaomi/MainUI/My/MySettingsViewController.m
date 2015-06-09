//
//  MySettingViewController.m
//  bahaomi
//
//  Created by lamto on 15/6/5.
//  Copyright (c) 2015年 yuedongxinji. All rights reserved.
//

#import "MySettingsViewController.h"
#import "AppDelegate.h"

@interface MySettingsViewController (){
    AppDelegate *appDelegate;
}

@end

@implementation MySettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildLayout];
}

- (void) buildLayout{
    [self.tableView setFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 108)];
    [self.tableView setTableFooterView:[[UIView alloc] init]];
    [self.tableView setScrollEnabled:NO];
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
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
        return 3;
    }else{
        return 2;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *settingBindCellIdentifier = @"SettingBindCell";
    static NSString *settingCellIdentifier = @"SettingCell";
    if (indexPath.section == 0 ) {
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:settingBindCellIdentifier];
        if (cell == nil){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:settingBindCellIdentifier];
        }
        NSString *imgnamed = (indexPath.row == 0)?@"bindtelimg":(indexPath.row == 1)?@"bindwximg":@"bindwbimg";
        NSString *celltitle = (indexPath.row == 0)?@"手机号":(indexPath.row == 1)?@"微信":@"微博";

        NSString *bindtelstr = [appDelegate.userInfo objectForKey:@"phoneNum"]?[appDelegate.userInfo objectForKey:@"phoneNum"]:@"绑定手机";
        NSString *bindwxstr = [appDelegate.userInfo objectForKey:@"weixin"]?@"解绑微信":@"绑定微信";
        NSString *bingwbstr = [appDelegate.userInfo objectForKey:@"weibo"]?@"解绑微博":@"绑定微博";
        NSString *labeltitle = (indexPath.row == 0)?bindtelstr:(indexPath.row == 1)?bindwxstr:bingwbstr;
        [cell.imageView setImage:[UIImage imageNamed:imgnamed]];
        [cell.textLabel setText:celltitle];
        UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
        [lbl setTextAlignment:NSTextAlignmentRight];
        [lbl setText:labeltitle];
        cell.accessoryView = lbl;
        return cell;
    }else{
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:settingCellIdentifier];
        if (cell == nil){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:settingCellIdentifier];
        }
        NSString *celltitle = (indexPath.row == 0)?@"清理缓存":@"当前版本";
        NSString *app_Version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        NSString *lbltitle = (indexPath.row == 0)?@"":app_Version;
        [cell.textLabel setText:celltitle];
        UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
        [lbl setTextAlignment:NSTextAlignmentRight];
        [lbl setText:lbltitle];
        cell.accessoryView = lbl;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 20;
    }else{
        return 0;
    }
}
@end
