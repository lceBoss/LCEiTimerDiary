//
//  UIColor+Hex.m
//  LCEiTimerDiary
//
//  Created by 妖狐小子 on 2017/10/31.
//  Copyright © 2017年 妖狐小子. All rights reserved.
//

#import "UIColor+Hex.h"

@implementation UIColor (Hex)

+ (UIColor *)colorWithHex:(int)hexValue alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16)) / 255.0
                           green:((float)((hexValue & 0xFF00) >> 8)) / 255.0
                            blue:((float)(hexValue & 0xFF)) / 255.0
                           alpha:alpha];
}

+ (UIColor *)colorWithHex:(int)hexValue {
    return [UIColor colorWithHex:hexValue alpha:1.0];
}

+ (UIColor *)lceMainColor {
    return [UIColor colorWithRed:59 / 255.0 green:156 / 255.0 blue:255 / 255.0 alpha:1.0];
}

+ (UIColor *)lceBgColor {
    return [UIColor colorWithRed:242 / 255.0 green:242 / 255.0 blue:242 / 255.0 alpha:1.0];
}

@end
