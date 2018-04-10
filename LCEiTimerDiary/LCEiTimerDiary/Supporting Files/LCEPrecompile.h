//
//  LCEPrecompile.h
//  LCEiTimerDiary
//
//  Created by 妖狐小子 on 2017/10/31.
//  Copyright © 2017年 妖狐小子. All rights reserved.
//

#ifndef LCEPrecompile_h
#define LCEPrecompile_h

//主代理
#define LCE_AppDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

//单例宏定义.h
#define LCE_DEFINE_SINGLETON_FOR_HEADER(className) \
\
+(className *)shareInstance

//单例宏定义.m
#define LCE_DEFINE_SINGLETON_FOR_CLASS(className) \
\
+(className *)shareInstance {                 \
static className *instance = nil;         \
static dispatch_once_t onceToken;         \
dispatch_once(&onceToken, ^{              \
instance = [[self alloc] init];       \
});                                       \
return instance;                          \
}

//当前系统版本
#define LCE_SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

//App版本
#define LCE_APP_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

//导航颜色
#define LCE_NAV_COLOR [UIColor colorWithRed:59 / 255.0 green:156 / 255.0 blue:255 / 255.0 alpha:1.0]
//51  163  220

//色值宏定义
#define LCE_RGBA(r, g, b, a) [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:a]
#define LCE_RGB(r, g, b) [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:1.0]

//屏幕大小
#define LCE_SCREEN_BOUNDS [[UIScreen mainScreen] bounds]

//设备屏幕高度
#define LCE_SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

//设备屏幕宽度
#define LCE_SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width

//状态栏高度
#define LCE_STATUS_BAR_H [[UIApplication sharedApplication] statusBarFrame].size.height;

// 导航栏高度
#define LCE_NAV_HEIGHT ([[UIApplication sharedApplication] statusBarFrame].size.height + self.navigationController.navigationBar.frame.size.height)

//tabar高度
#define LCE_TAB_HEIGHT (LCE_ISIPHONEX ? (49.f+34.f) : 49.f)

//判断是否是iphoneX
#define LCE_ISIPHONEX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size)) : NO)

//沙盒路径
#define LCE_PATH_SANDBOX (NSHomeDirectory())
#define LCE_PATH_DOCUMENTS (NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0])
#define LCE_PATH_LIBRARY (NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0])
#define LCE_PATH_CACHE (NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0])
#define LCE_PATH_TMP (NSTemporaryDirectory())

//weakSelf
#define LCE_WS(weakSelf) __weak __typeof(self) weakSelf = self;
//strongSelf
#define LCE_SS(strongSelf, weakSelf) __strong __typeof(weakSelf) strongSelf = weakSelf;

#endif /* LCEPrecompile_h */
