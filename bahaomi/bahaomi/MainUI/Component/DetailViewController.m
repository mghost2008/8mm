//
//  DetailViewController.m
//  bahaomi
//
//  Created by lamto on 15/5/27.
//  Copyright (c) 2015年 yuedongxinji. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildLayout];
    [self buildData];
}

- (void)buildLayout{
    [self.navigationController setNavigationBarHidden:YES];
    [self.webview setDelegate:self];
    [self.view addSubview:self.webview];
    [self setToolbarItems:self.items];
    [self.navigationController setToolbarHidden:NO];
    UINavigationBar *navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0.0, -24.0, 320, 44)];
    [self.view addSubview:navigationBar];
}

- (void)buildData{
    NSURL *url = [NSURL URLWithString:[self.inofDic objectForKey:@"url"]];
    [self.webview loadRequest:[NSURLRequest requestWithURL:url]];
}

- (NSArray *) items{
    if (!_items) {
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backlistimg"] style:UIBarButtonItemStylePlain target:self action:@selector(backItemClick:)];
        UIBarButtonItem *recommendItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"recommendimg"] style:UIBarButtonItemStylePlain target:self action:@selector(recommendItemClick:)];
        UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"shareimg"] style:UIBarButtonItemStylePlain target:self action:@selector(shareItemClick:)];
        UIBarButtonItem *editItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"editimg"] style:UIBarButtonItemStylePlain target:self action:@selector(editItemClick:)];
        UIBarButtonItem *collectItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"collectimg"] style:UIBarButtonItemStylePlain target:self action:@selector(collectItemClick:)];
        UIBarButtonItem * spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        _items = [NSArray arrayWithObjects:spaceItem, backItem, spaceItem, recommendItem, spaceItem, shareItem, spaceItem, editItem, spaceItem, collectItem, spaceItem, nil];
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

- (void)backItemClick:(UIBarButtonItem *)item{
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController setToolbarHidden:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)recommendItemClick:(UIBarButtonItem *)item{
    
}

- (void)shareItemClick:(UIBarButtonItem *)item{
    
}

- (void)editItemClick:(UIBarButtonItem *)item{
    
}

- (void)collectItemClick:(UIBarButtonItem *)item{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
