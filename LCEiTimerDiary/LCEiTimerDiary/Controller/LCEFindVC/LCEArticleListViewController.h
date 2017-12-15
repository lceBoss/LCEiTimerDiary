//
//  KNBArticleListViewController.h
//  KenuoTraining
//
//  Created by 妖狐小子 on 2017/1/15.
//  Copyright © 2017年 Robert. All rights reserved.
//

#import "LCEBaseViewController.h"
#import "LCEArticleCategoryModel.h"

@class KNBNewArticleModel;


@interface LCEArticleListViewController : LCEBaseViewController

@property (nonatomic, strong) LCEArticleCategoryModel *categoryModel; //分类model

@end
