//
//  DBUtil.h
//  bahaomi
//
//  Created by  王国众 on 15/6/8.
//  Copyright (c) 2015年 yuedongxinji. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Info.h"

@interface DBUtil : NSObject{
    FMDatabase *_db;
}

+ (DBUtil *)sharedManager;
- (NSMutableArray *)getAllCommend;
- (void)deleteAllCommend;
- (void)insertAllCommend:(NSMutableArray *)commendList;
- (NSMutableArray *)getAllBook;
- (void)deleteAllBook;
- (void)insertAllBook:(NSMutableArray *)bookList;
- (NSMutableArray *)getAllCollect;
- (void)deleteAllCollect;
- (void)insertCollect:(NSDictionary *)collect;
- (void)insertAllCollect:(NSMutableArray *)collectList;

@end
