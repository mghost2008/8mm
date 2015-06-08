//
//  DBUtil.m
//  bahaomi
//
//  Created by  王国众 on 15/6/8.
//  Copyright (c) 2015年 yuedongxinji. All rights reserved.
//

#import "DBUtil.h"

@implementation DBUtil

+ (DBUtil *)sharedManager
{
    static DBUtil *sharedDBManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedDBManagerInstance = [[self alloc] init];
    });
    return sharedDBManagerInstance;
}

- (id)init{
    if (self = [super init]) {
        NSString* docsdir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString* dbpath = [docsdir stringByAppendingPathComponent:@"bahaomi.sqlite"];
        _db = [FMDatabase databaseWithPath:dbpath];
    }
    return self;
}

@end
