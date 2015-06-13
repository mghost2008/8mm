//
//  CommentViewController.h
//  bahaomi
//
//  Created by  王国众 on 15/6/13.
//  Copyright (c) 2015年 yuedongxinji. All rights reserved.
//

#import "SLKTextViewController.h"
#import "NetworkUtil.h"
#import "LoremIpsum.h"
#import "MessageTableViewCell.h"

@interface CommentViewController : SLKTextViewController

@property (strong, nonatomic) NSMutableDictionary *articleInfo;
@property (strong, nonatomic) UIBarButtonItem *backItem;

@end
