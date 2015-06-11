//
//  DetailViewController.m
//  bahaomi
//
//  Created by lamto on 15/5/27.
//  Copyright (c) 2015年 yuedongxinji. All rights reserved.
//

#import "DetailViewController.h"
#import "AppDelegate.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildLayout];
    [self buildData];
}

- (void)buildLayout{
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
    AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    for (NSInteger i = 0 ; i < [appdelegate.bookArr count]; i++) {
        NSDictionary *tmp = [appdelegate.bookArr objectAtIndex:i];
        if ([[tmp objectForKey:@"accountId"] integerValue] == [[self.inofDic objectForKey:@"accountId"] integerValue]) {
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
        UIBarButtonItem *collectItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"collectimg"] style:UIBarButtonItemStylePlain target:self action:@selector(collectItemClick:)];
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
    AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    return [appdelegate isLogin];
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
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
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
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSNumber *userId = [[appDelegate userInfo] objectForKey:@"id"];
    NSMutableDictionary *tmp = [NSMutableDictionary dictionary];
    [tmp setValue:userId forKey:@"userId"];
    [tmp setValue:[self.inofDic objectForKey:@"accountId"] forKey:@"accountId"];
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

- (void)collectItemClick:(UIBarButtonItem *)item{
    if (![self isLogined]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NEED_LOGIN object:nil];
        return;
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
