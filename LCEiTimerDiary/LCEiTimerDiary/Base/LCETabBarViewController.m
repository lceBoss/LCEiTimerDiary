//
//  LCETabBarViewController.m
//  LCEiTimerDiary
//
//  Created by 妖狐小子 on 2017/9/26.
//  Copyright © 2017年 妖狐小子. All rights reserved.
//

#import "LCETabBarViewController.h"
#import "LCENavigationController.h"

const NSInteger LCETabBarButtonTag = 999;
const NSInteger LCETabBarButtonTitleLabelTag = 666;

@interface LCETabBarViewController ()

@property (nonatomic, strong) UIView *customTabBar;
@property (nonatomic, strong) NSArray *selectImgArray;
@property (nonatomic, strong) NSArray *unSelectImgArray;
@property (nonatomic, strong) NSArray *titlesArray;
@property (nonatomic, strong) NSMutableArray *buttonsArray;
@property (nonatomic, strong) UIColor *titleSelectColor;
@property (nonatomic, strong) UIColor *titleDefaultColor;
@property (nonatomic, strong) UIImageView *unReadIconImg;

@end

@implementation LCETabBarViewController

- (void)dealloc {
    [self.view removeObserver:self forKeyPath:@"frame"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
    self.view.autoresizesSubviews = NO;
    self.tabBar.hidden = YES;
    
    self.titleDefaultColor = [UIColor lightGrayColor];
    self.titleSelectColor = [UIColor lceMainColor];
    
    self.titlesArray = @[ @"首页", @"我的" ];
    self.selectImgArray = @[ @"icon_tabbar_home", @"icon_tabbar_me" ];
    self.unSelectImgArray = @[ @"icon_tabbar_home_no", @"icon_tabbar_me_no" ];
    self.buttonsArray = [NSMutableArray array];
    [self createViewControllers];
    [self.view addSubview:self.customTabBar];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (LCE_SYSTEM_VERSION < 9.0 && LCE_SYSTEM_VERSION > 7.9) {
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
        [self.navigationController setNavigationBarHidden:YES animated:animated];
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
    } else {
        self.navigationController.navigationBar.hidden = NO;
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"frame"]) {
        self.customTabBar.frame = CGRectMake(0, self.view.frame.size.height - 49, LCE_SCREEN_WIDTH, 49);
    }
}

- (void)createViewControllers {
    
    self.homeVC = [[LCEHomeViewController alloc] init];
    self.meVC = [[LCEMeViewController alloc] init];
    self.viewControllers = @[self.homeVC, self.meVC];
    
    NSInteger selectImgCount = self.selectImgArray.count;
    for (int i = 0; i < selectImgCount; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = i + LCETabBarButtonTag;
        [button addTarget:self action:@selector(tabBarPressed:) forControlEvents:UIControlEventTouchUpInside];
        [button setImage:[UIImage imageNamed:self.unSelectImgArray[i]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:self.selectImgArray[i]] forState:UIControlStateSelected];
        button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 10, 0);
        CGFloat buttonWith = LCE_SCREEN_WIDTH / selectImgCount;
        button.frame = CGRectMake(buttonWith * i, 0, buttonWith, 49);
        button.adjustsImageWhenHighlighted = NO;
        
        CGRect titleLabelFrame = CGRectMake(0, 29, buttonWith, 20);
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:titleLabelFrame];
        titleLabel.tag = LCETabBarButtonTitleLabelTag;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.text = self.titlesArray[i];
        titleLabel.textColor = self.titleDefaultColor;
        titleLabel.font = [UIFont systemFontOfSize:10.0];
        [button addSubview:titleLabel];
        if (i == (selectImgCount - 1)) {
            self.unReadIconImg.frame = CGRectMake(buttonWith / 2 + 11, 5, 7, 7);
            [button addSubview:self.unReadIconImg];
        }
        if (i == 0) {
            titleLabel.textColor = self.titleSelectColor;
            [self tabBarPressed:button];
            button.selected = YES;
        }
        [self.customTabBar insertSubview:button atIndex:2];
        [self.buttonsArray addObject:button];
    }
    
}

- (UIView *)customTabBar {
    if (!_customTabBar) {
        _customTabBar = [[UIView alloc] initWithFrame:CGRectMake(0, LCE_SCREEN_HEIGHT - 49, LCE_SCREEN_WIDTH, 49)];
        _customTabBar.backgroundColor = LCE_RGB(248, 248, 248);
        _customTabBar.layer.shadowColor = LCE_RGB(230, 230, 230).CGColor;
        _customTabBar.layer.shadowRadius = 0.5;
        _customTabBar.layer.shadowOffset = CGSizeMake(0, -0.5); //偏移量
        _customTabBar.layer.shadowOpacity = 1;
    }
    return _customTabBar;
}
- (UIImageView *)unReadIconImg {
    if (!_unReadIconImg) {
        _unReadIconImg = [[UIImageView alloc] init];
        _unReadIconImg.image = [UIImage imageNamed:@"icon_message"];
        _unReadIconImg.hidden = YES;
    }
    return _unReadIconImg;
}

- (void)tabBarPressed:(UIButton *)button {
    if (button.isSelected) {
        return;
    }
    NSUInteger index = button.tag - LCETabBarButtonTag;
    self.selectedIndex = index;
    if (self.selectBlock) {
        self.selectBlock(index);
    }
    UIViewController *currentVC = self.viewControllers[index];
    self.title = currentVC.title;
    self.navigationItem.titleView = currentVC.navigationItem.titleView;
    self.navigationItem.rightBarButtonItem = currentVC.navigationItem.rightBarButtonItem;
    self.navigationItem.leftBarButtonItem = currentVC.navigationItem.leftBarButtonItem;
    for (UIButton *tabButton in _buttonsArray) {
        BOOL buttonSelect = [tabButton isEqual:button];
        tabButton.selected = buttonSelect;
        
        UILabel *titleLabel = [tabButton viewWithTag:LCETabBarButtonTitleLabelTag];
        titleLabel.textColor = buttonSelect ? self.titleSelectColor : self.titleDefaultColor;
    }
}

- (void)turnToControllerIndex:(int)index {
    if (index < _buttonsArray.count) {
        [self tabBarPressed:_buttonsArray[index]];
    }
}

- (void)showIconImage:(BOOL)show {
    self.unReadIconImg.hidden = !show;
}

@end
