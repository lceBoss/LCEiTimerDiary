//
//  LCEAppManager.m
//  LCEiTimerDiary
//
//  Created by 妖狐小子 on 2017/12/11.
//  Copyright © 2017年 妖狐小子. All rights reserved.
//

#import "LCEAppManager.h"
#import <MagicalRecord/MagicalRecord.h>
#import "AppDelegate.h"
#import "NSString+MD5.h"
#import "YTKNetworkConfig.h"
#import "AFNetworkReachabilityManager.h"
#import "LCEMainConfigApi.h"
#import "LCEMainConfigModel.h"

@implementation LCEAppManager

LCE_DEFINE_SINGLETON_FOR_CLASS(LCEAppManager);

- (instancetype)init {
    self = [super init];
    if (self) {
        [self configureThird];
    }
    return self;
}

- (void)configureThird {
    // 配置数据库路径
    [self configureCoreDataPath];
    
    // 判断网络状态
    [self configureNetReachability];
    
    // 网络请求配置
    [self configureRequestFilters];
    
}

#pragma mark - Configure CoreData

- (void)configureCoreDataPath {
    
    // md5 加密 作为数据库名称
    NSString *dbName = [[NSString stringWithFormat:@"yaohuxiaozi"] MD5];
    [MagicalRecord cleanUp];
    NSString *sqlitName = [NSString stringWithFormat:@"%@.sqlite", dbName];
    [MagicalRecord setupCoreDataStackWithAutoMigratingSqliteStoreNamed:sqlitName];
    [MagicalRecord setLoggingLevel:MagicalRecordLoggingLevelOff];
}

#pragma mark - Configure NetWork
- (void)configureNetReachability {
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
}

- (void)configureRequestFilters {
    YTKNetworkConfig *config = [YTKNetworkConfig sharedConfig];
    config.baseUrl = LCE_MAINCONFIGURL;
    
    //https 公匙
    //    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"https" ofType:@"cer"];
    //    NSData * certData =[NSData dataWithContentsOfFile:cerPath];
    //    NSSet * certSet = [[NSSet alloc] initWithObjects:certData, nil];
    //
    //    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    //    [securityPolicy setAllowInvalidCertificates:YES];
    //    [securityPolicy setValidatesDomainName:NO];
    //    [securityPolicy setPinnedCertificates:certSet];
    //    config.securityPolicy = securityPolicy;
    
    LCEMainConfigApi *mainConfig = [[LCEMainConfigApi alloc] init];
    // 10014 token失效
    [mainConfig startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        
        if (request.responseJSONObject && request.responseStatusCode == 200) {
            if (mainConfig.requestSuccess ||
                mainConfig.getRequestStatuCode == LCEError_token ||
                mainConfig.getRequestStatuCode == LCEError_update) {
                [[LCEMainConfigModel shareInstance] regestMainConfig:request.responseJSONObject];
//                [[KNBMainConfigModel shareInstance] newVersion];
            }

            if (mainConfig.requestSuccess) {
                NSLog(@"请求成功了，你个渣渣");
//                NSString *version = [[KNBMainConfigModel shareInstance] newVersion];
//                [[KNBRemindUpdate shareInstance] remindUpdateApp:version];
//                if ([[KNBUserInfo shareInstance] needLoginAgain]) {
//                    [KNB_AppDelegate presentLoginViewController];
//                }
            } else if (mainConfig.getRequestStatuCode == LCEError_update) { // 强制更新
//                NSString *version = [[KNBMainConfigModel shareInstance] newVersion];
//                [[KNBRemindUpdate shareInstance] remindForcedUpdate:version];
            }
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        NSLog(@"mainConfig failed");
    }];
}

@end
