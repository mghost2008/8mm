//
//  EventDetailViewController.m
//  bahaomi
//
//  Created by  王国众 on 15/6/12.
//  Copyright (c) 2015年 yuedongxinji. All rights reserved.
//

#import "EventDetailViewController.h"
#import "AppDelegate.h"

@interface EventDetailViewController ()

@end

@implementation EventDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildLayout];
    [self buildData];
}

- (void)buildLayout{
    [self.webview setDelegate:self];
    [self.view addSubview:self.webview];
    [self setToolbarItems:self.items];
    [self.navigationItem setLeftBarButtonItem:self.backItem];
    [self.navigationController setToolbarHidden:NO];
}

- (void)buildData{
    NSLog(@"%@", self.inofDic);
    NSURL *url = [NSURL URLWithString:[self.inofDic objectForKey:@"url"]];
    [self.webview loadRequest:[NSURLRequest requestWithURL:url]];
}

- (NSArray *) items{
    if (!_items) {
        UIBarButtonItem *joinItem = [[UIBarButtonItem alloc] initWithTitle:@"报名参加" style:UIBarButtonItemStylePlain target:self action:@selector(joinItemClick:)];
        [joinItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor darkGrayColor]} forState:UIControlStateNormal];
        UIBarButtonItem * spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        _items = [NSArray arrayWithObjects:spaceItem, joinItem, spaceItem, nil];
    }
    return _items;
}

- (UIWebView *) webview{
    if (!_webview) {
        _webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        _webview.scrollView.bounces = NO;
        _webview.scalesPageToFit = YES;
    }
    return _webview;
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

- (void)joinItemClick:(UIBarButtonItem *)item{
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
