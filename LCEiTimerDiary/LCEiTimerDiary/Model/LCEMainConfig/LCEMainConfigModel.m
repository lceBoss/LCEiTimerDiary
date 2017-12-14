//
//  KNBMainConfigModel.m
//  KenuoTraining
//
//  Created by Robert on 16/2/29.
//  Copyright © 2016年 Robert. All rights reserved.
//

NSString *const KNB_MainConfigKey = @"mainConfig";        //主配置
NSString *const KNB_InterfaceList = @"data";              //接口列表
NSString *const KNB_BaseUrlKey = @"base_url";             //基本Url
NSString *const KNB_SecretSalt = @"secret";               //加密密匙

// 个人信息
NSString *const KNB_UserDetail = @"PersonalDetails";                    // 用户详情


#import "LCEMainConfigModel.h"


@interface LCEMainConfigModel ()

@property (nonatomic, strong) NSDictionary *mainConfigDic;

@property (nonatomic, strong) NSDictionary *interfaceListDic;

@end


@implementation LCEMainConfigModel

LCE_DEFINE_SINGLETON_FOR_CLASS(LCEMainConfigModel);

- (NSString *)getRequestUrlWithKey:(NSString *)key {
    NSString *url = [[self interfaceListDic] objectForKey:key];
    if (!isNullStr(url)) {
        return url;
    }
    return @"";
}

- (NSDictionary *)interfaceListDic {
    return [[self mainConfigDic] objectForKey:KNB_InterfaceList];
}

- (NSDictionary *)mainConfigDic {
    return [[NSUserDefaults standardUserDefaults] objectForKey:KNB_MainConfigKey];
}

- (void)regestMainConfig:(id)request {
    if ([request[KNB_InterfaceList] isKindOfClass:[NSString class]] ||
        [request[KNB_InterfaceList] isKindOfClass:[NSNull class]]) {
        return;
    }
    [[NSUserDefaults standardUserDefaults] setObject:request forKey:KNB_MainConfigKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}



@end
