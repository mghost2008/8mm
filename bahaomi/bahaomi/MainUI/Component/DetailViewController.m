//
//  DetailViewController.m
//  bahaomi
//
//  Created by lamto on 15/5/27.
//  Copyright (c) 2015年 yuedongxinji. All rights reserved.
//

#import "DetailViewController.h"
#import "AppDelegate.h"

@interface DetailViewController (){
    AppDelegate *appDelegate;
}

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildLayout];
    [self buildData];
}

- (void)buildLayout{
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self.webview setDelegate:self];
    [self.view addSubview:self.webview];
    [self setToolbarItems:self.items];
    [self.navigationItem setRightBarButtonItem:self.subscribeItem];
    [self.navigationItem setLeftBarButtonItem:self.backItem];
    [self.navigationController setToolbarHidden:NO];
}

- (void)buildData{
    NSLog(@"%@", self.inofDic);
    NSURL *url = [NSURL URLWithString:[self.inofDic objectForKey:@"url"]];
    [self.webview loadRequest:[NSURLRequest requestWithURL:url]];
}

- (BOOL) isSubscribe{
    if (![self isLogined]) {
        return NO;
    }
    for (NSInteger i = 0 ; i < [appDelegate.bookArr count]; i++) {
        NSDictionary *tmp = [appDelegate.bookArr objectAtIndex:i];
        if ([[tmp objectForKey:@"accountId"] integerValue] == [[self.inofDic objectForKey:@"accountId"] integerValue]) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)isCollected{
    if (![self isLogined]) {
        return NO;
    }
    for (NSInteger i = 0; i < [appDelegate.collectArr count]; i ++) {
        NSDictionary *tmp = [[appDelegate.collectArr objectAtIndex:i] objectForKey:@"article"];
        if ([[tmp objectForKey:@"id"] integerValue] == [[self.inofDic objectForKey:@"id"] integerValue]) {
            self.collectDic = [appDelegate.collectArr objectAtIndex:i];
            return YES;
        }
    }
    return NO;
}

- (NSArray *) items{
    if (!_items) {
        UIBarButtonItem *recommendItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"recommendimg"] style:UIBarButtonItemStylePlain target:self action:@selector(recommendItemClick:)];
        UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"shareimg"] style:UIBarButtonItemStylePlain target:self action:@selector(shareItemClick:)];
        UIBarButtonItem *agreeItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"agreeimg"] style:UIBarButtonItemStylePlain target:self action:@selector(agreeItemClick:)];
        NSString *collectImgStr = [self isCollected]?@"collectedimg":@"collectimg";
        UIBarButtonItem *collectItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:collectImgStr] style:UIBarButtonItemStylePlain target:self action:@selector(collectItemClick:)];
        UIBarButtonItem *reportItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"reportimg"] style:UIBarButtonItemStylePlain target:self action:@selector(reportItemClick:)];
        UIBarButtonItem * spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        _items = [NSArray arrayWithObjects:spaceItem, recommendItem, spaceItem, shareItem, spaceItem, agreeItem, spaceItem, collectItem, spaceItem, reportItem, spaceItem, nil];
    }
    return _items;
}

- (UIWebView *) webview{
    if (!_webview) {
        _webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
//        [_webview.scrollView setBackgroundColor:UIColorFromRGB(0x57acde)];
        _webview.scrollView.bounces = NO;
        _webview.scalesPageToFit = YES;
    }
    return _webview;
}

- (UIBarButtonItem *)subscribeItem{
    if (!_subscribeItem) {
        NSString *subscribeStr = [self isSubscribe]?@"已订阅":@"订阅";
        _subscribeItem = [[UIBarButtonItem alloc] initWithTitle:subscribeStr style:UIBarButtonItemStylePlain target:self action:@selector(subscribeItemClick:)];
    }
    return _subscribeItem;
}

- (UIBarButtonItem *)backItem{
    if (!_backItem) {
        _backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backimg"] style:UIBarButtonItemStylePlain target:self action:@selector(backItemClick:)];
    }
    return _backItem;
}

- (ReportViewController *) reportController{
    if (!_reportController) {
        _reportController = [[ReportViewController alloc] init];
    }
    return _reportController;
}

