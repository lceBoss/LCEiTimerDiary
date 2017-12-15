//
//  KNBArticleCategoryModel.h
//  KenuoTraining
//
//  Created by 妖狐小子 on 16/12/12.
//  Copyright © 2016年 Robert. All rights reserved.
//

#import "LCEBaseModel.h"

@interface LCEArticleCategoryModel : LCEBaseModel

@property (nonatomic, assign) NSInteger category_id;
//分类title
@property (nonatomic, copy) NSString *name;
/**
 *  最近一次刷新时间，自动刷新时间间隔为1h
 */
@property (nonatomic, assign) NSTimeInterval lastTime;

@end
