//
//  LCEWebViewController.m
//  LCEiTimerDiary
//
//  Created by 妖狐小子 on 2018/4/24.
//  Copyright © 2018年 妖狐小子. All rights reserved.
//

#import "LCEWebViewController.h"
#import "NJKWebViewProgress.h"
#import "NJKWebViewProgressView.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface NSURLRequest (ForSSL)

+ (BOOL)allowsAnyHTTPSCertificateForHost:(NSString *)host;

@end

@implementation NSURLRequest (ForSSL)

+ (BOOL)allowsAnyHTTPSCertificateForHost:(NSString *)host
{
    return YES;
}

@end

NSString *const LCEWebJavaScriptContext = @"documentView.webView.mainFrame.javaScriptContext";
NSString *const LCEWebDocumentTitle = @"document.title";

@interface LCEWebViewController () <NJKWebViewProgressDelegate, NSURLConnectionDataDelegate>

@property (nonatomic, strong) NJKWebViewProgress *progressProxy;
@property (nonatomic, strong) NJKWebViewProgressView *progressView;
@property (nonatomic, assign) BOOL webViewGoBack;

@end


@implementation LCEWebViewController

- (void)dealloc {
    [self.progressView removeFromSuperview];
    self.progressView = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _progressProxy = [[NJKWebViewProgress alloc] init];
    self.webView.delegate = _progressProxy;
    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate = self;
    self.showDocumentTitle = YES;
    [self.navigationController.navigationBar addSubview:self.progressView];
    [self.view addSubview:self.webView];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

#pragma mark - Private Method
- (void)addMJRefreshHeadView {
    LCE_WS(weakSelf);
    self.webView.scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (weakSelf.webView.canGoBack) {
            [weakSelf.webView reload];
        } else {
            [weakSelf loadWebView];
        }
    }];
}

- (void)loadWebView {
    NSString *urlStr = self.urlString;
    if (![urlStr hasPrefix:@"http"]) {
        urlStr = [NSString stringWithFormat:@"http://%@", self.urlString];
    }
    NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [self.webView loadRequest:req];
}

#pragma mark -  UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self loadFailed:NO];
    if (self.showDocumentTitle) { // 显示网页标题
        self.title = [webView stringByEvaluatingJavaScriptFromString:LCEWebDocumentTitle];
    }
    JSContext *context = [webView valueForKeyPath:LCEWebJavaScriptContext];
    // JS-OC
//    KNOCJSModel *objectModel = [KNOCJSModel new];
//    context[@"native"] = objectModel;
//
//    KNB_WS(weakSelf);
//    objectModel.myTeamBlock = ^() {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [weakSelf viewDetailMyTeam];
//        });
//    };
//
//    objectModel.goodsIdBlock = ^(NSString *goodsId, NSString *actionType) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [weakSelf goToMtmyAppGoods:goodsId actionType:actionType];
//        });
//    };
//
//    objectModel.popControllerBlock = ^(BOOL needDelay) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            NSInteger timeDelay = needDelay ? 2 : 0;
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(timeDelay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [weakSelf.navigationController popViewControllerAnimated:YES];
//            });
//        });
//    };
    
    //OC-JS
    [context evaluateScript:@"isApp(2)"];
    if (self.webViewGoBack && self.needGoBack) {
        self.webViewGoBack = NO;
        [context evaluateScript:@"setTabindex()"];
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self loadFailed:YES];
}

- (void)loadFailed:(BOOL)failed {
    [self.webView.scrollView.mj_header endRefreshing];
    [self.progressView setProgress:1 animated:YES];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

#pragma mark - NJKWebViewProgressDelegate
- (void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress {
    [self.progressView setProgress:progress animated:YES];
}

#pragma mark - Getter && Setter
- (NJKWebViewProgressView *)progressView {
    if (!_progressView) {
        CGRect barBounds = self.navigationController.navigationBar.bounds;
        _progressView = [[NJKWebViewProgressView alloc] initWithFrame:CGRectMake(0, barBounds.size.height - 2.0, LCE_SCREEN_WIDTH, 2.0)];
        _progressView.progressBarView.backgroundColor = [UIColor lceMainColor];
        _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    }
    return _progressView;
}

- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, LCE_NAV_HEIGHT, LCE_SCREEN_WIDTH, LCE_SCREEN_HEIGHT - LCE_NAV_HEIGHT)];
        _webView.backgroundColor = [UIColor whiteColor];
        _webView.delegate = self;
        _webView.opaque = NO;
    }
    return _webView;
}

- (void)setUrlString:(NSString *)aUrlString {
    _urlString = aUrlString;
    [self loadWebView];
}

#pragma mark - BackButton
- (NSArray *)barButtonImageName:(NSString *)imgName sel:(SEL)sel {
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 40, 44);
    [backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
    [backBtn setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    [backBtn addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    UIBarButtonItem *placeHolditem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    return @[ item, placeHolditem ];
}

#pragma mark - UIBarButtonItemAction
- (void)leftBarButtonItemAction:(UIBarButtonItem *)item {
    if ([self.webView canGoBack]) {
        self.webViewGoBack = YES;
        [self.webView goBack];
    } else {
        if (self.navigationController.viewControllers.count > 1) {
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
