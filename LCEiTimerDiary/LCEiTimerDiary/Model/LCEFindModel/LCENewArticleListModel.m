//
//  KNBNewArticleListModel.m
//  KenuoTraining
//
//  Created by 妖狐小子 on 16/12/12.
//  Copyright © 2016年 Robert. All rights reserved.
//

#import "LCENewArticleListModel.h"


@implementation LCENewArticleListModel

//+ (NSValueTransformer *)contentslistJSONTransformer {
//    return [MTLJSONAdapter arrayTransformerWithModelClass:KNBArticleImageModel.class];
//}


- (nullable NSArray *)articleImages {
    NSMutableArray *urls = [NSMutableArray array];
    for (NSString *url in self.contentslist) {
        [urls addObject:url ?: @""];
    }
    return urls;
}

@end
