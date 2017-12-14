//
//  KNBMainConfig.m
//  KenuoTraining
//
//  Created by Robert on 16/2/29.
//  Copyright © 2016年 Robert. All rights reserved.
//

#import "LCEMainConfigApi.h"


@interface LCEMainConfigApi ()

@end


@implementation LCEMainConfigApi

- (id)requestArgument {
    return self.baseMuDic;
}

- (NSString *)requestUrl {
    return @"/appServer/common/main.do";
}

@end
