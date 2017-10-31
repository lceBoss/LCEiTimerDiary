//
//  LCEMeViewController.m
//  LCEiTimerDiary
//
//  Created by 妖狐小子 on 2017/10/31.
//  Copyright © 2017年 妖狐小子. All rights reserved.
//

#import "LCEMeViewController.h"
#import "LCEMeSettingViewController.h"

@interface LCEMeViewController ()

@end

@implementation LCEMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的";
    [self addRightBarItemImageName:@"icon_navi_setup" sel:@selector(rightBarItemAction:)];
}

- (void)rightBarItemAction:(UIBarButtonItem *)rightItem {
    LCEMeSettingViewController *meSettingVC = [[LCEMeSettingViewController alloc] init];
    [self.navigationController pushViewController:meSettingVC animated:YES];
}

@end
