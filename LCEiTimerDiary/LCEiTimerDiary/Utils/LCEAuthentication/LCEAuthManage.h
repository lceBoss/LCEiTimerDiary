//
//  LCEAuthManage.h
//  LCEiTimerDiary
//
//  Created by 妖狐小子 on 2017/11/23.
//  Copyright © 2017年 妖狐小子. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, LCEAuthManageResult) {
    LCEAuthManageResultSuccess = 0,     //验证成功
    LCEAuthManageResultCancel,          //取消授权（系统和用户）
    LCEAuthManageResultFailed,          //验证失败
    LCEAuthManageResultPasscodeNotSet,  //系统未设置密码
    LCEAuthManageResultNotEnrolled,     //设备Touch ID不可用（未打开 或 未录入）
    LCEAuthManageResultUserFallback,    //用户选择输入密码
    LCEAuthManageResultSysNotSupport,   //设备不支持
    LCEAuthManageResultOther            //其他
};

@class LCEAuthManage;
@protocol LCEAuthManageDelegate <NSObject>
/**
 指纹识别
 @param result 识别结果
 */
- (void)authManageVerifyByFingerprintWithAuthResult:(LCEAuthManageResult)result;

@end

@interface LCEAuthManage : NSObject
//单例
LCE_DEFINE_SINGLETON_FOR_HEADER(LCEAuthManage);

@property (nonatomic, weak) id<LCEAuthManageDelegate> delegate;

/**
 开始验证
 */
- (void)startAuthenticateWithDelegate:(id<LCEAuthManageDelegate>)delegate;

@end
