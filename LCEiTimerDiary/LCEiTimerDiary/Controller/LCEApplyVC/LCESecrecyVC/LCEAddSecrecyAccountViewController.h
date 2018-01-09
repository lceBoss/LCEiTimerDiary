//
//  LCEAddSecrecyAccountViewController.h
//  LCEiTimerDiary
//
//  Created by 妖狐小子 on 2018/1/5.
//  Copyright © 2018年 妖狐小子. All rights reserved.
//

#import "LCEBaseViewController.h"

typedef void(^LCEAddSecrecyAccountViewControllerBlock)(void);

@interface LCEAddSecrecyAccountViewController : LCEBaseViewController

@property (nonatomic, copy) LCEAddSecrecyAccountViewControllerBlock refreshBlock;

@end
