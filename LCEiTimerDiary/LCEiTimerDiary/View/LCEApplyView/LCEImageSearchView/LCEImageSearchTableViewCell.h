//
//  LCEImageSearchTableViewCell.h
//  LCEiTimerDiary
//
//  Created by 妖狐小子 on 2018/5/16.
//  Copyright © 2018年 妖狐小子. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LCESearchImageModel;
@class LCEImageSearchTableViewCell;

@protocol LCEImageSearchTableViewCellDelegate <NSObject>
- (void)searchImageTableViewCell:(LCEImageSearchTableViewCell *)cell selectCellIndex:(NSInteger)cellIndex imageIndex:(NSInteger)imageIndex;
@end

@interface LCEImageSearchTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *imageCollectionView;
@property (weak, nonatomic) IBOutlet UILabel *tagLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (nonatomic, weak) id<LCEImageSearchTableViewCellDelegate> delegate;

@property (nonatomic, strong) LCESearchImageModel *listModel;

- (void)setupImageCollectionView;

@end
