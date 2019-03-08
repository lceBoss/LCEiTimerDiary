//
//  LCEMeSettingViewController.m
//  LCEiTimerDiary
//
//  Created by 妖狐小子 on 2017/10/31.
//  Copyright © 2017年 妖狐小子. All rights reserved.
//

#import "LCEMeSettingViewController.h"
#import "LCEMeSettingTableViewCell.h"

@interface LCEMeSettingViewController ()

@end

@implementation LCEMeSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    [self.view addSubview:self.lceTableView];
}

#pragma UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LCEMeSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LCEMeSettingTableViewCell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"LCEMeSettingTableViewCell" owner:self options:nil] firstObject];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

@end
