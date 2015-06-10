//
//  DetailViewController.h
//  bahaomi
//
//  Created by lamto on 15/5/27.
//  Copyright (c) 2015年 yuedongxinji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIWebView+AFNetworking.h"
#import "Util.h"
#import "Message.h"

@interface DetailViewController : UIViewController <UIWebViewDelegate>

@property (nonatomic, strong) NSMutableDictionary *inofDic;
@property (nonatomic, strong) UIWebView *webview;
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) UIBarButtonItem *subscribeItem;
@property (nonatomic, strong) UIBarButtonItem *backItem;

@end