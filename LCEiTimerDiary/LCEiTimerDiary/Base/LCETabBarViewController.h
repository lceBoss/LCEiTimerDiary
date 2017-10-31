//
//  LCETabBarViewController.h
//  LCEiTimerDiary
//
//  Created by 妖狐小子 on 2017/9/26.
//  Copyright © 2017年 妖狐小子. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCEHomeViewController.h"
#import "LCEMeViewController.h"

typedef void (^LCETabBarViewCurrentSelectIndexBlock)(NSInteger index);

@interface LCETabBarViewController : UITabBarController
//首页
@property (nonatomic, strong) LCEHomeViewController *homeVC;
//我的
@property (nonatomic, strong) LCEMeViewController *meVC;

@property (nonatomic, copy) LCETabBarViewCurrentSelectIndexBlock selectBlock;

- (void)turnToControllerIndex:(int)index;

/**
 *  显示未读角标
 */
- (void)showIconImage:(BOOL)show;

@end
