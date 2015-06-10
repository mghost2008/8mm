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

- (void)createTable{
    if (![_db open]) {
        NSLog(@"---------数据库打开失败");
        return;
    }
    //为数据库设置缓存，提高查询效率
    [_db setShouldCacheStatements:YES];
    //判断数据库中是否已经存在这个表，如果不存在则创建该表
    if (![_db tableExists:@"commend"]) {
        NSString *commendCreate = @"CREATE TABLE commend(id INTEGER PRIMARY KEY, openId TEXT,accountName TEXT, account TEXT, info TEXT, img TEXT, sn INTEGER, isCommended INTEGER, originImg TEXT, qrimg TEXT)";
        [_db executeUpdate:commendCreate];
         NSLog(@"commend表不存在,创建完成");
    }
    if (![_db tableExists:@"book"]) {
        NSString *bookCreate = @"CREATE TABLE book(id INTEGER, userId INTEGER, accountId INTEGER)";
        [_db executeUpdate:bookCreate];
        NSLog(@"book表不存在,创建完成");
    }
}

- (NSMutableArray *)getAllCommend{
    NSMutableArray *rslist = [NSMutableArray array];
    if (![_db open]) {
        NSLog(@"-------------------数据库打开失败");
        return rslist;
    }
    if (![_db tableExists:@"commend"]) {
        [self createTable];
    }
    [_db setShouldCacheStatements:YES];
    NSString *selectCommend = @"SELECT * FROM commend ";
    FMResultSet *rs = [_db executeQuery:selectCommend];
    while ([rs next]) {
        NSMutableDictionary *temp = [NSMutableDictionary dictionary];
        NSNumber *commendId = [NSNumber numberWithInteger:[[rs objectForColumnName:@"id"] integerValue]];
        NSString *openId = [rs stringForColumn:@"openId"];
        NSString *accountName = [rs stringForColumn:@"accountName"];
        NSString *account = [rs stringForColumn:@"account"];
        NSString *info = [rs stringForColumn:@"info"];
        NSString *img = [rs stringForColumn:@"img"];
        NSNumber *sn = [NSNumber numberWithInteger:[rs intForColumn:@"sn"]];
        NSNumber *isCommended = [NSNumber numberWithInteger:[rs intForColumn:@"isCommended"]];
        NSString *originImg = [rs stringForColumn:@"originImg"];
        NSString *qrimg = [rs stringForColumn:@"qrimg"];
        [temp setValue:commendId forKey:@"id"];
        [temp setValue:openId forKey:@"openId"];
        [temp setValue:accountName forKey:@"accountName"];
        [temp setValue:account forKey:@"account"];
        [temp setValue:info forKey:@"info"];
        [temp setValue:img forKey:@"img"];
        [temp setValue:sn forKey:@"sn"];
        [temp setValue:isCommended forKey:@"isCommended"];
        [temp setValue:originImg forKey:@"originImg"];
        [temp setValue:qrimg forKey:@"qrimg"];
        [rslist addObject:temp];
    }
    [_db close];
    return rslist;
}

//删除一条commend记录
- (void)deleteCommend:(NSMutableDictionary *)commend{
    if (![_db open]) {
        NSLog(@"-------------------数据库打开失败");
        return;
    }
    if (![_db tableExists:@"commend"]) {
        [self createTable];
    }
    [_db setShouldCacheStatements:YES];
    NSString *deleteCommend = @"DELETE FROM commend WHERE id = ? ";
    NSInteger commendId = [[commend objectForKey:@"id"] integerValue];
    [_db executeUpdate:deleteCommend, commendId];
    [_db close];
}

- (void)deleteAllCommend{
    if (![_db open]) {
        NSLog(@"-------------------数据库打开失败");
        return;
    }
    if (![_db tableExists:@"commend"]) {
        [self createTable];
    }
    [_db setShouldCacheStatements:YES];
    NSString *deleteCommend = @"DELETE FROM commend ";
    [_db executeUpdate:deleteCommend];
    [_db close];
}

- (void)insertAllCommend:(NSMutableArray *)commendList{
    for (NSInteger i = 0; i < [commendList count]; i++) {
        NSDictionary *tmp = [commendList objectAtIndex:i];
        [self insertCommend:tmp];
    };
}

