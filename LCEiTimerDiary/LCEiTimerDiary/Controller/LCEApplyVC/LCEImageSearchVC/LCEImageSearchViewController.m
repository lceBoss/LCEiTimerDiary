//
//  LCEImageSearchViewController.m
//  LCEiTimerDiary
//
//  Created by 妖狐小子 on 2018/5/16.
//  Copyright © 2018年 妖狐小子. All rights reserved.
//

#import "LCEImageSearchViewController.h"
#import "LCEStreetSnapImageApi.h"
#import "LCESearchImageModel.h"
#import "LCEImageSearchTableViewCell.h"

@interface LCEImageSearchViewController ()<LCEImageSearchTableViewCellDelegate>

@property (nonatomic, strong) NSString *keyword;
@property (nonatomic, strong) NSMutableArray *searchImageArrs;

@end

@implementation LCEImageSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"头条搜图";
    [self.view addSubview:self.lceTableView];
    self.keyword = @"街拍";
    [self requestImageSearchWithKeyword:self.keyword page:1];
    
    LCE_WS(weakSelf);
    [self addMJRefreshHeadView:^(NSInteger page) {
        [weakSelf requestImageSearchWithKeyword:weakSelf.keyword page:page];
    }];
    [self addMJRefreshFootView:^(NSInteger page) {
        [weakSelf requestImageSearchWithKeyword:weakSelf.keyword page:page];
    }];
    
}

#pragma mark - UITableViewDataSource && UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LCEImageSearchTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LCEImageSearchTableViewCell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"LCEImageSearchTableViewCell" owner:self options:nil] firstObject];
        cell.delegate = self;
    }
    
    cell.imageCollectionView.tag = indexPath.row;
    LCESearchImageModel *listModel = self.dataArray[indexPath.row];
    cell.listModel = listModel;
    [self.searchImageArrs removeAllObjects];
    [self.searchImageArrs addObjectsFromArray:listModel.searchImages];
    //文章图片
    [cell setupImageCollectionView]; //设置图片collectionview的布局
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.searchImageArrs.count == 0) {
        return 104;
    }
    // 向上取整 分母图片个数需是浮点数
    NSInteger rowNums = ceilf(self.searchImageArrs.count / 3.0);
    NSInteger itemHeight = (LCE_SCREEN_WIDTH - 24 - 2 * 5) / 3;
    return itemHeight * rowNums + (rowNums - 1) * 5 + 104;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - LCEImageSearchTableViewCellDelegate
- (void)searchImageTableViewCell:(LCEImageSearchTableViewCell *)cell selectCellIndex:(NSInteger)cellIndex imageIndex:(NSInteger)imageIndex {
    
}

#pragma mark - Setter & Getter
- (NSMutableArray *)searchImageArrs {
    if (!_searchImageArrs) {
        _searchImageArrs = [NSMutableArray array];
    }
    return _searchImageArrs;
}

#pragma mark - Request
- (void)requestImageSearchWithKeyword:(NSString *)keyword page:(NSInteger)page {
    LCEStreetSnapImageApi *api = [[LCEStreetSnapImageApi alloc] initWithKeyword:keyword page:page];
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        if (request.responseStatusCode == 200) {
            NSArray *dataArray = [LCESearchImageModel changeResponseJSONObject:request.responseJSONObject[@"data"]];
            if (page == 1) {
                [self.dataArray removeAllObjects];
            }
            [self.dataArray addObjectsFromArray:dataArray];
            [self requestSuccess:YES requestEnd:dataArray.count < 10];
        }else {
            [self requestSuccess:NO requestEnd:YES];
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        [self requestSuccess:NO requestEnd:YES];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
