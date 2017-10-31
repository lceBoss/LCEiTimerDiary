//
//  LCEUtilExtend.h
//  LCEiTimerDiary
//
//  Created by 妖狐小子 on 2017/10/31.
//  Copyright © 2017年 妖狐小子. All rights reserved.
//

#ifndef LCEUtilExtend_h
#define LCEUtilExtend_h

#import <CoreGraphics/CGBase.h>
#import <NotificationCenter/NotificationCenter.h>

//通知相关
CG_INLINE void LCE_ADD_NOTIFICATION(NSString *name, id target, SEL action, id object) {
    [[NSNotificationCenter defaultCenter] addObserver:target selector:action name:name object:object];
}

CG_INLINE void LCE_REMOVE_NOTIFICATION(NSString *name, id target, id object) {
    [[NSNotificationCenter defaultCenter] removeObserver:target name:name object:object];
}

CG_INLINE void LCE_POST_NOTIFICATION(NSString *name, id object, NSDictionary *userInfo) {
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:object userInfo:userInfo];
}

CG_INLINE BOOL isNullStr(NSString *str) {
    NSCharacterSet *whiltSpace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *textStr = [str stringByTrimmingCharactersInSet:whiltSpace];
    if (textStr == nil ||
        [textStr isEqualToString:@""] ||
        textStr.length == 0 ||
        [str isKindOfClass:[NSNull class]]) {
        return YES;
    }
    return NO;
}

//多线程相关
CG_INLINE void LCE_PerformAsynchronous(void (^block)(void)) {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, block);
}

CG_INLINE void LCE_PerformOnMainThread(void (^block)(void)) {
    dispatch_async(dispatch_get_main_queue(), block);
}

typedef NS_ENUM(NSUInteger, LCERecorderType) {
    LCERecorderPhoto = 2, //照片
    LCERecorderVideo      //视频
};

CG_INLINE BOOL isPhoneNumber(NSString *number) {
    //* 普通
    NSString *MB = @"^1[3-9]\\d{9}$";
    //* 移动
    NSString *CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    //* 联通
    NSString *CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    //* 电信
    NSString *CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    
    
    NSPredicate *regextestmb = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MB];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    if (([regextestmb evaluateWithObject:number] == YES) ||
        ([regextestcm evaluateWithObject:number] == YES) ||
        ([regextestct evaluateWithObject:number] == YES) ||
        ([regextestcu evaluateWithObject:number] == YES)) {
        return YES;
    } else {
        return NO;
    }
}

#endif /* LCEUtilExtend_h */
