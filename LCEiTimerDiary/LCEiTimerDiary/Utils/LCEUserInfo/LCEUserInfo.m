//
//  LCEUserInfo.m
//  KenuoTraining
//
//  Created by Robert on 16/2/23.
//  Copyright © 2016年 Robert. All rights reserved.
//

#import "LCEUserInfo.h"

#define LCE_SAVE_LOGIN_VERSION @"LCE_SAVE_LOGIN_VERSION"

static NSString *const LCE_USER_LOGINSUCCESS = @"LCE_USER_LOGINSUCCESS";
static NSString *const LCE_USER_INFO = @"LCE_USER_INFO";
static NSString *const LCE_USER_PHOTO = @"user_photo";
static NSString *const LCE_USER_NAME = @"user_name";
static NSString *const LCE_USER_TOKEN = @"user_token";
static NSString *const LCE_USER_CACHETOKEN = @"LCE_USER_CACHETOKEN";


@interface LCEUserInfo ()

@property (nonatomic, copy, readwrite) NSString *userId;
@property (nonatomic, copy, readwrite) NSString *userPhoto;
@property (nonatomic, copy, readwrite) NSString *userName;

@end


@implementation LCEUserInfo

LCE_DEFINE_SINGLETON_FOR_CLASS(LCEUserInfo);

- (BOOL)isFirstLogin {
    NSString *success = [[NSUserDefaults standardUserDefaults] objectForKey:LCE_USER_LOGINSUCCESS];
    return success ? NO : YES;
}

/**
 *  登录成功
 */
- (void)loginSuccess {
    [[NSUserDefaults standardUserDefaults] setObject:@"LCE_USER_LOGINSUCCESS"
                                              forKey:LCE_USER_LOGINSUCCESS];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
}

- (void)registUserInfo:(NSDictionary *)userInfo {
    // 保存json
    NSDictionary *newDic = [self changeNullValue:userInfo];
    NSString *jsonStr = [self changeToJson:newDic];
    [[NSUserDefaults standardUserDefaults] setObject:jsonStr
                                              forKey:LCE_USER_INFO];
    // 缓存一份userToken
    [[NSUserDefaults standardUserDefaults] setObject:userInfo[LCE_USER_TOKEN] forKey:LCE_USER_CACHETOKEN];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSDictionary *)changeNullValue:(NSDictionary *)dic {
    NSMutableDictionary *muDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    for (NSString *key in dic.allKeys) {
        if ([dic[key] isKindOfClass:[NSNull class]]) {
            [muDic setValue:@"" forKey:key];
        }
    }
    return muDic;
}

- (NSString *)changeToJson:(NSDictionary *)dic {
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonStr;
}

- (NSDictionary *)userInfo {
    id jsonStr = [[NSUserDefaults standardUserDefaults] objectForKey:LCE_USER_INFO];
    if (jsonStr == nil) {
        return nil;
    }
    if ([jsonStr isKindOfClass:[NSDictionary class]]) {
        return jsonStr;
    }
    NSData *jsonData = [(NSString *)jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    return dic;
}

- (void)logout {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:LCE_USER_LOGINSUCCESS];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:LCE_USER_INFO];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/**
 需要重新登录
 */
- (BOOL)needLoginAgain {
    NSString *loginVersion = [[NSUserDefaults standardUserDefaults] objectForKey:LCE_SAVE_LOGIN_VERSION];
    if (!loginVersion || ![loginVersion isEqualToString:LCE_APP_VERSION]) {
        [[NSUserDefaults standardUserDefaults] setObject:LCE_APP_VERSION forKey:LCE_SAVE_LOGIN_VERSION];
        [[NSUserDefaults standardUserDefaults] synchronize];
        return YES;
    }
    return NO;
}

#pragma MAKR - sync user message
- (void)syncUserPhotoUrl:(NSString *)photoUrl {
    NSMutableDictionary *muDic = [NSMutableDictionary dictionaryWithDictionary:self.userInfo];
    muDic[LCE_USER_PHOTO] = photoUrl ?: @"";
    [self registUserInfo:muDic];
}

#pragma MAKR - get user message

- (NSString *)userName {
    return self.userInfo[LCE_USER_NAME] ?: @"";
}

- (NSString *)userPhoto {
    return self.userInfo[LCE_USER_PHOTO] ?: @"";
}


@end
