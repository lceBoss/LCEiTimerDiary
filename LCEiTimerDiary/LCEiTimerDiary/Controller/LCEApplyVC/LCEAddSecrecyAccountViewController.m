//
//  LCEAddSecrecyAccountViewController.m
//  LCEiTimerDiary
//
//  Created by 妖狐小子 on 2018/1/5.
//  Copyright © 2018年 妖狐小子. All rights reserved.
//

#import "LCEAddSecrecyAccountViewController.h"
#import "LCEAddSecrecyAccountTableViewCell.h"

@interface LCEAddSecrecyAccountViewController ()

@end

@implementation LCEAddSecrecyAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加账号";
    [self addLeftBarItemTitle:@"取消" sel:@selector(clickCancelAddAccount:)];
    [self addRightBarItemTitle:@"保存" sel:@selector(clickSaveAddAccount:)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    [self.view addSubview:self.lceTableView];
}

#pragma mark - Action
// 取消
- (void)clickCancelAddAccount:(UIBarButtonItem *)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
// 保存
- (void)clickSaveAddAccount:(UIBarButtonItem *)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITableViewDataSource && Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LCEAddSecrecyAccountTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LCEAddSecrecyAccountTableViewCell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"LCEAddSecrecyAccountTableViewCell" owner:self options:nil] firstObject];
    }
    if (indexPath.row == 0) {
        cell.titleLabel.text = @"用户";
        cell.contentTextField.placeholder = @"账号";
    }else if (indexPath.row == 1) {
        cell.titleLabel.text = @"密码";
        cell.contentTextField.placeholder = @"密码";
    }
    return cell;
}

@end
