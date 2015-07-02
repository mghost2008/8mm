//
//  DetailViewController.h
//  bahaomi
//
//  Created by lamto on 15/5/27.
//  Copyright (c) 2015年 yuedongxinji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIWebView+AFNetworking.h"
#import "UIImageView+AFNetworking.h"
#import "Util.h"
#import "Message.h"
#import "ReportViewController.h"
#import "CommentViewController.h"
#import "WeixinSessionActivity.h"
#import "WeixinTimelineActivity.h"
#import "WeiboActivity.h"

@interface DetailViewController : UIViewController <UIWebViewDelegate>

@property (nonatomic, strong) NSMutableDictionary *inofDic;
@property (nonatomic, strong) NSMutableDictionary *agreeDic;
@property (nonatomic, strong) UIWebView *webview;
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) UIBarButtonItem *subscribeItem;
@property (nonatomic, strong) NSMutableDictionary *collectDic;
@property (nonatomic, strong) UIBarButtonItem *backItem;
@property (nonatomic, strong) ReportViewController *reportController;
@property (nonatomic, strong) CommentViewController *commentController;
@property BOOL isDynamic;

@end
