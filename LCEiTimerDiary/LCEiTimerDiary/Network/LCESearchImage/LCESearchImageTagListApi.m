//
//  LCESearchImageTagListApi.m
//  LCEiTimerDiary
//
//  Created by 妖狐小子 on 2018/5/23.
//  Copyright © 2018年 妖狐小子. All rights reserved.
//

#import "LCESearchImageTagListApi.h"

@implementation LCESearchImageTagListApi

- (instancetype)init {
    if (self = [super init]) {
    }
    return self;
}

- (NSString *)requestUrl {
    return @"http://127.0.0.1:5000/toutiao/searchImage/keywordList";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    NSDictionary *dic = @{};
    return dic;
}


@end
