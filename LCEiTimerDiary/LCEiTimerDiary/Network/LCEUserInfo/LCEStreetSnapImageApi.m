//
//  LCEStreetSnapImageApi.m
//  LCEiTimerDiary
//
//  Created by 妖狐小子 on 2018/5/15.
//  Copyright © 2018年 妖狐小子. All rights reserved.
//

#import "LCEStreetSnapImageApi.h"

@implementation LCEStreetSnapImageApi {
    NSString *_keyword;
    NSInteger _page;
}

- (instancetype)initWithKeyword:(NSString *)keyword page:(NSInteger)page {
    if ([super init]) {
        _keyword = keyword;
        _page = page;
    }
    return self;
}

- (NSString *)requestUrl {
//    return @"http://127.0.0.1:5000";
//    return @"http://127.0.0.1:5000/todo/api/v1.0/tasks";
    return @"http://127.0.0.1:5000/toutiao/searchImage";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    NSDictionary *dic = @{ @"keyword" : _keyword,
                           @"page" : @(_page)
                           };
    return dic;
}

@end
