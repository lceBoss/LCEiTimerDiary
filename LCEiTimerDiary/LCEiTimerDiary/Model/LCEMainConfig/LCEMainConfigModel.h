//
//  KNBMainConfigModel.h
//  KenuoTraining
//
//  Created by Robert on 16/2/29.
//  Copyright © 2016年 Robert. All rights reserved.
//

#import "LCEBaseModel.h"

//主配置字典
extern NSString *const KNB_BaseUrlKey;
// 个人信息
extern NSString *const KNB_UserDetail;             // 用户详情
extern NSString *const KNB_SecretSalt;             //加密密匙

@interface LCEMainConfigModel : NSObject
;

+ (instancetype)shareInstance;

- (void)regestMainConfig:(id)request;

- (NSString *)getRequestUrlWithKey:(NSString *)key;

@end
