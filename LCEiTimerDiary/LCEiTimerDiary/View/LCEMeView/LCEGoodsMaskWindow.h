//
//  LCEGoodsMaskWindow.h
//  LCEiTimerDiary
//
//  Created by 妖狐小子 on 2019/3/5.
//  Copyright © 2019 妖狐小子. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LCEGoodsMaskWindow : UIWindow

// 初始化方法
- (instancetype)initWithFrame:(CGRect)frame;

// 出现
- (void)presentAnimations:(void (^)(void))animations view:(UIView *)view;
// 消失
- (void)dismissAnimations:(void (^)(void))animations complete:(void (^)(BOOL finished))completion;

@end

NS_ASSUME_NONNULL_END
