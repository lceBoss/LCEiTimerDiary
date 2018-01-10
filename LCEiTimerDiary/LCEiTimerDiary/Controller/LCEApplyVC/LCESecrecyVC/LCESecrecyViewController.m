//
//  LCESecrecyViewController.m
//  LCEiTimerDiary
//
//  Created by 妖狐小子 on 2017/11/6.
//  Copyright © 2017年 妖狐小子. All rights reserved.
//

#import "LCESecrecyViewController.h"
#import "LCEPasswordModel.h"
#import "LCESecrecyAddView.h"
#import "LCEAddSecrecyAccountViewController.h"
#import "LCENavigationController.h"
#import <LCProgressHUD.h>
#import "LCESecrecyTableViewCell.h"
#import "LCESecrecyDetailViewController.h"

@interface LCESecrecyViewController ()

@property (nonatomic, strong) LCESecrecyAddView *addView;

@end

@implementation LCESecrecyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账户与密码";
    [self.view addSubview:self.lceTableView];
    self.lceTableView.tableHeaderView = self.addView;
    [self addRightBarItemTitle:@"编辑" sel:@selector(rightBarItemAddCipher)];
    [self searchAllAccount];
}

#pragma mark - Action
- (void)rightBarItemAddCipher {
    
}

- (void)searchAllAccount {
    NSArray *dataArray = [LCEPasswordModel searchAll];
    [self.dataArray removeAllObjects];
    [self.dataArray addObjectsFromArray:dataArray];
    [self showRefreshAnimation];
    [self.lceTableView reloadData];
}

- (void)deleteSelectAccountWithModels:(NSArray *)models {
    for (LCEPasswordModel *model in models) {
        NSArray *result = [LCEPasswordModel search];
        NSInteger index = [self.dataArray indexOfObject:model];
        [LCEPasswordModel deleteWithModel:result[index]];
        [self.dataArray removeObjectAtIndex:index];
    }
    [self showRefreshAnimation];
    [self.lceTableView reloadData];
}

- (void)showRefreshAnimation {
    [LCProgressHUD showLoading:@""];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [LCProgressHUD hide];
    });
}


#pragma mark - UITableViewCellDataSource & Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LCESecrecyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LCESecrecyTableViewCell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"LCESecrecyTableViewCell" owner:self options:nil] firstObject];
    }
    LCEPasswordModel *pwdModel = self.dataArray[indexPath.row];
    cell.accountLabel.text = pwdModel.account;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LCEPasswordModel *model = self.dataArray[indexPath.row];
    LCESecrecyDetailViewController *detailVC = [[LCESecrecyDetailViewController alloc] init];
    detailVC.pwdModel = model;
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    //添加一个删除按钮
    LCEPasswordModel *model = self.dataArray[indexPath.row];
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:(UITableViewRowActionStyleDestructive) title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        [self deleteSelectAccountWithModels:@[model]];
    }];
    return @[deleteAction];
}

#pragma mark - Setter

- (LCESecrecyAddView *)addView {
    if (!_addView) {
        _addView = [[LCESecrecyAddView alloc] initWithFrame:CGRectMake(0, 0, LCE_SCREEN_WIDTH, 90)];
        LCE_WS(weakSelf);
        _addView.addBlock = ^{
            LCEAddSecrecyAccountViewController *addSecrecyVC = [[LCEAddSecrecyAccountViewController alloc] init];
            LCENavigationController *navi = [[LCENavigationController alloc] initWithRootViewController:addSecrecyVC];
            addSecrecyVC.refreshBlock = ^{
                [weakSelf searchAllAccount];
            };
            [weakSelf.navigationController presentViewController:navi animated:YES completion:nil];
        };
    }
    return _addView;
}


@end
