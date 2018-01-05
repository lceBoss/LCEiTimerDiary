//
//  LCEBaseViewController.m
//  LCEiTimerDiary
//
//  Created by 妖狐小子 on 2017/9/26.
//  Copyright © 2017年 妖狐小子. All rights reserved.
//

#import "LCEBaseViewController.h"

@interface LCEBaseViewController ()

@property (nonatomic, copy) LCEMJFooterLoadCompleteBlock footerCompleteBlock;

@end

@implementation LCEBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lceBgColor];
    self.requestPage = 1;
    self.automaticallyAdjustsScrollViewInsets = NO;
    if (self.navigationController.viewControllers.count > 1) {
        [self addleftBarItemImageName:@"icon_navi_return" sel:@selector(leftBarButtonItemAction:)];
        CGRect newFrame = CGRectMake(0, 64, LCE_SCREEN_WIDTH, LCE_SCREEN_HEIGHT - 64);
        self.lceTableView.frame = newFrame;
        self.lceGroupTableView.frame = newFrame;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (LCE_SYSTEM_VERSION < 9.0 && LCE_SYSTEM_VERSION > 7.9) {
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
        [self.navigationController setNavigationBarHidden:NO animated:animated];
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
    } else {
        self.navigationController.navigationBar.hidden = NO;
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (void)addRightBarItemImageName:(NSString *)imgName sel:(SEL)sel {
    NSArray *items = [self barButtonImageName:imgName sel:sel leftEdge:8];
    self.navigationItem.rightBarButtonItems = items;
}

- (void)addleftBarItemImageName:(NSString *)imgName sel:(SEL)sel {
    NSArray *items = [self barButtonImageName:imgName sel:sel leftEdge:-10];
    self.navigationItem.leftBarButtonItems = items;
}

- (NSArray *)barButtonImageName:(NSString *)imgName sel:(SEL)sel leftEdge:(CGFloat)edge {
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 40, 44);
    [backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, edge, 0, 0)];
    [backBtn setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    [backBtn addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    UIBarButtonItem *placeHolditem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    return @[ item, placeHolditem ];
}

- (void)addLeftBarItemTitle:(NSString *)title sel:(SEL)sel {
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:sel];
    self.navigationItem.leftBarButtonItem = leftItem;
}

- (void)addRightBarItemTitle:(NSString *)title sel:(SEL)sel {
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:sel];
    self.navigationItem.rightBarButtonItem = rightItem;
}

#pragma mark - UIBarButtonItemAction
- (void)leftBarButtonItemAction:(UIBarButtonItem *)item {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Setter

- (UITableView *)lceTableView {
    if (!_lceTableView) {
        CGRect frame = CGRectMake(0, 64, LCE_SCREEN_WIDTH, LCE_SCREEN_HEIGHT - 64);
        _lceTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        _lceTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _lceTableView.backgroundColor = [UIColor lceBgColor];
        _lceTableView.delegate = self;
        _lceTableView.dataSource = self;
    }
    return _lceTableView;
}

- (UITableView *)lceGroupTableView {
    if (!_lceGroupTableView) {
        CGRect frame = CGRectMake(0, 64, LCE_SCREEN_WIDTH, LCE_SCREEN_HEIGHT - 64);
        _lceGroupTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
        _lceGroupTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _lceGroupTableView.backgroundColor = [UIColor lceBgColor];
        _lceGroupTableView.delegate = self;
        _lceGroupTableView.dataSource = self;
        _lceGroupTableView.sectionFooterHeight = 0.1;
        _lceGroupTableView.sectionHeaderHeight = 0.1;
    }
    return _lceGroupTableView;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

#pragma mark -  MJRefresh
- (void)addMJRefreshFootView:(LCEMJFooterLoadCompleteBlock)completeBlock {
    self.lceGroupTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.lceTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.footerCompleteBlock = completeBlock;
}

- (void)loadMoreData {
    self.requestPage += 1;
    if (self.footerCompleteBlock) {
        self.footerCompleteBlock(self.requestPage);
    }
}

- (void)requestSuccess:(BOOL)success requestEnd:(BOOL)end {
    [self.lceGroupTableView.mj_header endRefreshing];
    [self.lceGroupTableView.mj_footer endRefreshing];
    [self.lceTableView.mj_header endRefreshing];
    [self.lceTableView.mj_footer endRefreshing];
    
    if (end) {
        [self.lceTableView.mj_footer endRefreshingWithNoMoreData];
        [self.lceGroupTableView.mj_footer endRefreshingWithNoMoreData];
        [self.lceGroupTableView reloadData];
        [self.lceTableView reloadData];
        return;
    }
    if (!success && self.requestPage > 1) {
        self.requestPage -= 1;
    } else {
        [self.lceGroupTableView reloadData];
        [self.lceTableView reloadData];
    }
}

- (void)addMJRefreshHeadView:(LCEMJHeaderLoadCompleteBlock)completeBlock {
    LCE_WS(weakSelf);
    self.lceTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf.lceTableView.mj_footer resetNoMoreData];
        weakSelf.requestPage = 1;
        if (completeBlock) {
            completeBlock(1);
        }
    }];
    
    self.lceGroupTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf.lceGroupTableView.mj_footer resetNoMoreData];
        weakSelf.requestPage = 1;
        if (completeBlock) {
            completeBlock(1);
        }
    }];
}

@end
