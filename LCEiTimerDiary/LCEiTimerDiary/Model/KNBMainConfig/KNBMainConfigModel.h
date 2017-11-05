//
//  KNBMainConfigModel.h
//  KenuoTraining
//
//  Created by Robert on 16/2/29.
//  Copyright © 2016年 Robert. All rights reserved.
//

#import "LCEBaseModel.h"

//主配置字典
extern NSString *const KNB_BaseUrlKey;

//上传文件
extern NSString *const KNB_UploadFile;

extern NSString *const KNB_SecretSalt; //加密密匙
extern NSString *const KNB_Cs_secret;  //报货加密 秘钥
extern NSString *const KNB_Cs_ver_num; //报货系统版本

// 推送
extern NSString *const KNB_DeviceTokenInsert; //提交用户cid
extern NSString *const KNB_NoticeRead;        // 推送阅读回执

// 个人信息
extern NSString *const KNB_UserDetail;             // 用户详情
extern NSString *const KNB_Login;                  //登录
extern NSString *const KNB_SendVerifyCode;         //获取验证码
extern NSString *const KNB_UpdatePwd;              //密码修改
extern NSString *const KNB_QuerySysSprcility;      //获取用户特长
extern NSString *const KNB_AddSpeciliaty;          // 添加用户特长
extern NSString *const KNB_AddUserInfo;            //添加用户自我描述
extern NSString *const KNB_UpdateServiceManifesto; // 服务宣言
extern NSString *const KNB_AddUserInfoContent;     //添加用户生活照片
extern NSString *const KNB_UpdateUser;             //更新用户信息
extern NSString *const KNB_FeedBack;               //问题反馈
extern NSString *const KNB_UpdateStatusByUid;      //更新用户状态
extern NSString *const KNB_InsertTrainScoreLog;    // 完成任务奖励学分

@interface KNBMainConfigModel : NSObject
;

+ (instancetype)shareInstance;

- (void)regestMainConfig:(id)request;

- (NSString *)getRequestUrlWithKey:(NSString *)key;

- (NSArray *)getArticleCategoryList;

@end
