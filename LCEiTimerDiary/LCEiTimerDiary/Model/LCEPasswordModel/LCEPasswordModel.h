//
//  LCEPasswordModel.h
//  LCEiTimerDiary
//
//  Created by 妖狐小子 on 2017/12/12.
//  Copyright © 2017年 妖狐小子. All rights reserved.
//

#import "LCEBaseModel.h"

@interface LCEPasswordModel : LCEBaseModel
// 账号
@property (nullable, nonatomic, strong) NSString *account;
// 密码
@property (nullable, nonatomic, strong) NSString *password;

@end
