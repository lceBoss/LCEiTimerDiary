//
//  NSString+Contain.m
//  KenuoTraining
//
//  Created by Robert on 16/2/22.
//  Copyright © 2016年 Robert. All rights reserved.
//

#import "NSString+Contain.h"


@implementation NSString (Contain)

- (BOOL)contains:(NSString *)substring {
    NSRange range = [self rangeOfString:substring];
    return range.location != NSNotFound;
}

- (BOOL)endsWith:(NSString *)substring {
    NSRange range = [self rangeOfString:substring];
    return range.location == [self length] - [substring length];
}

- (BOOL)startsWith:(NSString *)substring {
    NSRange range = [self rangeOfString:substring];
    return range.location == 0;
}

@end