//插入一条推荐记录
- (void)insertCommend:(NSDictionary *)commend{
    if (![_db open]) {
        NSLog(@"-------------------数据库打开失败");
        return;
    }
    if (![_db tableExists:@"commend"]) {
        [self createTable];
    }
    [_db setShouldCacheStatements:YES];
    //现在表中查询有没有相同的元素，如果有，做修改操作
    FMResultSet *rs = [_db executeQuery:@"SELECT * FROM commend WHERE id = ?",[NSString stringWithFormat:@"%@", [commend objectForKey:@"id"]]];
    if([rs next]){
        NSLog(@"记录已经存在");
        NSLog(@"dddddslsdkien");
    }else{//向数据库中插入一条数据
        NSString *insertCommend = @"INSERT INTO commend (id, openId, accountName, account, info, img, sn, isCommended, originImg, qrimg) VALUES (?,?,?,?,?,?,?,?,?,?)";
        
        NSNumber *commendId = [NSNumber numberWithInteger:[[commend objectForKey:@"id"] integerValue]];
        NSString *openId = [commend objectForKey:@"openId"];
        NSString *accountName = [commend objectForKey:@"accountName"];
        NSString *account = [commend objectForKey:@"account"];
        NSString *info = [commend objectForKey:@"info"];
        NSString *img = [commend objectForKey:@"img"];
        NSNumber *sn = [NSNumber numberWithInteger:[[commend objectForKey:@"sn"] integerValue]];
        NSNumber *isCommended = [NSNumber numberWithBool:[[commend objectForKey:@"isCommended"] boolValue] ];
        NSString *originImg = [commend objectForKey:@"originImg"];
        NSString *qrimg = [commend objectForKey:@"qrimg"];
        [_db executeUpdate:insertCommend, commendId, openId, accountName, account, info, img, sn, isCommended, originImg, qrimg];
    }
    [_db close];
}

- (void)deleteAllBook{
    if (![_db open]) {
        NSLog(@"-------------------数据库打开失败");
        return;
    }
    if (![_db tableExists:@"book"]) {
        [self createTable];
    }
    [_db setShouldCacheStatements:YES];
    NSString *deleteBook = @"DELETE FROM book ";
    [_db executeUpdate:deleteBook];
    [_db close];
}

//删除一条book记录
- (void)deleteBook:(NSMutableDictionary *)book{
    if (![_db open]) {
        NSLog(@"-------------------数据库打开失败");
        return;
    }
    if (![_db tableExists:@"book"]) {
        [self createTable];
    }
    [_db setShouldCacheStatements:YES];
    NSString *deleteBook = @"DELETE FROM book WHERE id = ? AND userId = ? AND accountId = ?";
    NSNumber *bookId = [NSNumber numberWithInteger:[[book objectForKey:@"id"] integerValue]];
    NSNumber *userId = [NSNumber numberWithInteger:[[book objectForKey:@"userId"] integerValue]];
    NSNumber *accountId = [NSNumber numberWithInteger:[[book objectForKey:@"accountId"] integerValue]];
    [_db executeUpdate:deleteBook, bookId, userId, accountId];
    [_db close];
}

- (void)insertAllBook:(NSMutableArray *)bookList{
    for (NSInteger i = 0; i < [bookList count]; i++) {
        NSDictionary *tmp = [bookList objectAtIndex:i];
        [self insertBook:tmp];
    };
}

//插入一条推荐记录
- (void)insertBook:(NSDictionary *)book{
    if (![_db open]) {
        NSLog(@"-------------------数据库打开失败");
        return;
    }
    if (![_db tableExists:@"book"]) {
        [self createTable];
    }
    [_db setShouldCacheStatements:YES];
    NSString *insertBook = @"INSERT INTO book (id, userId, accountId) VALUES (?,?,?)";
    NSNumber *bookId = [NSNumber numberWithInteger:[[book objectForKey:@"id"] integerValue]];
    NSNumber *userId = [NSNumber numberWithInteger:[[book objectForKey:@"userId"] integerValue]];
    NSNumber *accountId = [NSNumber numberWithInteger:[[book objectForKey:@"accountId"] integerValue]];
    [_db executeUpdate:insertBook, bookId, userId, accountId];
    [_db close];
}

- (NSMutableArray *)getAllBook{
    NSMutableArray *rslist = [NSMutableArray array];
    if (![_db open]) {
        NSLog(@"-------------------数据库打开失败");
        return rslist;
    }
    if (![_db tableExists:@"book"]) {
        [self createTable];
    }
    [_db setShouldCacheStatements:YES];
    NSString *selectBook = @"SELECT * FROM book ";
    FMResultSet *rs = [_db executeQuery:selectBook];
    while ([rs next]) {
        NSMutableDictionary *temp = [NSMutableDictionary dictionary];
        NSNumber *bookId = [NSNumber numberWithInteger:[[rs objectForColumnName:@"id"] integerValue]];
        NSNumber *userId = [NSNumber numberWithInteger:[[rs objectForColumnName:@"userId"] integerValue]];
        NSNumber *accountId = [NSNumber numberWithInteger:[[rs objectForColumnName:@"accountId"] integerValue]];
        [temp setValue:bookId forKey:@"id"];
        [temp setValue:userId  forKey:@"userId"];
        [temp setValue:accountId forKey:@"accountId"];
        [rslist addObject:temp];
    }
    [_db close];
    return rslist;
}

@end
