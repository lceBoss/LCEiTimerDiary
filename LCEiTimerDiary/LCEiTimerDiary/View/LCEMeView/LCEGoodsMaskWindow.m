//
//  LCEGoodsMaskWindow.m
//  LCEiTimerDiary
//
//  Created by 妖狐小子 on 2019/3/5.
//  Copyright © 2019 妖狐小子. All rights reserved.
//

#import "LCEGoodsMaskWindow.h"
#import "AppDelegate.h"

@implementation LCEGoodsMaskWindow

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.windowLevel = UIWindowLevelAlert;
        self.backgroundColor = [UIColor colorWithHex:0.1 alpha:0.6];
        self.userInteractionEnabled = true;
    }
    return self;
}

#pragma mark - Animation
- (void)firstStepAnimation {
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DScale(transform, 0.9, 0.9, 1);
    // 以x轴为起始点 进行旋转
    transform.m24 = -1.0 / 2000;
    LCE_AppDelegate.window.layer.transform = transform;
}

- (void)secondStepAnimation:(UIView *)view {
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DTranslate(transform, 0, view.frame.size.height * (-0.08), 0);
    transform = CATransform3DScale(transform, 0.8, 0.8, 1);
    LCE_AppDelegate.window.layer.transform = transform;
}

//出现
- (void)presentAnimations:(void (^)(void))animations view:(UIView *)view {
    [UIView animateWithDuration:0.3 animations:^{
        [self makeKeyAndVisible];
        [self firstStepAnimation];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            [self secondStepAnimation:view];
        } completion:^(BOOL finished){
            
        }];
    }];
    if (animations) {
        animations();
    }
}

//消失
- (void)dismissAnimations:(void (^)(void))animations
                 complete:(void (^)(BOOL finished))completion {
    [UIView animateWithDuration:0.3 animations:^{
        [self firstStepAnimation];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            LCE_AppDelegate.window.layer.transform = CATransform3DIdentity;
        } completion:^(BOOL finished) {
            [self resignKeyWindow];
            self.hidden = YES;
        }];
        [UIView animateWithDuration:0.65 animations:^{
            if (animations) {
                animations();
            }
        } completion:^(BOOL finished) {
            if (completion) {
                completion(finished);
            }
        }];
    }];
}

@end
