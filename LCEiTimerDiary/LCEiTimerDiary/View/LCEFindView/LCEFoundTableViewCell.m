//
//  KNBFoundTableViewCell.m
//  KenuoTraining
//
//  Created by 妖狐小子 on 16/12/8.
//  Copyright © 2016年 Robert. All rights reserved.
//

#import "LCEFoundTableViewCell.h"
#import "LCENewArticleListModel.h"
#import "KNBImageCollectionViewCell.h"
#import <UIImageView+WebCache.h>
#import "MIPhotoBrowser.h"


@interface LCEFoundTableViewCell () <UICollectionViewDelegate, UICollectionViewDataSource, MIPhotoBrowserDelegate>

@end


@implementation LCEFoundTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.imageCollectionView.showsVerticalScrollIndicator = NO;
    self.imageCollectionView.showsHorizontalScrollIndicator = NO;
    self.imageCollectionView.pagingEnabled = NO;
    self.imageCollectionView.scrollEnabled = NO;
    self.imageCollectionView.delegate = self;
    self.imageCollectionView.dataSource = self;

    [self.imageCollectionView registerNib:[UINib nibWithNibName:@"KNBImageCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"KNBImageCollectionViewCell"];
}

- (void)setListModel:(LCENewArticleListModel *)aListModel {
    _listModel = aListModel;

//    [KNBNewArticleListModel headImageView:self.headView.headImageView urlString:aListModel.user_photo];
//    self.headView.levImageView.image = [UIImage imageNamed:aListModel.userTypeIcon];
//
//    self.nameLabel.text = aListModel.user_name;
//    NSDate *date = [NSDate transformDateStr:aListModel.create_date];
//    NSString *dateString = [NSDate transformDate:date dateFormat:@"MM-dd HH:mm"];
//    self.timeLabel.text = dateString;
//    self.titleLabel.text = [aListModel.title stringByConvertingHTMLToPlainText];
//    self.titleLabel.numberOfLines = 2;
//    self.commentNumLabel.text = [NSString stringWithFormat:@"%@", @(aListModel.comm_num ? aListModel.comm_num : 0)];
//    self.stickLabel.hidden = aListModel.is_top;
//    self.askLabelLeftConstraint.constant = aListModel.is_top == 0 ? 62 : 12;
//    self.categoryLabel.text = aListModel.cate_name;

    if (aListModel.articleImages.count == 0) {
        self.imageCollectionView.hidden = YES;
    } else {
        self.imageCollectionView.hidden = NO;
    }
    [self.imageCollectionView reloadData];
}

- (void)setupImageCollectionView {
    if (self.listModel.contentslist.count <= 0) {
        return;
    }
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat itemWidth = (LCE_SCREEN_WIDTH - 24 - (self.listModel.contentslist.count - 1) * 5) / self.listModel.contentslist.count;
    if (self.listModel.contentslist.count == 1) {
        flowLayout.itemSize = CGSizeMake(itemWidth, itemWidth * 340 / 702);
    } else {
        flowLayout.itemSize = CGSizeMake(itemWidth, itemWidth);
    }
    flowLayout.minimumLineSpacing = 5;
    flowLayout.minimumInteritemSpacing = 0;

    [self.imageCollectionView setCollectionViewLayout:flowLayout];
}

#pragma-- UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.listModel.articleImages.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    KNBImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"KNBImageCollectionViewCell" forIndexPath:indexPath];
    NSString *img_url = self.listModel.contentslist[indexPath.row];
    [cell.articleImageView sd_setImageWithURL:[NSURL URLWithString:img_url] placeholderImage:[UIImage imageNamed:@"icon_tabbar_apply_no"]];

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MIPhotoBrowser *photoBrowser = [[MIPhotoBrowser alloc] init];
    photoBrowser.delegate = self;
    photoBrowser.sourceImagesContainerView = collectionView;
    photoBrowser.imageCount = self.listModel.contentslist.count;
    photoBrowser.currentImageIndex = indexPath.row;
    [photoBrowser show];
    
    if (_delegate && [_delegate respondsToSelector:@selector(foundTableViewCell:selectCellIndex:imageIndex:)]) {
        [_delegate foundTableViewCell:self selectCellIndex:collectionView.tag imageIndex:indexPath.row];
    }
}

#pragma mark - MIPhotoBrowserDelegate
- (UIImage *)photoBrowser:(MIPhotoBrowser *)photoBrowser placeholderImageForIndex:(NSInteger)index{
    
    //    NSLog(@"photobrowser index = %d", index);
    UIImage *cachedImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:self.listModel.contentslist[index]];
    NSLog(@"index:%@", @(index));
    
    return cachedImage;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
