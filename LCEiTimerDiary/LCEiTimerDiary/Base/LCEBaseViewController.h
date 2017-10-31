//
//  LCEBaseViewController.h
//  LCEiTimerDiary
//
//  Created by 妖狐小子 on 2017/9/26.
//  Copyright © 2017年 妖狐小子. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"

typedef void (^LCEMJFooterLoadCompleteBlock)(NSInteger page);
typedef void (^LCEMJHeaderLoadCompleteBlock)(NSInteger page);

@interface LCEBaseViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *lceTableView;
@property (nonatomic, strong) UITableView *lceGroupTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger requestPage;//加载页数

/**
 *  添加导航右边按钮
 *
 *  @param imgName 图片
 *  @param sel     sel
 */
- (void)addRightBarItemImageName:(NSString *)imgName sel:(SEL)sel;

/**
 *  添加导航左边按钮
 *
 *  @param imgName 图片
 *  @param sel     sel
 */
- (void)addleftBarItemImageName:(NSString *)imgName sel:(SEL)sel;

/**
 *  添加导航右边按钮
 *
 *  @param title 标题
 *  @param sel   sel
 */
- (void)addRightBarItemTitle:(NSString *)title sel:(SEL)sel;

/**
 *  添加下拉加载更多
 */
- (void)addMJRefreshHeadView:(LCEMJHeaderLoadCompleteBlock)completeBlock;

/**
 *  添加上拉加载更多
 */
- (void)addMJRefreshFootView:(LCEMJFooterLoadCompleteBlock)completeBlock;

/**
 上下拉请求结果回掉
 
 @param success 成功／失败
 @param end 是否请求结束
 */
- (void)requestSuccess:(BOOL)success
            requestEnd:(BOOL)end;

@end
