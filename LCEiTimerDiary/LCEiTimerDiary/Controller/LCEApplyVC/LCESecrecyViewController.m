//
//  LCESecrecyViewController.m
//  LCEiTimerDiary
//
//  Created by 妖狐小子 on 2017/11/6.
//  Copyright © 2017年 妖狐小子. All rights reserved.
//

#import "LCESecrecyViewController.h"

@interface LCESecrecyViewController ()

@end

@implementation LCESecrecyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账户与密码";
    [self.view addSubview:self.lceTableView];
    [self addRightBarItemTitle:@"编辑" sel:@selector(rightBarItemAddCipher)];
}

#pragma mark - Action
- (void)rightBarItemAddCipher {
    
}

#pragma mark - UITableViewCellDataSource & Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = @"妖狐小子";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


@end
