//
//  LCESecrecyAddView.h
//  LCEiTimerDiary
//
//  Created by 妖狐小子 on 2018/1/4.
//  Copyright © 2018年 妖狐小子. All rights reserved.
//

#import <UIKit/UIKit.h>
// 添加回调
typedef void (^LCESecrecyAddViewBlock)(void);

@interface LCESecrecyAddView : UIView

@property (nonatomic, copy) LCESecrecyAddViewBlock addBlock;

- (instancetype)initWithFrame:(CGRect)frame;

@end
