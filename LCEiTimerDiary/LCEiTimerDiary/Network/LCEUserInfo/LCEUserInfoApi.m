//
//  LCEUserInfoApi.m
//  LCEiTimerDiary
//
//  Created by 妖狐小子 on 2017/12/14.
//  Copyright © 2017年 妖狐小子. All rights reserved.
//

#import "LCEUserInfoApi.h"

@implementation LCEUserInfoApi {
    NSString *_userId;
}

- (instancetype)initWithUserId:(NSString *)userId {
    if (self = [super init]) {
        _userId = userId;
    }
    return self;
}
    
- (NSString *)requestUrl {
    return [[LCEMainConfigModel shareInstance] getRequestUrlWithKey:KNB_UserDetail];
}
    
- (id)requestArgument {
    NSDictionary *dic = @{ @"u_id" : _userId,//ea6394b3ac5b494eb36d872536c5202b
                           @"user_id" : @"ea6394b3ac5b494eb36d872536c5202b",
                           @"company_id" : @(1000001)
                           };
    [self.baseMuDic addEntriesFromDictionary:dic];
    return self.appendSecretDic;
}

@end
