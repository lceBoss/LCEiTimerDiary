//
//  KNBBaseRequest.m
//  KenuoTraining
//
//  Created by Robert on 16/3/12.
//  Copyright © 2016年 Robert. All rights reserved.
//

#import "LCEBaseRequest.h"
#import "LCEBaseRequestAccessory.h"
#import "LCEMainConfigModel.h"
#import "NSString+MD5.h"


@interface LCEBaseRequest ()

@property (nonatomic, strong) LCEBaseRequestAccessory *accessory;

@end


@implementation LCEBaseRequest

- (instancetype)init {
    if (self = [super init]) {
        [self addAccessory:self.accessory];
    }
    return self;
}

- (NSInteger)getRequestStatuCode {
    NSDictionary *jsonDic = self.responseJSONObject;
    return [[jsonDic objectForKey:@"result"] integerValue];
}

- (BOOL)requestSuccess {
    return [self getRequestStatuCode] == 200;
}

- (NSString *)errMessage {
    NSDictionary *jsonDic = self.responseJSONObject;
    return [jsonDic objectForKey:@"message"];
}

- (NSTimeInterval)requestTimeoutInterval {
    return 20;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (YTKRequestSerializerType)requestSerializerType {
    return YTKRequestSerializerTypeJSON;
}

- (id)requestArgument {
    return self.appendSecretDic;
}

- (NSMutableDictionary *)baseMuDic {
    if (!_baseMuDic) {
        _baseMuDic = [NSMutableDictionary dictionary];
    }
//    NSString *userToken = [LCEUserInfo shareInstance].userToken;
//    NSString *user_id = [LCEUserInfo shareInstance].userId;
    NSDictionary *dic = @{
                           @"user_token" : @"bb90af75-2d37-4883-a769-c8d787bc4c0f",
                           @"nowu_id" : @"ea6394b3ac5b494eb36d872536c5202b",
                           @"client" : @"ios",
                           @"ver_num" : LCE_APP_VERSION
                           };
    [_baseMuDic addEntriesFromDictionary:dic];
    return _baseMuDic;
}

- (NSDictionary *)appendSecretDic {
    NSString *jsonStr = [LCEBaseRequest changeJsonStr:self.baseMuDic];
    NSString *saltKey = [[LCEMainConfigModel shareInstance] getRequestUrlWithKey:KNB_SecretSalt];
    if (isNullStr(saltKey)) {
        saltKey = @"dengyun2017";
    }
    NSString *saltStr = [NSString stringWithFormat:@"%@%@%@", saltKey, jsonStr, saltKey];
    NSString *sign = [saltStr MD5];
    NSDictionary *dic = @{ @"sign" : sign,
                           @"jsonStr" : [NSString stringWithFormat:@"train%@", jsonStr] };
    return dic;
}

+ (NSString *)changeJsonStr:(NSDictionary *)dic {
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonStr;
}

#pragma mark - Getter&Setter
- (LCEBaseRequestAccessory *)accessory {
    if (!_accessory) {
        _accessory = [[LCEBaseRequestAccessory alloc] init];
    }
    return _accessory;
}

- (NSString *)hudString {
    return _hudString ? _hudString : nil;
}


@end
