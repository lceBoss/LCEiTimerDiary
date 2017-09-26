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


+ (UIColor *)knBlackColor;
+ (UIColor *)knLightGrayColor; // 分割线颜色
+ (UIColor *)knYellowColor;
+ (UIColor *)knBgColor;    // 灰色背景颜色
+ (UIColor *)knRedColor;   // 妃子校主题色
+ (UIColor *)knGrayColor;  //灰色字体
+ (UIColor *)knWordsColor; //999999灰色的字

@end
