//
//  AddSubscribeList.h
//  bahaomi
//
//  Created by  王国众 on 15/5/28.
//  Copyright (c) 2015年 yuedongxinji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetworkUtil.h"
#import "AddSubscribeCell.h"

@interface AddSubscribeList : UITableViewController

//所有公众号列表
@property (nonatomic, strong) NSMutableArray *commendArr;
@property (nonatomic, strong) NSMutableArray *userBookArr;

-(void)setCommendArr:(NSMutableArray *)commendArr andUserBookArr:(NSMutableArray *)bookArr;

@end
