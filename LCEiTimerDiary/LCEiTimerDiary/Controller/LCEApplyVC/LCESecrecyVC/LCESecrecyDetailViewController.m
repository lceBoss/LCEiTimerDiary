//
//  LCESecrecyDetailViewController.m
//  LCEiTimerDiary
//
//  Created by 妖狐小子 on 2018/1/10.
//  Copyright © 2018年 妖狐小子. All rights reserved.
//

#import "LCESecrecyDetailViewController.h"
#import "LCEAddSecrecyAccountTableViewCell.h"
#import "LCEPasswordModel.h"

@interface LCESecrecyDetailViewController ()

@end

@implementation LCESecrecyDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账号详情";
    [self.view addSubview:self.lceTableView];
}

#pragma mark - UITableViewDataSource && Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LCEAddSecrecyAccountTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LCEAddSecrecyAccountTableViewCell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"LCEAddSecrecyAccountTableViewCell" owner:self options:nil] firstObject];
        cell.contentTextField.userInteractionEnabled = NO;
    }
    if (indexPath.row == 0) {
        cell.titleLabel.text = @"用户";
        cell.contentTextField.tag = indexPath.row;
        cell.contentTextField.text = self.pwdModel.account;
    }else if (indexPath.row  == 1) {
        cell.titleLabel.text = @"密码";
        cell.contentTextField.tag = indexPath.row;
        cell.contentTextField.text = self.pwdModel.password;
    }
    return cell;
}


@end
