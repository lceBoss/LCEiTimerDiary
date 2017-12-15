//
//  KNBImageCollectionViewCell.m
//  KenuoTraining
//
//  Created by 妖狐小子 on 16/12/9.
//  Copyright © 2016年 Robert. All rights reserved.
//

#import "KNBImageCollectionViewCell.h"


@implementation KNBImageCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.articleImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.articleImageView.clipsToBounds = YES;
}

@end
