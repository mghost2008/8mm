//
//  BHM_TextField.m
//  bahaomi
//
//  Created by  王国众 on 15/6/9.
//  Copyright (c) 2015年 yuedongxinji. All rights reserved.
//

#import "BHM_TextField.h"

@implementation BHM_TextField

- (void)drawRect:(CGRect)rect {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextClearRect(ctx, rect);
    
    // 设置线条颜色
    CGContextSetRGBStrokeColor(ctx, 0, 0, 0, 1.0f);
    
    CGContextMoveToPoint(ctx, 2, rect.size.height-3);
    CGContextAddLineToPoint(ctx, rect.size.width-2, rect.size.height-3);
    
    // 开始绘图
    CGContextStrokePath(ctx);
}

@end
