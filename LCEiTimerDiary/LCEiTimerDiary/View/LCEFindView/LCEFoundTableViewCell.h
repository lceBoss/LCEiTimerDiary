//
//  KNBFoundTableViewCell.h
//  KenuoTraining
//
//  Created by 妖狐小子 on 16/12/8.
//  Copyright © 2016年 Robert. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LCENewArticleListModel;
@class LCEFoundTableViewCell;

@protocol LCEFoundTableViewCellDelegate <NSObject>

- (void)foundTableViewCell:(LCEFoundTableViewCell *)cell selectIndex:(NSInteger)index;

@end


@interface LCEFoundTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UICollectionView *imageCollectionView;

@property (nonatomic, strong) LCENewArticleListModel *listModel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentNumLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *askLabelLeftConstraint;
@property (weak, nonatomic) IBOutlet UILabel *stickLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;

@property (nonatomic, weak) id<LCEFoundTableViewCellDelegate> delegate;

- (void)setupImageCollectionView;

@end
