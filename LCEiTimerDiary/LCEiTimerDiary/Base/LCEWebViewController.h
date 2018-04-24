//
//  LCEWebViewController.h
//  LCEiTimerDiary
//
//  Created by 妖狐小子 on 2018/4/24.
//  Copyright © 2018年 妖狐小子. All rights reserved.
//

#import "LCEBaseViewController.h"

@interface LCEWebViewController : LCEBaseViewController <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, copy) NSString *urlString;
// default YES
@property (nonatomic, assign) BOOL showDocumentTitle;
// 返回是否需要清除缓存
@property (nonatomic, assign) BOOL needGoBack;

- (void)leftBarButtonItemAction:(UIBarButtonItem *)item;
// 下拉重新加载
- (void)addMJRefreshHeadView;

@end
