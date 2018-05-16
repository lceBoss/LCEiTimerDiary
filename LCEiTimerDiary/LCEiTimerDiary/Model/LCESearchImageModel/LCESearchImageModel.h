//
//  LCESearchImageModel.h
//  LCEiTimerDiary
//
//  Created by 妖狐小子 on 2018/5/16.
//  Copyright © 2018年 妖狐小子. All rights reserved.
//

#import "LCEBaseModel.h"

@interface LCESearchImageModel : LCEBaseModel
// 组图id
@property (nonatomic, strong) NSString *group_id;
@property (nonatomic, strong) NSString *title;
// 搜索关键词
@property (nonatomic, strong) NSString *keyword;
// 图片地址集
@property (nonatomic, strong) NSString *image_urls;
@property (nonatomic, strong) NSString *create_date;

@end
