//
//  WeiboActivity.m
//  bahaomi
//
//  Created by  王国众 on 15/6/14.
//  Copyright (c) 2015年 yuedongxinji. All rights reserved.
//

#import "WeiboActivity.h"

@implementation WeiboActivity

+ (UIActivityCategory)activityCategory
{
    return UIActivityCategoryShare;
}

- (NSString *)activityType
{
    return NSStringFromClass([self class]);
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems
{
    for (id activityItem in activityItems) {
        if ([activityItem isKindOfClass:[UIImage class]]) {
            return YES;
        }
        if ([activityItem isKindOfClass:[NSURL class]]) {
            return YES;
        }
    }
    return NO;
}

- (void)prepareWithActivityItems:(NSArray *)activityItems
{
    for (id activityItem in activityItems) {
        if ([activityItem isKindOfClass:[UIImage class]]) {
            image = activityItem;
        }
        if ([activityItem isKindOfClass:[NSURL class]]) {
            url = activityItem;
        }
        if ([activityItem isKindOfClass:[NSString class]]) {
            title = activityItem;
        }
    }
}

- (void)performActivity
{
    //设置发送对象
    WBMessageObject *msg = [WBMessageObject message];
    msg.text = [NSString stringWithFormat:@"%@", url ];
    WBImageObject *imgobj = [WBImageObject object];
    imgobj.imageData = UIImageJPEGRepresentation(image, 1.0);
    msg.imageObject = imgobj;
    
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:msg];
    
    [WeiboSDK sendRequest:request];
    
    [self activityDidFinish:YES];
}

- (UIImage *)activityImage
{
    return [UIImage imageNamed:@"sharedweiboimg"];
}

- (NSString *)activityTitle
{
    return @"新浪微博";
}

@end
