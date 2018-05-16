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

@interface LCEImageSearchViewController ()

@end

@implementation LCEImageSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"头条搜图";
    [self.view addSubview:self.lceTableView];
    [self requestImageSearchWithKeyword:@"街拍" page:1];
}

#pragma mark - UITableViewDataSource && UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    LCESearchImageModel *imageModel = self.dataArray[indexPath.row];
    cell.textLabel.text = imageModel.title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - Request
- (void)requestImageSearchWithKeyword:(NSString *)keyword page:(NSInteger)page {
    LCEStreetSnapImageApi *api = [[LCEStreetSnapImageApi alloc] initWithKeyword:@"街拍" page:1];
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        if (request.responseStatusCode == 200) {
            NSArray *dataArray = [LCESearchImageModel changeResponseJSONObject:request.responseJSONObject[@"data"]];
            if (page == 1) {
                [self.dataArray removeAllObjects];
            }
            [self.dataArray addObjectsFromArray:dataArray];
            [self.lceTableView reloadData];
        }else {
            NSLog(@"请求失败");
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
