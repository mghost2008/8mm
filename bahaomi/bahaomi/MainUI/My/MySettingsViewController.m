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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userInfoChanged) name:USER_SETTING_REBIND object:nil];
    [self buildLayout];
}

- (void) userInfoChanged{
    [self.tableView reloadData];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.section == 0 ) {
        switch (indexPath.row) {
            case 0:
                {
                    [self.bindTelController setTitle:@"绑定手机号码"];
                    [self.navigationController pushViewController:self.bindTelController animated:YES];
                }
                break;
            case 1:
            {
                if ([((UILabel *)cell.accessoryView).text isEqualToString:@"绑定微信"] ) {
                    //构造SendAuthReq结构体
                    SendAuthReq* req =[[SendAuthReq alloc ] init ];
                    req.scope = @"snsapi_userinfo" ;
                    req.state = @"123" ;
                    //第三方向微信终端发送一个SendAuthReq消息结构
                    //检测是否安装微信
                    if ([WXApi isWXAppInstalled]) {
                        [WXApi sendReq:req];
                    }else{
                        [WXApi sendAuthReq:req viewController:self delegate:(AppDelegate *)[[UIApplication sharedApplication] delegate] ];
                    }
                }else{
                    [appDelegate.userInfo setObject:@"" forKey:@"weixin"];
                    [[NSNotificationCenter defaultCenter] postNotificationName:USER_UNBOUND object:nil];
                }
            }
                break;
            case 2:
            {
                if ([((UILabel *)cell.accessoryView).text isEqualToString:@"绑定微博"] ) {
                    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
                    request.redirectURI = WEIBO_APP_REDIRECT_URI;
                    request.scope = @"all";
                    [WeiboSDK sendRequest:request];
                }else{
                    [appDelegate.userInfo setObject:@"" forKey:@"weibo"];
                    [[NSNotificationCenter defaultCenter] postNotificationName:USER_UNBOUND object:nil];
                }
            }
                break;
            default:
                break;
        } 
    }
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
        NSString *bindwxstr = [appDelegate.userInfo objectForKey:@"weixin"] && [[appDelegate.userInfo objectForKey:@"weixin"] length]>0?@"解绑微信":@"绑定微信";
        NSString *bingwbstr = [appDelegate.userInfo objectForKey:@"weibo"] && [[appDelegate.userInfo objectForKey:@"weibo"] length]>0?@"解绑微博":@"绑定微博";
        NSString *labeltitle = (indexPath.row == 0)?bindtelstr:(indexPath.row == 1)?bindwxstr:bingwbstr;
        [cell.imageView setImage:[UIImage imageNamed:imgnamed]];
        [cell.textLabel setText:celltitle];
        UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 40)];
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

- (BindTelController *)bindTelController{
    if (!_bindTelController) {
        _bindTelController = [[BindTelController alloc] init];
    }
    return _bindTelController;
}

@end
