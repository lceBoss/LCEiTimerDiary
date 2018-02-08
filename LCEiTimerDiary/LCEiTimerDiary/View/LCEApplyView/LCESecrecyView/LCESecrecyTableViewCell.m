//
//  LCESecrecyTableViewCell.m
//  LCEiTimerDiary
//
//  Created by 妖狐小子 on 2018/1/9.
//  Copyright © 2018年 妖狐小子. All rights reserved.
//

#import "LCESecrecyTableViewCell.h"

@implementation LCESecrecyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setEdit:(BOOL)aEdit {
    _edit = aEdit;
    if (aEdit) {//选中
        self.selectBtn.hidden = NO;
        self.leftLayoutConstraint.constant = 45;
    }else {
        self.selectBtn.selected = NO;
        self.selectBtn.hidden = YES;
        self.leftLayoutConstraint.constant = 12;
    }
}

- (void)setIsSelect:(BOOL)aIsSelect {
    _isSelect = aIsSelect;
    self.selectBtn.selected = aIsSelect;
}

- (void)setIndexPathRow:(NSInteger)indexPathRow {
    if (_indexPathRow != indexPathRow) {
        _indexPathRow = indexPathRow;
    }
}

- (IBAction)clickSelectButtonAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (_delegate && [_delegate respondsToSelector:@selector(secrecyTableViewCell:selectIndex:selectStatus:)]) {
        [_delegate secrecyTableViewCell:self selectIndex:self.indexPathRow selectStatus:sender.selected];
    }
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
