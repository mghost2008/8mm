//
//   Copyright 2014 Slack Technologies, Inc.
//
//   Licensed under the Apache License, Version 2.0 (the "License");
//   you may not use this file except in compliance with the License.
//   You may obtain a copy of the License at
//
//       http://www.apache.org/licenses/LICENSE-2.0
//
//   Unless required by applicable law or agreed to in writing, software
//   distributed under the License is distributed on an "AS IS" BASIS,
//   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//   See the License for the specific language governing permissions and
//   limitations under the License.
//

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import "UIScrollView+SLKAdditions.h"
#import <objc/runtime.h>

static NSString * const kKeyScrollViewVerticalIndicator = @"_verticalScrollIndicator";
static NSString * const kKeyScrollViewHorizontalIndicator = @"_horizontalScrollIndicator";

@implementation UIScrollView (SLKAdditions)

- (void)scrollToTopAnimated:(BOOL)animated
{
    if (![self isAtTop]) {
        CGPoint bottomOffset = CGPointZero;
        [self setContentOffset:bottomOffset animated:animated];
    }
}

- (void)scrollToBottomAnimated:(BOOL)animated
{
    if ([self canScrollToBottom] && ![self isAtBottom]) {
        CGPoint bottomOffset = CGPointMake(0.0, self.contentSize.height - self.bounds.size.height);
        [self setContentOffset:bottomOffset animated:animated];
    }
}

- (BOOL)isAtTop
{
    return (self.contentOffset.y == 0.0) ? YES : NO;
}

- (BOOL)isAtBottom
{
    CGFloat bottomOffset = self.contentSize.height-self.bounds.size.height;
    return (self.contentOffset.y == bottomOffset) ? YES : NO;
}

- (BOOL)canScrollToBottom
{
    if (self.contentSize.height > self.bounds.size.height) {
        return YES;
    }
    return NO;
}

- (void)stopScrolling
{
    if (!self.isDragging) {
        return;
    }
    
    CGPoint offset = self.contentOffset;
    offset.y -= 1.0;
    [self setContentOffset:offset animated:NO];
    
    offset.y += 1.0;
    [self setContentOffset:offset animated:NO];
}

- (UIView *)verticalScroller
{
    if (objc_getAssociatedObject(self, _cmd) == nil) {
        objc_setAssociatedObject(self, _cmd, [self safeValueForKey:kKeyScrollViewVerticalIndicator], OBJC_ASSOCIATION_ASSIGN);
    }
    
    return objc_getAssociatedObject(self, _cmd);
}

- (UIView *)horizontalScroller
{
    if (objc_getAssociatedObject(self, _cmd) == nil) {
        objc_setAssociatedObject(self, _cmd, [self safeValueForKey:kKeyScrollViewHorizontalIndicator], OBJC_ASSOCIATION_ASSIGN);
    }
    
    return objc_getAssociatedObject(self, _cmd);
}

- (id)safeValueForKey:(NSString *)key
{
    Ivar instanceVariable = class_getInstanceVariable([self class], [key cStringUsingEncoding:NSUTF8StringEncoding]);
    return object_getIvar(self, instanceVariable);
}

@end