- (void) backItemClick:(UIBarButtonItem *)item{
    [self.navigationController setToolbarHidden:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL) isLogined{
    return [appDelegate isLogin];
}

//订阅按钮
- (void)subscribeItemClick:(UIBarButtonItem *)item{
    if (![self isLogined]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NEED_LOGIN object:nil];
        return;
    }
    if ([item.title isEqualToString:@"订阅"]) {//订阅流程
        NSMutableArray *params = [self makeParams];
        [NetworkUtil postJSONWithUrl:BOOK_CREATE parameters:params success:^(id responseObject){
            NSString *url = [NSString stringWithFormat:SUBSCRIBE_BY_USER, [appDelegate.userInfo objectForKey:@"id"]];
            [NetworkUtil JSONDataWithUrl:url success:^(id json){
                appDelegate.bookArr = json;
                //清空用户订阅列表
                [[DBUtil sharedManager] deleteAllBook];
                [[DBUtil sharedManager] insertAllBook:appDelegate.bookArr];
                appDelegate.bookArr = [[DBUtil sharedManager] getAllBook];
                [item setTitle:@"已订阅"];
                NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                [dic setObject:[NSNumber numberWithInteger:ALAlertBannerStyleNotify] forKey:@"style"];
                [dic setObject:@"订阅成功" forKey:@"title"];
                [[NSNotificationCenter defaultCenter] postNotificationName:SHOW_BANNER object:dic];
                [[NSNotificationCenter defaultCenter] postNotificationName:SUBSCRIBE_CHANGED object:nil];
            }fail:^(void){
                NSLog(@"初始化用户订阅列表失败");
            }];
        }fail:^(void){
            NSLog(@"保存失败");
        }];
    }
}

- (NSMutableArray *) makeParams{
    NSMutableArray *params = [NSMutableArray array];
    NSNumber *userId = [[appDelegate userInfo] objectForKey:@"id"];
    NSMutableDictionary *tmp = [NSMutableDictionary dictionary];
    [tmp setValue:userId forKey:@"userId"];
    [tmp setValue:[self.inofDic objectForKey:@"accountId"] forKey:@"accountId"];
    [params addObjectsFromArray:[appDelegate bookArr]];
    [params addObject:tmp];
    return params;
}

- (void)agreeItemClick:(UIBarButtonItem *)item{
    if (![self isLogined]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NEED_LOGIN object:nil];
        return;
    }
}

- (void)recommendItemClick:(UIBarButtonItem *)item{
    if (![self isLogined]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NEED_LOGIN object:nil];
        return;
    }
}

- (void)shareItemClick:(UIBarButtonItem *)item{
    if (![self isLogined]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NEED_LOGIN object:nil];
        return;
    }
}

//收藏
- (void)collectItemClick:(UIBarButtonItem *)item{
    if (![self isLogined]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NEED_LOGIN object:nil];
        return;
    }
    if ([self isCollected]) {
        NSString *url = [NSString stringWithFormat:USER_CANCEL_COLLECT_ARTICLE, [self.collectDic objectForKey:@"id"]];
        [NetworkUtil JSONDataWithUrl:url success:^(id json){
            //取消成功
            [[NSNotificationCenter defaultCenter] postNotificationName:USER_COLLECT_CHANGE object:nil];
            [item setImage:[UIImage imageNamed:@"collectimg"]];
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setObject:@"取消收藏成功！" forKey:@"subtitle"];
            [[NSNotificationCenter defaultCenter] postNotificationName:SHOW_HUD object:dic];
        }fail:^(void){
            NSLog(@"CANCEL_COLLECT_FAILED");
        }];
    }else{
        NSString *url = [NSString stringWithFormat:USER_COLLECT_ARTICLE];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setValue:[appDelegate.userInfo objectForKey:@"id"] forKey:@"userId"];
        NSMutableDictionary *article = [NSMutableDictionary dictionaryWithObject:[self.inofDic objectForKey:@"id" ] forKey:@"id"];
        [params setValue:article forKey:@"article"];
        [NetworkUtil postJSONWithUrl:url parameters:params success:^(id json){
            //收藏成功
            [[NSNotificationCenter defaultCenter] postNotificationName:USER_COLLECT_CHANGE object:nil];
            [item setImage:[UIImage imageNamed:@"collectedimg"]];
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setObject:@"收藏成功！" forKey:@"subtitle"];
            [[NSNotificationCenter defaultCenter] postNotificationName:SHOW_HUD object:dic];
        }fail:^(void){
            NSLog(@"CANCEL_COLLECT_FAILED");
        }];
    }
}

- (void)reportItemClick:(UIBarButtonItem *)item{
    [self.navigationController setToolbarHidden:YES];
    [self.navigationController pushViewController:self.reportController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
