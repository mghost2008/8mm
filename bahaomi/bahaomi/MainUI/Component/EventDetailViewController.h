//
//  EventDetailViewController.h
//  bahaomi
//
//  Created by  王国众 on 15/6/12.
//  Copyright (c) 2015年 yuedongxinji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIWebView+AFNetworking.h"
#import "Util.h"
#import "Message.h"

@interface EventDetailViewController : UIViewController<UIWebViewDelegate>

@property (nonatomic, strong) NSMutableDictionary *inofDic;
@property (nonatomic, strong) UIWebView *webview;
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) UIBarButtonItem *backItem;
@property (nonatomic) BOOL isEnded;

@end
