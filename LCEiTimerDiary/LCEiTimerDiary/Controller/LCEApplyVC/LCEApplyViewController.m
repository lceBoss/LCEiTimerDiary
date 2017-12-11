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
#import "LCEAuthManage.h"

static NSString *LCEApplyViewIdentifer = @"LCEApplyCollectionViewCell";
static CGFloat lceCollectionViewCellHeight = 85;

@interface LCEApplyViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, LCEAuthManageDelegate>

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
    self.collectionView.frame = CGRectMake(0, 64, LCE_SCREEN_WIDTH, rowNums * lceCollectionViewCellHeight);
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
    NSString *name = info[@"controller_name"];
    Class cls = NSClassFromString(name);
    if ([name isEqualToString:@"LCESecrecyViewController"]) { //项目top10
        [[LCEAuthManage shareInstance] startAuthenticateWithDelegate:self];
        return;
    }
    UIViewController *controller = [[cls alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - LCEAuthManageDelegate
- (void)authManageVerifyByFingerprintWithAuthResult:(LCEAuthManageResult)result {
    if (result == LCEAuthManageResultSuccess) {
        NSLog(@"what the fuck！")
    }else if (result == LCEAuthManageResultUserFallback) {
        NSLog(@"用户选择忘记密码");
    }
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
        _collectionViewFlowLayout.itemSize = CGSizeMake((LCE_SCREEN_WIDTH - 3) / 4, lceCollectionViewCellHeight);
        _collectionViewFlowLayout.minimumInteritemSpacing = 0;
        _collectionViewFlowLayout.minimumLineSpacing = 0;
        _collectionViewFlowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _collectionViewFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    }
    return _collectionViewFlowLayout;
}


@end
