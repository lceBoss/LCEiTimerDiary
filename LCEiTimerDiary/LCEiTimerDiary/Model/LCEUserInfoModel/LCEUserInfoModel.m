//
//  LCEUserInfoModel.m
//  LCEiTimerDiary
//
//  Created by 妖狐小子 on 2017/12/14.
//  Copyright © 2017年 妖狐小子. All rights reserved.
//

#import "LCEUserInfoModel.h"

@implementation LCEUserInfoModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSMutableDictionary *muDic = [NSMutableDictionary dictionaryWithDictionary:[NSDictionary mtl_identityPropertyMapWithModel:self.class]];
    muDic[@"user_id"] = @"id";
    return muDic;
}

@end
