//
//  NSString+Contain.h
//  KenuoTraining
//
//  Created by Robert on 16/2/22.
//  Copyright © 2016年 Robert. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString (Contain)

/**
 *  判断子字符串包含关系
 *
 *  @param substring 子字符串
 *
 *  @return 是否包含子字符串
 */
- (BOOL)contains:(NSString *)substring;

/**
 *  判断字符串截至子字符串
 *
 *  @param substring 子字符串
 *
 *  @return 是否以子字符串截止
 */
- (BOOL)endsWith:(NSString *)substring;

/**
 *  判断字符串起始子字符串
 *
 *  @param substring 子字符串
 *
 *  @return 是否以子字符串开头
 */
- (BOOL)startsWith:(NSString *)substring;

@end
