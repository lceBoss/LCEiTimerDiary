//
//  KNBFoundViewController.m
//  KenuoTraining
//
//  Created by 妖狐小子 on 2017/1/15.
//  Copyright © 2017年 Robert. All rights reserved.
//

#import "LCEFoundViewController.h"
#import "LCEArticleListViewController.h"
#import "VTMagic.h"
#import "LCESearchImageTagListApi.h"
#import "LCESearchImageTagModel.h"


@interface LCEFoundViewController () <VTMagicViewDataSource, VTMagicViewDelegate>

@property (nonatomic, strong) VTMagicController *magicController;

@end


@implementation LCEFoundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发现";
    self.edgesForExtendedLayout = UIRectEdgeAll;
    self.view.backgroundColor = [UIColor whiteColor];
    [self addChildViewController:self.magicController];
    [self.view addSubview:_magicController.view];
    self.magicController.view.frame = CGRectMake(0, 0, LCE_SCREEN_WIDTH, LCE_SCREEN_HEIGHT - LCE_TAB_HEIGHT);
    [self requestGetSearchImageKeyword];
    [self.view setNeedsUpdateConstraints];
    [_magicController.magicView reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self initializeTableView];
}

/**
 初始化表格结构
 */
- (void)initializeTableView {
    
}

#pragma mark - VTMagicViewDataSource
- (NSArray<NSString *> *)menuTitlesForMagicView:(VTMagicView *)magicView {
    NSMutableArray *tagArray = [NSMutableArray array];
    for (LCESearchImageTagModel *tagModel in self.dataArray) {
        [tagArray addObject:tagModel.keyword];
    }
    return tagArray;
}

- (UIButton *)magicView:(VTMagicView *)magicView menuItemAtIndex:(NSUInteger)itemIndex {
    static NSString *itemIdentifier = @"itemIdentifier";
    UIButton *menuItem = [magicView dequeueReusableItemWithIdentifier:itemIdentifier];
    if (!menuItem) {
        menuItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [menuItem setTitleColor:RGBCOLOR(50, 50, 50) forState:UIControlStateNormal];
        [menuItem setTitleColor:[UIColor lceMainColor] forState:UIControlStateSelected];
        menuItem.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:15.f];
    }
    return menuItem;
}

- (UIViewController *)magicView:(VTMagicView *)magicView viewControllerAtPage:(NSUInteger)pageIndex {
    static NSString *pageId = @"KNBArticleListViewController";
    LCEArticleListViewController *articleListVC = [magicView dequeueReusablePageWithIdentifier:pageId];
    if (!articleListVC) {
        articleListVC = [[LCEArticleListViewController alloc] init];
    }
    LCESearchImageTagModel *model = self.dataArray[pageIndex];
    LCEArticleCategoryModel *cateModel = [[LCEArticleCategoryModel alloc] init];
    cateModel.name = model.keyword;
    cateModel.category_id = pageIndex;
    articleListVC.categoryModel = cateModel;
    return articleListVC;
}

// 选中了某个item
- (void)magicView:(VTMagicView *)magicView didSelectItemAtIndex:(NSUInteger)itemIndex {
    //    NSLog(@"Select Item is %@", @(itemIndex));
}

- (VTMagicController *)magicController {
    if (!_magicController) {
        _magicController = [[VTMagicController alloc] init];
        _magicController.view.translatesAutoresizingMaskIntoConstraints = NO;
        _magicController.magicView.navigationColor = [UIColor whiteColor];
        _magicController.magicView.sliderColor = [UIColor lceMainColor];
        _magicController.magicView.switchStyle = VTSwitchStyleDefault;
        _magicController.magicView.layoutStyle = VTLayoutStyleDefault;
        _magicController.magicView.navigationHeight = LCE_ISIPHONEX ? 46.f : 44.f;
        _magicController.magicView.againstStatusBar = LCE_ISIPHONEX ? YES : NO;
        _magicController.magicView.sliderExtension = 8.0;
        _magicController.magicView.itemScale = 1.13;
        _magicController.magicView.sliderHeight = 2.f;
        _magicController.magicView.itemSpacing = 30;
        _magicController.magicView.headerHidden = NO;
        _magicController.magicView.dataSource = self;
        _magicController.magicView.delegate = self;
    }
    return _magicController;
}

#pragma mark - Network
- (void)requestGetSearchImageKeyword {
    LCESearchImageTagListApi *api = [[LCESearchImageTagListApi alloc] init];
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        if (request.responseStatusCode == 200) {
            NSArray *dataArray = [LCESearchImageTagModel changeResponseJSONObject:request.responseJSONObject[@"data"]];
            [self.dataArray removeAllObjects];
            [self.dataArray addObjectsFromArray:dataArray];
            [self.magicController.magicView reloadData];
        }
    } failure:^(__kindof YTKBaseRequest *request) {

    }];
}





@end
