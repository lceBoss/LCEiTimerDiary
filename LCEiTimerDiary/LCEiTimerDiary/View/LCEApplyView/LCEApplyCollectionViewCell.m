//
//  LCEApplyCollectionViewCell.m
//  LCEiTimerDiary
//
//  Created by 妖狐小子 on 2017/11/7.
//  Copyright © 2017年 妖狐小子. All rights reserved.
//

#import "LCEApplyCollectionViewCell.h"

@implementation LCEApplyCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.itemImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.itemImageView.clipsToBounds = YES;
}

@end
