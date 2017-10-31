//
//  UIColor+Hex.h
//  LCEiTimerDiary
//
//  Created by 妖狐小子 on 2017/10/31.
//  Copyright © 2017年 妖狐小子. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)

/**
 *  十六进制色值转换为UIColor（alpha）
 *
 *  @param hexValue 十六进制色值
 *  @param alpha    透明度
 *
 *  @return UIColor对象
 */
+ (UIColor *)colorWithHex:(int)hexValue alpha:(CGFloat)alpha;

/**
 *  十六进制色值转换为UIColor
 *
 *  @param hexValue 十六进制色值
 *
 *  @return UIColor对象
 */
+ (UIColor *)colorWithHex:(int)hexValue;

// 主题色 天蓝色 3b9cff
+ (UIColor *)lceMainColor;

+ (UIColor *)lceBgColor;

@end
