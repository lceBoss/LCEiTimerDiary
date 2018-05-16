//
//  LCEStreetSnapImageApi.h
//  LCEiTimerDiary
//
//  Created by 妖狐小子 on 2018/5/15.
//  Copyright © 2018年 妖狐小子. All rights reserved.
//

#import "LCEBaseRequest.h"

@interface LCEStreetSnapImageApi : LCEBaseRequest

/**
 头条图片

 @param keyword 搜索关键词
 @param page 分页
 @return 
 */
- (instancetype)initWithKeyword:(NSString *)keyword page:(NSInteger)page;

@end
