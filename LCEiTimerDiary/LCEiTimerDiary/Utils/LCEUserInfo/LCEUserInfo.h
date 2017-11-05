//
//  LCEUserInfo.h
//  KenuoTraining
//
//  Created by Robert on 16/2/23.
//  Copyright © 2016年 Robert. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LCEUserInfo : NSObject

+ (LCEUserInfo *)shareInstance;

/**
 *  是否首次登陆
 */
@property (nonatomic, assign, readonly) BOOL isFirstLogin;
/**
 *  用户信息
 */
@property (nonatomic, strong, readonly) NSDictionary *userInfo;
@property (nonatomic, copy, readonly) NSString *userId;
@property (nonatomic, copy, readonly) NSString *userPhoto;      // 头像
@property (nonatomic, copy, readonly) NSString *userName;       // 姓名

/**
 *  注册用户信息
 *
 *  @param userInfo 用户信息
 */
- (void)registUserInfo:(NSDictionary *)userInfo;

/**
 *  登录成功
 */
- (void)loginSuccess;

/**
 *  登出抹除数据
 */
- (void)logout;

/**
 需要重新登录
 */
- (BOOL)needLoginAgain;

/**
 *  同步用户信息
 */
- (void)syncUserPhotoUrl:(NSString *)photoUrl;

@end
