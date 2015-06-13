//
//  NetworkUtil.h
//  bahaomi
//
//  Created by  王国众 on 15/5/5.
//  Copyright (c) 2015年  王国众. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#define BASEURL @"http://123.56.149.56:8080"
//#define BASEURL @"http://10.0.2.241:8080"
//#define HOTNEWS @""BASEURL@"/article/findByCategoryId/%@"
#define HOTNEWS_INIT @""BASEURL@"/article/findInitByCategoryIdPaged/%@?date=%@&size=%d"
#define HOTNEWS_NEW @""BASEURL@"/article/findNewerByCategoryIdPaged/%@?date=%@&size=%d"
#define HOTNEWS_OLD @""BASEURL@"/article/findOlderByCategoryIdPaged/%@?date=%@&size=%d"
#define SUBSCRIBE_LIST @""BASEURL@"/account/findCommend"
#define SUBSCRIBE_ACCOUNT_NEWS_INIT @""BASEURL@"/article/findInitByAccountIdPaged/%@?date=%@&size=%d"
#define SUBSCRIBE_ACCOUNT_NEWS_NEW @""BASEURL@"/article/findNewerByAccountIdPaged/%@?date=%@&size=%d"
#define SUBSCRIBE_ACCOUNT_NEWS_OLD @""BASEURL@"/article/findOlderByAccountIdPaged/%@?date=%@&size=%d"
#define SUBSCRIBE_FIND_ALL @""BASEURL@"/account/findAll"
#define SUBSCRIBE_BY_USER @""BASEURL@"/book/getByUser/%@"
#define EVENT_FIND_STARTED_NEW @""BASEURL@"/event/findNewerStarted?date=%@&size=%d"
#define EVENT_FIND_STARTED_INIT @""BASEURL@"/event/findInitStarted?date=%@&size=%d"
#define EVENT_FIND_STARTED_OLD @""BASEURL@"/event/findOlderStarted?date=%@&size=%d"
#define EVENT_FIND_ENDED_NEW @""BASEURL@"/event/findNewerEnded?date=%@&size=%d"
#define EVENT_FIND_ENDED_INIT @""BASEURL@"/event/findInitEnded?date=%@&size=%d"
#define EVENT_FIND_ENDED_OLD @""BASEURL@"/event/findOlderEnded?date=%@&size=%d"
#define REG_TEL_REQUEST_VCODE @""BASEURL@"/user/requestSmsCode/%@"
#define REG_TEL_REQUEST_REG @""BASEURL@"/user/usersByMobilePhone/%@"
#define TEL_PWD_LOGIN @""BASEURL@"/user/check"
#define REG_OAUTH_USER @""BASEURL@"/user/create"
#define UPDATE_USER_INFO @""BASEURL@"/user/update"
#define BOOK_CREATE @""BASEURL@"/book/create"
//用户订阅文章列表
#define USER_COLLECT_LIST @""BASEURL@"/collect/getByUser/%@"
//用户订阅文章
#define USER_COLLECT_ARTICLE @""BASEURL@"/collect/create"
//用户取消订阅文章
#define USER_CANCEL_COLLECT_ARTICLE @""BASEURL@"/collect/delete/%@"
//用户对文章点赞
#define USER_LIKE_ARTICLE @""BASEURL@""
//用户取消对文章点赞
#define USER_CANCEL_LIKE_ARTICLE @""BASEURL@""
//获取文章的评论列表
#define COMMIT_COMMENT @""BASEURL"/comment/create"
//提交评论
#define FIND_COMMENTS_BY_ARTICLE @""BASEURL"/comment/findById/%@"
//报名活动接口
#define SIGN_UP_EVENT @""BASEURL""


@interface NetworkUtil : NSObject

+ (void)JSONDataWithUrl:(NSString *)url success:(void (^)(id json))success fail:(void (^)())fail;
+ (void)postJSONWithUrl:(NSString *)urlStr parameters:(id)parameters success:(void (^)(id responseObject))success fail:(void (^)())fail;

@end
