//
//  LCEBaseModel.h
//  LCEiTimerDiary
//
//  Created by 妖狐小子 on 2017/11/4.
//  Copyright © 2017年 妖狐小子. All rights reserved.
//

#import <Mantle/Mantle.h>
#import <MagicalRecord/MagicalRecord.h>
#import "MTLManagedObjectAdapter.h"

@interface LCEBaseModel : MTLModel <MTLJSONSerializing, MTLManagedObjectSerializing>

/**
 * search后转变为model模型
 */
+ (NSArray *)searchAll;
+ (NSArray *)searchWithKey:(id)key;
+ (NSArray *)searchWithKey:(id)key value:(id)value;
+ (NSArray *)searchWithPredicate:(NSPredicate *)dicate;

/**
 分页搜索
 @param dicate 搜索条件
 @param sortDes 排序条件
 @param page 分页（1开始）
 @return 结果数组
 */
+ (NSArray *)searchWithPredicate:(NSPredicate *)dicate
                 sortDescription:(NSSortDescriptor *)sortDes
                            page:(NSInteger)page;

/**
 * search后未进行转换
 */
+ (NSArray *)search;
+ (NSArray *)searchKey:(id)key;
+ (NSArray *)searchKey:(id)key ascending:(BOOL)ascending;
+ (NSArray *)searchKey:(id)key value:(id)value;

/**
 * 转换为model模型
 */
+ (NSArray *)classToModel:(NSArray *)res;

/**
 * model转换为json
 */
+ (NSArray *)jsonFromModelArray:(NSArray *)ary;

// delete
+ (BOOL)deleteKey:(id)key value:(id)value;
+ (BOOL)deleteModel;

/**
 * 模型(转换后的模型不能调用)
 */
+ (BOOL)deleteWithModel:(id)model;

/**
 *  通过主健的值删除模型
 */
+ (BOOL)deletePrimaryKeyValue:(id)value;

/**
 *  保存数据模型
 */
+ (void)saveWithModel:(id)model resultBlock:(void (^)(BOOL success))block;

#pragma mark - Json To Model
/**
 *  通过数据获取 模型或者模型数组
 */
+ (id)changeResponseJSONObject:(id)obj;

/**
 *  通过数据获取模型数组
 */
+ (NSArray *)changeJSONArray:(NSArray *)ary;

#pragma mark - Private Method
/**
 *  设置
 *
 *  @param imageView 图片
 *  @param url       地址
 *  @param placeholder 站位图名字
 */
+ (void)setImageView:(UIImageView *)imageView urlString:(NSString *)url placeholderImage:(NSString *)placeholder;

/**
 *  设置用户头像
 *
 *  @param imgView imageView
 *  @param str     地址
 */
+ (void)headImageView:(UIImageView *)imgView urlString:(NSString *)str;

/**
 *  转换成描述型字符串
 *
 *  @param str 需要转换的时间 格式为 2016-03-16 16:29:00
 *
 *  @return 描述型字符串
 */
- (NSString *)transToFuzzyDate:(NSString *)str;


/**
 *  数字转换精确到后两位
 *
 *  @return 描述型字符串
 */
+ (NSString *)transNumber:(double)number;


@end
