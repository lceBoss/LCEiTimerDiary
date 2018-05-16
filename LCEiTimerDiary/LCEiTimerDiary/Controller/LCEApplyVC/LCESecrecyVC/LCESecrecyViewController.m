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
#import "LCEAlertRemind.h"

@interface LCESecrecyViewController () <LCESecrecyTableViewCellDelegate>

@property (nonatomic, strong) LCESecrecyAddView *addView;
// 选中的models
@property (nonatomic, strong) NSMutableArray *selectModels;
// 是否编辑
@property (nonatomic, assign) BOOL isEdit;

@end

@implementation LCESecrecyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账户与密码";
    [self.view addSubview:self.lceTableView];
    self.lceTableView.tableHeaderView = self.addView;
    self.isEdit = NO;
    [self setupNavigationItemStatus];
    [self searchAllAccount];
}

#pragma mark - Action
- (void)rightBarItemAddCipher:(UIBarButtonItem *)barItem {
    if (!self.isEdit) {
        self.isEdit = YES;
        [self setupNavigationItemStatus];
        self.navigationItem.leftBarButtonItem.enabled = NO;
        [self.lceTableView setEditing:YES animated:YES];
        
    }else {
        self.isEdit = NO;
        [self setupNavigationItemStatus];
        self.navigationItem.leftBarButtonItem.enabled = YES;
        [self.lceTableView setEditing:NO animated:YES];
        [self.selectModels removeAllObjects];
    }
    [self.lceTableView reloadData];
}

- (void)deleteAccountAndPassword:(UIBarButtonItem *)barItem {
    if (self.isEdit) {
        self.isEdit = NO;
        [self.lceTableView setEditing:NO animated:YES];
        // 按理来说弹出提示框，确认是否删除
        [self showAlertRemind];
    }else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)showAlertRemind {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"您确定要删除所选密码吗？" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"删除"
                                                              style:UIAlertActionStyleDestructive
                                                            handler:^(UIAlertAction *_Nonnull action) {
                                                                [self deleteSelectAccountWithModels:self.selectModels];
                                                            }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                       style:UIAlertActionStyleCancel
                                                     handler:^(UIAlertAction *action) {
//                                                         NSLog(@"点击了取消按钮");
                                                         self.isEdit = YES;
                                                     }];
    [alertController addAction:deleteAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)setupNavigationItemStatus {
    if (self.isEdit) {
        [self.lceTableView reloadData];
        [self addLeftBarItemTitle:@"删除" sel:@selector(deleteAccountAndPassword:)];
        [self addRightBarItemTitle:@"取消" sel:@selector(rightBarItemAddCipher:)];
    }else {
        [self addleftBarItemImageName:@"icon_navi_return" sel:@selector(deleteAccountAndPassword:)];
        [self addRightBarItemTitle:@"编辑" sel:@selector(rightBarItemAddCipher:)];
    }
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
    [self.selectModels removeAllObjects];
    [self setupNavigationItemStatus];
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
        cell.delegate = self;
    }
    cell.isSelect = NO;
    cell.edit = self.lceTableView.editing;
    LCEPasswordModel *pwdModel = self.dataArray[indexPath.row];
    if ([self.selectModels containsObject:pwdModel]) {
        cell.isSelect = YES;
    }
    cell.indexPathRow = indexPath.row;
    cell.accountLabel.text = pwdModel.account;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LCEPasswordModel *model = self.dataArray[indexPath.row];
    LCESecrecyDetailViewController *detailVC = [[LCESecrecyDetailViewController alloc] init];
    detailVC.pwdModel = model;
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleInsert;
}

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    //添加一个删除按钮
    LCE_WS(weakSelf);
    LCEPasswordModel *model = self.dataArray[indexPath.row];
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:(UITableViewRowActionStyleDestructive) title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        [LCEAlertRemind alterWithTitle:@"" message:@"您确定要删除此密码吗？" buttonTitles:@[@"确定", @"取消"] handler:^(NSInteger index, NSString *title) {
            if (index == 0) {
                [weakSelf deleteSelectAccountWithModels:@[model]];
            }
        }];
    }];
    return @[deleteAction];
}

#pragma mark - LCESecrecyTableViewCellDelegate
- (void)secrecyTableViewCell:(LCESecrecyTableViewCell *)cell selectIndex:(NSInteger)index selectStatus:(BOOL)isSelect {
    LCEPasswordModel *pwdModel = self.dataArray[index];
    if (isSelect) {
        [self.selectModels addObject:pwdModel];
    }else {
        [self.selectModels removeObject:pwdModel];
        if (self.selectModels.count <= 0) {
            self.navigationItem.leftBarButtonItem.enabled = NO;
        }
    }
    if (self.selectModels.count != 0) {
        self.navigationItem.leftBarButtonItem.enabled = YES;
    }
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

- (NSMutableArray *)selectModels {
    if (!_selectModels) {
        _selectModels = [NSMutableArray array];
    }
    return _selectModels;
}


@end
