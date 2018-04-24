//
//  LCENavigationController.m
//  LCEiTimerDiary
//
//  Created by 妖狐小子 on 2017/9/26.
//  Copyright © 2017年 妖狐小子. All rights reserved.
//

#import "LCENavigationController.h"
#import "LCEBaseViewController.h"

@interface LCENavigationController ()<UIGestureRecognizerDelegate, UINavigationControllerDelegate>

@end

@implementation LCENavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    LCE_WS(weakSelf);
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = weakSelf;
        self.delegate = weakSelf;
    }
}

// 重写preferredStatusBarStyle设置状态栏字体颜色为白色
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animate {
    // Enable the gesture again once the new controller is shown
    if (navigationController.childViewControllers.count < 2) {
        // tabBarViewController 根视图 关闭左滑手势
        self.interactivePopGestureRecognizer.enabled = NO;
    }else {
        self.interactivePopGestureRecognizer.enabled = YES;
    }
}


@end
