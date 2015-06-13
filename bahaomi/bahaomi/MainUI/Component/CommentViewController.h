//
//  CommentViewController.h
//  bahaomi
//
//  Created by  王国众 on 15/6/13.
//  Copyright (c) 2015年 yuedongxinji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentViewController : UITableViewController

@property (nonatomic) NSNumber *articleId;
@property (strong, nonatomic) NSMutableArray *commentList;

@end
