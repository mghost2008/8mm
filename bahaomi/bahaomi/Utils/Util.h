//
//  Util.h
//  bahaomi
//
//  Created by  王国众 on 15/4/26.
//  Copyright (c) 2015年  王国众. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0] 
#define SCellIdentifier @"SmallCell"
#define LCellIdentifier @"LargeCell"
#define ColCellIdentifier @"ColCell"
#define WebCellIdentifier @"WebCell"
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface Util : NSObject

+ (UIColor *) colorWithHexString: (NSString *)color;
+ (NSString *) NSDateToString:(NSDate *)date;
+ (NSDate *) NSDateFromString:(NSString *)dateString;

@end
