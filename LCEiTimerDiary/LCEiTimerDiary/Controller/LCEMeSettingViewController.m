//
//  LCEMeSettingViewController.m
//  LCEiTimerDiary
//
//  Created by 妖狐小子 on 2017/10/31.
//  Copyright © 2017年 妖狐小子. All rights reserved.
//

#import "LCEMeSettingViewController.h"

@interface LCEMeSettingViewController ()

@end

@implementation LCEMeSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的设置";
    [self.view addSubview:self.lceTableView];
}

#pragma UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = @"妖狐小子";
    return cell;
}

@end
