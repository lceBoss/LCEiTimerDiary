//
//  KNBArticleListViewController.m
//  KenuoTraining
//
//  Created by 妖狐小子 on 2017/1/15.
//  Copyright © 2017年 Robert. All rights reserved.
//

#import "LCEArticleListViewController.h"
#import <UIImageView+WebCache.h>
#import "LCEArticleDataManager.h"
#import "LCEFoundTableViewCell.h"
#import "KNBImageCollectionViewCell.h"
#import "LCENewArticleListModel.h"
#import "SDCycleScrollView.h"
#import "VTMagic.h"
#import <SDWebImage/SDImageCache.h>


@interface LCEArticleListViewController () <SDCycleScrollViewDelegate, LCEFoundTableViewCellDelegate>

@property (nonatomic, strong) NSMutableArray *advertImageArray; // advert图片地址url
@property (nonatomic, strong) NSMutableArray *advertUrlArray;   // advert链接url
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;
@property (nonatomic, strong) NSMutableArray *articleImageArrs;

@end


@implementation LCEArticleListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.lceTableView.frame = CGRectMake(0, 0, LCE_SCREEN_WIDTH, LCE_SCREEN_HEIGHT - LCE_TAB_HEIGHT - LCE_NAV_HEIGHT - 44);
    [self.view addSubview:self.lceTableView];
    self.lceTableView.backgroundColor = [UIColor whiteColor];
    [self.advertImageArray removeAllObjects];
    [self.advertUrlArray removeAllObjects];
    [self.advertImageArray addObjectsFromArray:@[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1513333172339&di=82765ca8d13400de64983e98f8bd6c5e&imgtype=0&src=http%3A%2F%2Fimage.cnwest.com%2Fattachement%2Fjpg%2Fsite1%2F20151107%2F001372d89ff017a7c0752f.jpg", @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1513333316917&di=51bc8be08b3dc6c0772684f6521de61d&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2F48540923dd54564eb2c1a903b8de9c82d1584f67.jpg", @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1513334071292&di=8ff43ed352bc47b8f5ecc7464d9e9a96&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimage%2Fc0%253Dshijue1%252C0%252C0%252C294%252C40%2Fsign%3D890c50c9db00baa1ae214ff82f79d367%2Fcc11728b4710b912decd6bdbc9fdfc0392452282.jpg"]];
    [self.advertUrlArray addObjectsFromArray:@[@"", @"", @""]];
    self.lceTableView.tableHeaderView = self.cycleScrollView;
//    LCE_WS(weakSelf);
//    [self addMJRefreshFootView:^(NSInteger page) {
//        [weakSelf requestArticleListWithCategoryId:weakSelf.categoryModel.category_id withPage:page];
//    }];
//    [self addMJRefreshHeadView:^(NSInteger page) {
//        [weakSelf requestArticleListWithCategoryId:weakSelf.categoryModel.category_id withPage:1];
//    }];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self refreshPageIfNeeded];
    self.lceTableView.scrollsToTop = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.lceTableView.scrollsToTop = NO;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self savePageInfo];
}

#pragma mark---- UITableViewDelegate && UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LCEFoundTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LCEFoundTableViewCell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"LCEFoundTableViewCell" owner:self options:nil] lastObject];
        cell.delegate = self;
    }
    cell.imageCollectionView.tag = indexPath.row;
    LCENewArticleListModel *listModel = self.dataArray[indexPath.row];
    cell.listModel = listModel;
    [self.articleImageArrs removeAllObjects];
    [self.articleImageArrs addObjectsFromArray:listModel.contentslist];
    //文章图片
    [cell setupImageCollectionView]; //设置图片collectionview的布局
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.articleImageArrs.count == 0) {
        return 125;
    } else if (self.articleImageArrs.count == 1) {
        return LCE_SCREEN_WIDTH * 340 / 702 + 120;
    } else if (self.articleImageArrs.count == 2) {
        return (LCE_SCREEN_WIDTH - 24 - 5) / 2 + 125;
    } else {
        return (LCE_SCREEN_WIDTH - 24 - 2 * 5) / 3 + 125;
    }
}

#pragma mark - LCEFoundTableViewCellDelegate
- (void)foundTableViewCell:(LCEFoundTableViewCell *)cell selectCellIndex:(NSInteger)cellIndex imageIndex:(NSInteger)imageIndex {
    
    
    NSLog(@"点击了第%@行，第%@张图片", @(cellIndex), @(imageIndex));

}

#pragma mark---- SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    

}


#pragma mark - VTMagicReuseProtocol
- (void)vtm_prepareForReuse
{
    // reset content offset
    [self.dataArray removeAllObjects];
    [self.lceTableView reloadData];
    [self.lceTableView setContentOffset:CGPointZero];
}

