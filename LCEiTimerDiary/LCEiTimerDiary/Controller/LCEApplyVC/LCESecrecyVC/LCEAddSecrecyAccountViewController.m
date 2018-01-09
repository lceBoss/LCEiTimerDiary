//
//  LCEAddSecrecyAccountViewController.m
//  LCEiTimerDiary
//
//  Created by 妖狐小子 on 2018/1/5.
//  Copyright © 2018年 妖狐小子. All rights reserved.
//

#import "LCEAddSecrecyAccountViewController.h"
#import "LCEAddSecrecyAccountTableViewCell.h"
#import "LCEPasswordModel.h"

@interface LCEAddSecrecyAccountViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) NSString *accountText;
@property (nonatomic, strong) NSString *passwordText;

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
    [self.view endEditing:YES];
    LCEPasswordModel *model = [[LCEPasswordModel alloc] init];
    model.account = self.accountText;
    model.password = self.passwordText;
    LCE_WS(weakSelf);
    [LCEPasswordModel saveWithModel:model resultBlock:^(BOOL success) {
        if (success) {
            if (weakSelf.refreshBlock) {
                weakSelf.refreshBlock();
            }
            [weakSelf.navigationController dismissViewControllerAnimated:YES completion:nil];
        }
    }];
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
    cell.contentTextField.delegate = self;
    if (indexPath.row == 0) {
        cell.titleLabel.text = @"用户";
        cell.contentTextField.placeholder = @"账号";
        cell.contentTextField.tag = indexPath.row;
    }else if (indexPath.row  == 1) {
        cell.titleLabel.text = @"密码";
        cell.contentTextField.placeholder = @"密码";
        cell.contentTextField.tag = indexPath.row;
    }
    return cell;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField.tag == 0) {
        self.accountText = [NSString stringWithFormat:@"%@%@", textField.text, string];
    }else {
        self.passwordText = [NSString stringWithFormat:@"%@%@", textField.text, string];
    }
    BOOL isDelToNull = range.location == 0 && [string isEqualToString:@""];
    if (isNullStr(self.accountText) || isNullStr(self.passwordText) || isDelToNull) {
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }else {
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }
    return YES;
}


@end
