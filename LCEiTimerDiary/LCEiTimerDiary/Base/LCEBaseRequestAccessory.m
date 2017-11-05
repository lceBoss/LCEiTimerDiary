//
//  LCEBaseRequestAccessory.m
//  KenuoTraining
//
//  Created by Robert on 16/3/17.
//  Copyright © 2016年 Robert. All rights reserved.
//

#import "LCEBaseRequestAccessory.h"
#import <AFNetworking.h>
#import <LCProgressHUD.h>
#import "AppDelegate.h"
#import "LCEBaseRequest.h"


@implementation LCEBaseRequestAccessory

- (void)requestWillStart:(id)request {
    LCEBaseRequest *baseRequest = (LCEBaseRequest *)request;
    if (baseRequest.needHud || !isNullStr(baseRequest.hudString) || baseRequest.hudString != nil) {
        LCE_PerformOnMainThread(^{
            NSString *hudStirng = baseRequest.hudString != nil ? baseRequest.hudString : @"玩命加载中";
            [LCProgressHUD showLoading:hudStirng];
        });
    }
}

- (void)requestWillStop:(id)request {
}

- (void)requestDidStop:(id)request {
    LCEBaseRequest *baseRequest = (LCEBaseRequest *)request;

//    if ([LCEUserInfo shareInstance].userInfo && baseRequest.getRequestStatuCode == KNTraingError_token && ![NSStringFromClass([request class]) isEqualToString:@"KNBMainConfigApi"]) {
//        [LCE_AppDelegate.navController popToRootViewControllerAnimated:false];
//        [LCE_AppDelegate.tabBarController turnToControllerIndex:0];
//        [LCE_AppDelegate presentLoginViewController];
//        [LCProgressHUD showFailure:@"为了您的帐号安全,请重新登录!"];
//        return;
//    }

    if (baseRequest.needHud || !isNullStr(baseRequest.hudString) || baseRequest.hudString != nil) {
        //请求失败
        if (baseRequest.error || baseRequest.responseStatusCode != 200) {
            if ([AFNetworkReachabilityManager sharedManager].reachable) {
                LCE_PerformOnMainThread(^{

                    [LCProgressHUD showFailure:@"请求失败"];
                });
            } else {
                LCE_PerformOnMainThread(^{
                    [LCProgressHUD showFailure:@"网络状态差请稍后重试"];
                });
            }
        } else {
            LCE_PerformOnMainThread(^{
//                if (baseRequest.getRequestStatuCode == 200 ||
//                    baseRequest.getRequestStatuCode == KNTraingError_update) {
                    [LCProgressHUD hide];
//                } else {
//                    [LCProgressHUD showFailure:baseRequest.errMessage ?: @"出错啦!"];
//                }
            });
        }
    }
}

@end
