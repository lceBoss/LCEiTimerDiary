//
//  UIColor+Hex.m
//  KenuoTraining
//
//  Created by Robert on 16/2/22.
//  Copyright © 2016年 Robert. All rights reserved.
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

+ (UIColor *)knBlackColor {
    //    return [UIColor colorWithRed:26/255.0 green:26/255.0 blue:26/255.0 alpha:1.0];
    return [UIColor blackColor];
}

+ (UIColor *)knLightGrayColor {
    return [UIColor colorWithRed:178 / 255.0 green:178 / 255.0 blue:178 / 255.0 alpha:1.0];
}
//0xFF5E84
+ (UIColor *)knYellowColor {
    return [UIColor colorWithRed:235 / 255.0 green:189 / 255.0 blue:48 / 255.0 alpha:1.0];
}

+ (UIColor *)knBgColor {
    return [UIColor colorWithRed:242 / 255.0 green:242 / 255.0 blue:242 / 255.0 alpha:1.0];
}
//0x
+ (UIColor *)knRedColor {
    return [UIColor colorWithRed:255 / 255.0 green:94 / 255.0 blue:132 / 255.0 alpha:1.0];
}

//0x666666
+ (UIColor *)knGrayColor {
    return [UIColor colorWithRed:102 / 255.0 green:102 / 255.0 blue:102 / 255.0 alpha:1.0];
}

//0x999999
+ (UIColor *)knWordsColor {
    return [UIColor colorWithRed:153 / 255.0 green:153 / 255.0 blue:153 / 255.0 alpha:1.0];
}


@end
