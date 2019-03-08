//
//  LCEChooseSpecView.h
//  LCEiTimerDiary
//
//  Created by 妖狐小子 on 2019/3/5.
//  Copyright © 2019 妖狐小子. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class LCEChooseSpecView;

@protocol LCEChooseSpecViewDelegate <NSObject>

- (void)chooseSpecView:(LCEChooseSpecView *)view;

@end

@interface LCEChooseSpecView : UIView

@property (nonatomic, weak) id<LCEChooseSpecViewDelegate> delegate;

+ (LCEChooseSpecView *)createChooseView;

- (void)showChoseView:(BOOL)show;

@end

NS_ASSUME_NONNULL_END
