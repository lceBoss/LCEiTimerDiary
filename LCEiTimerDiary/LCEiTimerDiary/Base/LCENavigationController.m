//
//  LCENavigationController.m
//  LCEiTimerDiary
//
//  Created by 妖狐小子 on 2017/9/26.
//  Copyright © 2017年 妖狐小子. All rights reserved.
//

#import "LCENavigationController.h"

@interface LCENavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation LCENavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    LCE_WS(weakSelf);
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = weakSelf;
    }
}

// 重写preferredStatusBarStyle设置状态栏字体颜色为白色
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}


@end
