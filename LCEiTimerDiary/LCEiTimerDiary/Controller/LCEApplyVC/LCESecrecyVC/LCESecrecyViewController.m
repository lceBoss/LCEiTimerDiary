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
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [LCProgressHUD hide];
    });
    
    [self.lceTableView reloadData];
}

#pragma mark - UITableViewCellDataSource & Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    LCEPasswordModel *pwdModel = self.dataArray[indexPath.row];
    cell.textLabel.text = pwdModel.account;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
                [LCProgressHUD showLoading:@""];
                [weakSelf searchAllAccount];
            };
            [weakSelf.navigationController presentViewController:navi animated:YES completion:nil];
        };
    }
    return _addView;
}


@end
