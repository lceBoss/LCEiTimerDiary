//
//  LCEImageSearchTableViewCell.m
//  LCEiTimerDiary
//
//  Created by 妖狐小子 on 2018/5/16.
//  Copyright © 2018年 妖狐小子. All rights reserved.
//

#import "LCEImageSearchTableViewCell.h"
#import "MIPhotoBrowser.h"
#import "KNBImageCollectionViewCell.h"
#import <UIImageView+WebCache.h>
#import "LCESearchImageModel.h"

@interface LCEImageSearchTableViewCell () <UICollectionViewDelegate, UICollectionViewDataSource, MIPhotoBrowserDelegate>

@property (nonatomic, strong) NSIndexPath *imageIndexPath;

@end

@implementation LCEImageSearchTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.imageCollectionView.showsVerticalScrollIndicator = NO;
    self.imageCollectionView.showsHorizontalScrollIndicator = NO;
    self.imageCollectionView.pagingEnabled = NO;
    self.imageCollectionView.scrollEnabled = NO;
    self.imageCollectionView.delegate = self;
    self.imageCollectionView.dataSource = self;
    
    [self.imageCollectionView registerNib:[UINib nibWithNibName:@"KNBImageCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"KNBImageCollectionViewCell"];
    
}

- (void)setListModel:(LCESearchImageModel *)aListModel {
    _listModel = aListModel;
    
    self.titleLabel.text = aListModel.title;
    self.tagLabel.text = aListModel.keyword;
    self.timeLabel.text = aListModel.create_date;
    if (aListModel.searchImages.count == 0) {
        self.imageCollectionView.hidden = YES;
    } else {
        self.imageCollectionView.hidden = NO;
    }
    [self.imageCollectionView reloadData];
}

- (void)setupImageCollectionView {
    if (self.listModel.searchImages.count <= 0) {
        return;
    }
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
//    CGFloat itemWidth = (LCE_SCREEN_WIDTH - 24 - (self.listModel.searchImages.count - 1) * 5) / self.listModel.searchImages.count;
    CGFloat itemWidth = (LCE_SCREEN_WIDTH - 24 - 2 * 5) / 3;
    if (self.listModel.searchImages.count == 1) {
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
    return self.listModel.searchImages.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    KNBImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"KNBImageCollectionViewCell" forIndexPath:indexPath];
    NSString *img_url = self.listModel.searchImages[indexPath.row];
    [cell.articleImageView sd_setImageWithURL:[NSURL URLWithString:img_url] placeholderImage:[UIImage imageNamed:@"icon_placeholder"]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    self.imageIndexPath = indexPath;
    MIPhotoBrowser *photoBrowser = [[MIPhotoBrowser alloc] init];
    photoBrowser.delegate = self;
    photoBrowser.sourceImagesContainerView = collectionView;
    photoBrowser.imageCount = self.listModel.searchImages.count;
    photoBrowser.currentImageIndex = indexPath.row;
    [photoBrowser show];
    
    if (_delegate && [_delegate respondsToSelector:@selector(searchImageTableViewCell:selectCellIndex:imageIndex:)]) {
        [_delegate searchImageTableViewCell:self selectCellIndex:collectionView.tag imageIndex:indexPath.row];
    }
}

#pragma mark - MIPhotoBrowserDelegate
- (UIImage *)photoBrowser:(MIPhotoBrowser *)photoBrowser placeholderImageForIndex:(NSInteger)index{
    UIImage *cachedImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:self.listModel.searchImages[index]];
    return cachedImage;
}
- (UIImageView *)photoBrowserImageViewBrowserForIndex:(NSInteger)index {
    KNBImageCollectionViewCell *cell = (KNBImageCollectionViewCell *)[self.imageCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:self.imageIndexPath.section]];
    return cell.articleImageView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
