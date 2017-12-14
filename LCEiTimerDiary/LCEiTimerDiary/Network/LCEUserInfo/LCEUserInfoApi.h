//
//  LCEUserInfoApi.h
//  LCEiTimerDiary
//
//  Created by 妖狐小子 on 2017/12/14.
//  Copyright © 2017年 妖狐小子. All rights reserved.
//

#import "LCEBaseRequest.h"

@interface LCEUserInfoApi : LCEBaseRequest

/**
 *  获取用户详情
 *  @param userId 用户id
 */
- (instancetype)initWithUserId:(NSString *)userId;

@end
