//
//  LCEMeViewController.m
//  LCEiTimerDiary
//
//  Created by 妖狐小子 on 2017/10/31.
//  Copyright © 2017年 妖狐小子. All rights reserved.
//

#import "LCEMeViewController.h"
#import "LCEMeSettingViewController.h"
#import "LCEChooseSpecView.h"
#import "LCEGoodsMaskWindow.h"

@interface LCEMeViewController ()<LCEChooseSpecViewDelegate>

@property (nonatomic, strong) UIButton *selectSpecBtn;

@property (nonatomic, strong) LCEGoodsMaskWindow *maskWindow;
@property (nonatomic, strong) LCEChooseSpecView *specChooseView;

@end

@implementation LCEMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的";
    [self.view addSubview:self.selectSpecBtn];
    [self addRightBarItemImageName:@"icon_navi_setup" sel:@selector(rightBarItemAction:)];
    [self updateViewConstraints];
}

- (void)rightBarItemAction:(UIBarButtonItem *)rightItem {
    LCEMeSettingViewController *meSettingVC = [[LCEMeSettingViewController alloc] init];
    [self.navigationController pushViewController:meSettingVC animated:YES];
}

- (void)clickSelectSpecButtonAction:(UIButton *)sender {
    [self presentAnimation:YES];
}

// 套餐选择
- (void)presentAnimation:(BOOL)specChose {
    LCE_WS(weakSelf);
//    [self.specChooseView setupSpecs:self.goodsDetailModel.specs goodsSpecsList:self.goodsDetailModel.goodsSkuList];
    [self.maskWindow presentAnimations:^{
        if (specChose) {
            [weakSelf.maskWindow addSubview:weakSelf.specChooseView];
            [weakSelf.specChooseView showChoseView:YES];
        }
    } view:self.view];
}
//选择套餐 消失
- (void)dismissAnimation:(BOOL)specChose complete:(void (^)(void))complete {
    LCE_WS(weakSelf);
    [self.maskWindow dismissAnimations:^{
        [weakSelf.specChooseView showChoseView:NO];
    } complete:^(BOOL finished) {
        if (specChose) {
            [weakSelf.specChooseView removeFromSuperview];
            weakSelf.specChooseView = nil;
        }
        if (complete) {
            complete();
        }
    }];
}

#pragma mark - LCEChooseSpecViewDelegate
- (void)chooseSpecView:(LCEChooseSpecView *)view {
    [self dismissAnimation:YES complete:^{
        
    }];
}

- (void)updateViewConstraints {
    LCE_WS(weakSelf);
    [self.selectSpecBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(40);
        make.centerY.mas_equalTo(weakSelf.view.mas_centerY).offset(0);
    }];
    [super updateViewConstraints];
}

- (UIButton *)selectSpecBtn {
    if (!_selectSpecBtn) {
        _selectSpecBtn = [[UIButton alloc] init];
        _selectSpecBtn.backgroundColor = [UIColor blueColor];
        [_selectSpecBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [_selectSpecBtn setTitle:@"选择商品规格" forState:UIControlStateNormal];
        [_selectSpecBtn addTarget:self action:@selector(clickSelectSpecButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectSpecBtn;
}

- (LCEChooseSpecView *)specChooseView {
    if (!_specChooseView) {
        _specChooseView = [LCEChooseSpecView createChooseView];
        _specChooseView.delegate = self;
    }
    return _specChooseView;
}

- (LCEGoodsMaskWindow *)maskWindow {
    if (!_maskWindow) {
        _maskWindow = [[LCEGoodsMaskWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    return _maskWindow;
}

@end
