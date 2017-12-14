//
//  LCEAppManager.h
//  LCEiTimerDiary
//
//  Created by 妖狐小子 on 2017/12/11.
//  Copyright © 2017年 妖狐小子. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCEAppManager : NSObject

LCE_DEFINE_SINGLETON_FOR_HEADER(LCEAppManager);

/**
 * 配置数据库
 */
- (void)configureCoreDataPath;

@end
