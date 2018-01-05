//
//  LCESecrecyAddView.m
//  LCEiTimerDiary
//
//  Created by 妖狐小子 on 2018/1/4.
//  Copyright © 2018年 妖狐小子. All rights reserved.
//

#import "LCESecrecyAddView.h"

@interface LCESecrecyAddView ()

@property (nonatomic, strong) UIButton *addButton;

@end

@implementation LCESecrecyAddView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configureView];
    }
    return self;
}

- (void)configureView {
    [self addSubview:self.addButton];
}

#pragma mark - Layout

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)updateConstraints {
    LCE_WS(weakSelf);
    [self.addButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf);
        make.centerX.mas_equalTo(weakSelf);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    [super updateConstraints];
}

#pragma mark - Setter

- (UIButton *)addButton {
    if (!_addButton) {
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addButton setBackgroundImage:[UIImage imageNamed:@"icon_apply_frozen"] forState:UIControlStateNormal];
        [_addButton addTarget:self action:@selector(clickAddButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addButton;
}

#pragma mark - Action

- (void)clickAddButton:(UIButton *)sender {
    if (self.addBlock) {
        self.addBlock();
    }
}


@end
