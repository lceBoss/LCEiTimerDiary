//
//  LCEApplyViewController.m
//  LCEiTimerDiary
//
//  Created by 妖狐小子 on 2017/11/1.
//  Copyright © 2017年 妖狐小子. All rights reserved.
//

#import "LCEApplyViewController.h"
#import <UIImageView+WebCache.h>
#import "LCEApplyCollectionViewCell.h"
#import "LCESecrecyViewController.h"

static NSString *LCEApplyViewIdentifer = @"LCEApplyCollectionViewCell";

@interface LCEApplyViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *collectionViewFlowLayout;

@end

@implementation LCEApplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"应用";
    [self.view addSubview:self.collectionView];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"LCEApply" ofType:@"plist"];
    NSArray *applyArray = [[NSArray alloc] initWithContentsOfFile:filePath];
    [self.dataArray addObjectsFromArray:applyArray];
    
    NSInteger rowNums = ceilf(self.dataArray.count / 4.0); //向上取整
    self.collectionView.frame = CGRectMake(0, 64, LCE_SCREEN_WIDTH, rowNums * 80);
    [self.collectionView reloadData];
    
}

#pragma mark - UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LCEApplyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:LCEApplyViewIdentifer forIndexPath:indexPath];
    
    NSDictionary *info = self.dataArray[indexPath.row];
    cell.itemLabel.text = info[@"type_title"];
    NSString *iconStr = info[@"icon"];
    if ([iconStr hasPrefix:@"http"] || isNullStr(iconStr)) {
        [cell.itemImageView sd_setImageWithURL:[NSURL URLWithString:iconStr] placeholderImage:[UIImage imageNamed:@"icon_default_placeholder"]];
    } else {
        cell.itemImageView.image = [UIImage imageNamed:info[@"icon"]];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *info = self.dataArray[indexPath.row];
    Class cls = NSClassFromString(info[@"controller_name"]);
    UIViewController *controller = [[cls alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark---- Setter && Getter
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, LCE_SCREEN_WIDTH, LCE_SCREEN_HEIGHT - 64 - 49) collectionViewLayout:self.collectionViewFlowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerNib:[UINib nibWithNibName:LCEApplyViewIdentifer bundle:nil] forCellWithReuseIdentifier:LCEApplyViewIdentifer];
    }
    return _collectionView;
}

- (UICollectionViewFlowLayout *)collectionViewFlowLayout {
    if (!_collectionViewFlowLayout) {
        _collectionViewFlowLayout = [[UICollectionViewFlowLayout alloc] init];
        _collectionViewFlowLayout.itemSize = CGSizeMake((LCE_SCREEN_WIDTH - 3) / 4, 80);
        _collectionViewFlowLayout.minimumInteritemSpacing = 0;
        _collectionViewFlowLayout.minimumLineSpacing = 0;
        _collectionViewFlowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _collectionViewFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    }
    return _collectionViewFlowLayout;
}


@end
