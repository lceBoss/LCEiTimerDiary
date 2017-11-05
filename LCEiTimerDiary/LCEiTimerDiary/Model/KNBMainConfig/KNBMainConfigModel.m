//
//  KNBMainConfigModel.m
//  KenuoTraining
//
//  Created by Robert on 16/2/29.
//  Copyright © 2016年 Robert. All rights reserved.
//

NSString *const KNB_MainConfigKey = @"mainConfig";        //主配置
NSString *const KNB_InterfaceList = @"data";              //接口列表
NSString *const KNB_ArticleClassify = @"articleClassify"; // 发现文章分类列表
NSString *const KNB_BaseUrlKey = @"base_url";             //基本Url
NSString *const KNB_SecretSalt = @"secret";               //加密密匙
NSString *const KNB_Cs_secret = @"cs_secret";             //报货加密 秘钥
NSString *const KNB_Cs_ver_num = @"cs_ver_num";           //报货系统版本

NSString *const KNB_UploadFile = @"uploadFile"; //上传文件

// 推送
NSString *const KNB_DeviceTokenInsert = @"cidInsert"; //提交用户cid
NSString *const KNB_NoticeRead = @"readed";           // 推送阅读回执

// 个人信息
NSString *const KNB_UserDetail = @"PersonalDetails";                    // 用户详情
NSString *const KNB_Login = @"login";                                   //登录
NSString *const KNB_SendVerifyCode = @"sendVerifyCode";                 //获取验证码
NSString *const KNB_UpdatePwd = @"updatePwd";                           //密码修改
NSString *const KNB_QuerySysSprcility = @"querySysSprcility";           //获取用户特长
NSString *const KNB_AddSpeciliaty = @"addSpeciliaty";                   // 添加用户特长
NSString *const KNB_AddUserInfo = @"addUserInfo";                       //添加用户自我描述
NSString *const KNB_UpdateServiceManifesto = @"updateServiceManifesto"; // 服务宣言
NSString *const KNB_AddUserInfoContent = @"addUserInfoContent";         //添加用户生活照片
NSString *const KNB_UpdateUser = @"updateUser";                         //更新用户信息
NSString *const KNB_FeedBack = @"feedBack";                             //问题反馈
NSString *const KNB_UpdateStatusByUid = @"updateStatusByUid";           //更新用户状态
NSString *const KNB_InsertTrainScoreLog = @"insertTrainScoreLog";       // 完成任务奖励学分


#import "KNBMainConfigModel.h"


@interface KNBMainConfigModel ()

@property (nonatomic, strong) NSDictionary *mainConfigDic;

@property (nonatomic, strong) NSDictionary *interfaceListDic;

@end


@implementation KNBMainConfigModel

LCE_DEFINE_SINGLETON_FOR_CLASS(KNBMainConfigModel);

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

- (NSArray *)getArticleCategoryList {
    return [[self mainConfigDic] objectForKey:KNB_ArticleClassify];
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