- (void)refreshPageIfNeeded
{
    NSTimeInterval currentStamp = [[NSDate date] timeIntervalSince1970];
    if (self.dataArray.count && currentStamp - _categoryModel.lastTime < 60 * 60) {
        return;
    }
    [self requestArticleListWithCategoryId:self.categoryModel.category_id withPage:self.requestPage];
}

- (void)savePageInfo
{
    [[LCEArticleDataManager sharedInstance] savePageInfo:self.dataArray menuId:[NSString stringWithFormat:@"%@", @(self.categoryModel.category_id)]];
}

- (void)loadLocalData
{
    NSArray *cacheList = [[LCEArticleDataManager sharedInstance] pageInfoWithMenuId:[NSString stringWithFormat:@"%@", @(self.categoryModel.category_id)]];
    [self.dataArray addObjectsFromArray:cacheList];
    [self.lceTableView reloadData];
}

#pragma mark---- Setter && Getter
- (SDCycleScrollView *)cycleScrollView
{
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, LCE_SCREEN_WIDTH, LCE_SCREEN_WIDTH * 334 / 750) delegate:self placeholderImage:[UIImage imageNamed:@"icon_placeholder"]];
    _cycleScrollView.backgroundColor = [UIColor whiteColor];
    _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    _cycleScrollView.pageDotColor = [UIColor whiteColor];
    _cycleScrollView.currentPageDotColor = [UIColor lceMainColor];
    _cycleScrollView.autoScrollTimeInterval = 3.5f;
    _cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleToFill;
    _cycleScrollView.imageURLStringsGroup = self.advertImageArray;
    return _cycleScrollView;
}

- (void)setCategoryModel:(LCEArticleCategoryModel *)categoryModel
{
    _categoryModel = categoryModel;
    [self loadLocalData];
}

- (NSMutableArray *)advertImageArray
{
    if (!_advertImageArray) {
        _advertImageArray = [NSMutableArray array];
    }
    return _advertImageArray;
}

- (NSMutableArray *)advertUrlArray
{
    if (!_advertUrlArray) {
        _advertUrlArray = [NSMutableArray array];
    }
    return _advertUrlArray;
}

- (NSMutableArray *)articleImageArrs
{
    if (!_articleImageArrs) {
        _articleImageArrs = [NSMutableArray array];
    }
    return _articleImageArrs;
}

#pragma mark---- Network && Request

- (void)requestArticleListWithCategoryId:(NSInteger)category_id withPage:(NSInteger)page
{
    
    LCENewArticleListModel *model1 = [[LCENewArticleListModel alloc] init];
    model1.contentslist = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1513333363139&di=f27ad633e9e4650182e1179850b856d0&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimage%2Fc0%253Dshijue1%252C0%252C0%252C294%252C40%2Fsign%3D0a2709cf7cc6a7efad2ba0659593c524%2Fcf1b9d16fdfaaf511ee82daf865494eef01f7a93.jpg"];
    LCENewArticleListModel *model2 = [[LCENewArticleListModel alloc] init];
    model2.contentslist = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1513333637507&di=a5b2de179c0e23d937a8de58475dc7b0&imgtype=jpg&src=http%3A%2F%2Fimg3.imgtn.bdimg.com%2Fit%2Fu%3D2966021298%2C3341101515%26fm%3D214%26gp%3D0.jpg", @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1513333847960&di=8b2d66fd1257177496bafb403cfcc8e8&imgtype=0&src=http%3A%2F%2Fimg5q.duitang.com%2Fuploads%2Fitem%2F201312%2F05%2F20131205172454_j2VU3.jpeg"];
    LCENewArticleListModel *model3 = [[LCENewArticleListModel alloc] init];
    model3.contentslist = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1513333767549&di=3fa93254ab2c11726c39dfa2bf439339&imgtype=0&src=http%3A%2F%2Fimg5.duitang.com%2Fuploads%2Fitem%2F201312%2F05%2F20131205172501_cMAKT.jpeg", @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1513333847961&di=f69424e9282828f05abecc26f4c4042c&imgtype=0&src=http%3A%2F%2Fimg4.duitang.com%2Fuploads%2Fitem%2F201312%2F05%2F20131205172458_ymi34.jpeg", @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1513333847960&di=db3da49c5e2d74518d2221ef02cb8ada&imgtype=0&src=http%3A%2F%2Fimg4.duitang.com%2Fuploads%2Fitem%2F201312%2F05%2F20131205172443_WAJR5.jpeg"];
    if (page == 1) {
        [self.dataArray removeAllObjects];
    }
    [self.dataArray addObjectsFromArray:@[model1, model2, model3]];
    self.categoryModel.lastTime = [[NSDate date] timeIntervalSince1970];
    [self.lceTableView reloadData];
}

@end
