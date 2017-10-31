//
//  UIColor+Hex.h
//  KenuoTraining
//
//  Created by Robert on 16/2/22.
//  Copyright © 2016年 Robert. All rights reserved.
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


//+ (UIColor *)lceBlackColor;


@end
