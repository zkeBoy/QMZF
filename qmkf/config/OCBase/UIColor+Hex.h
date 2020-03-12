//
//  UIColor+Hex.h
//  OnLineStudy
//
//  Created by lyy on 15/6/9.
//  Copyright (c) 2015年 李源友. All rights reserved.
//

//#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIColor (Hex)

+ (UIColor *)colorWithHexString:(NSString *)color;

/**
 * 从十六进制字符串获取颜色,color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
 */
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

@end
