//
//  KNBNewArticleListModel.h
//  KenuoTraining
//
//  Created by 妖狐小子 on 16/12/12.
//  Copyright © 2016年 Robert. All rights reserved.
//

#import "LCEBaseModel.h"


@interface LCENewArticleListModel : LCEBaseModel

@property (nonatomic, copy) NSArray *contentslist; // 文章图集


/**
 文章图片
 */

- (NSArray *)articleImages;

@end
