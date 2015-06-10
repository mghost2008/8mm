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
//    [self.navigationController setNavigationBarHidden:YES];
    [self.webview setDelegate:self];
    [self.view addSubview:self.webview];
    [self setToolbarItems:self.items];
    [self.navigationItem setRightBarButtonItem:self.subscribeItem];
    [self.navigationItem setLeftBarButtonItem:self.backItem];
    [self.navigationController setToolbarHidden:NO];
}

- (void)buildData{
    NSURL *url = [NSURL URLWithString:[self.inofDic objectForKey:@"url"]];
    [self.webview loadRequest:[NSURLRequest requestWithURL:url]];
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
        _subscribeItem = [[UIBarButtonItem alloc] initWithTitle:@"订阅" style:UIBarButtonItemStylePlain target:self action:@selector(subscribeItemClick:)];
    }
    return _subscribeItem;
}

- (UIBarButtonItem *)backItem{
    if (!_backItem) {
        _backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backimg"] style:UIBarButtonItemStylePlain target:self action:@selector(backItemClick:)];
    }
    return _backItem;
}

- (void) backItemClick:(UIBarButtonItem *)item{
    [self.navigationController setToolbarHidden:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL) isLogined{
    AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    return [appdelegate isLogin];
}

- (void)subscribeItemClick:(UIBarButtonItem *)item{
    if (![self isLogined]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NEED_LOGIN object:nil];
        return;
    }
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
    if (![self isLogined]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NEED_LOGIN object:nil];
        return;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
