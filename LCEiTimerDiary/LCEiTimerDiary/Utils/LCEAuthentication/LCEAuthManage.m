//
//  LCEAuthManage.m
//  LCEiTimerDiary
//
//  Created by 妖狐小子 on 2017/11/23.
//  Copyright © 2017年 妖狐小子. All rights reserved.
//

#import "LCEAuthManage.h"
#import <LocalAuthentication/LocalAuthentication.h>

@interface LCEAuthManage ()

@property (nonatomic, assign) LCEAuthManageResult resultType;

@end

@implementation LCEAuthManage

LCE_DEFINE_SINGLETON_FOR_CLASS(LCEAuthManage);

- (void)startAuthenticateWithDelegate:(id<LCEAuthManageDelegate>)delegate {
    
    self.delegate = delegate;
    
    //创建LAContext
    LAContext* context = [[LAContext alloc] init];
    //这个属性是设置指纹输入失败之后的弹出框的选项
    context.localizedFallbackTitle = @"忘记密码";
    NSError* error = nil;
    NSString* result = @"请验证已有指纹";
    
    //首先使用canEvaluatePolicy 判断设备支持状态
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        //支持指纹验证
        
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:result reply:^(BOOL success, NSError *error) {
            if (success) {
                //验证成功 刷新主界面
                if (_delegate && [_delegate respondsToSelector:@selector(authManageVerifyByFingerprintWithAuthResult:)]) {
                    [_delegate authManageVerifyByFingerprintWithAuthResult:LCEAuthManageResultSuccess];
                }
            }else {
                //验证结果
                LCEAuthManageResult authResult;
                
                NSLog(@"%@",error.localizedDescription);
                switch (error.code) {
                    case LAErrorSystemCancel: {
                        //系统取消授权，如其他APP切入
                        authResult = LCEAuthManageResultCancel;
                        break;
                    }
                    case LAErrorUserCancel: {
                        //用户取消验证Touch ID
                        authResult = LCEAuthManageResultCancel;
                        break;
                    }
                    case LAErrorAuthenticationFailed: {
                        //授权失败
                        authResult = LCEAuthManageResultFailed;
                        break;
                    }
                    case LAErrorPasscodeNotSet: {
                        //系统未设置密码
                        authResult = LCEAuthManageResultPasscodeNotSet;
                        break;
                    }
                    case LAErrorTouchIDNotAvailable: {
                        //设备Touch ID不可用，例如未打开
                        authResult = LCEAuthManageResultNotEnrolled;
                        break;
                    }
                    case LAErrorTouchIDNotEnrolled: {
                        //设备Touch ID不可用，用户未录入
                        authResult = LCEAuthManageResultNotEnrolled;
                        break;
                    }
                    case LAErrorUserFallback: {
                        //用户选择输入密码，切换主线程处理
                        authResult = LCEAuthManageResultUserFallback;
                        break;
                    }
                    default: {
                        //其他原因
                        authResult = LCEAuthManageResultOther;
                        break;
                    }
                }
                if (_delegate && [_delegate respondsToSelector:@selector(authManageVerifyByFingerprintWithAuthResult:)]) {
                    [_delegate authManageVerifyByFingerprintWithAuthResult:authResult];
                }
            }
        }];
    }else{
        //验证结果
        LCEAuthManageResult authResult;
        
        NSLog(@"不支持指纹识别");
        switch (error.code) {
            case LAErrorTouchIDNotEnrolled: {
                //TouchID is not enrolled
                authResult = LCEAuthManageResultNotEnrolled;
                break;
            }
            case LAErrorPasscodeNotSet: {
                //A passcode has not been set
                authResult = LCEAuthManageResultNotEnrolled;
                break;
            }
            default: {
                //TouchID not available
                authResult = LCEAuthManageResultSysNotSupport;
                break;
            }
        }
        if (_delegate && [_delegate respondsToSelector:@selector(authManageVerifyByFingerprintWithAuthResult:)]) {
            [_delegate authManageVerifyByFingerprintWithAuthResult:authResult];
        }
        
        NSLog(@"%@",error.localizedDescription);
    }
}


@end
