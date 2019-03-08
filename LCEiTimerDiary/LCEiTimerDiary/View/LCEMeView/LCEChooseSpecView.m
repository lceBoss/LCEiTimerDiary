//
//  LCEChooseSpecView.m
//  LCEiTimerDiary
//
//  Created by 妖狐小子 on 2019/3/5.
//  Copyright © 2019 妖狐小子. All rights reserved.
//

#import "LCEChooseSpecView.h"

@implementation LCEChooseSpecView

+ (LCEChooseSpecView *)createChooseView {
    LCEChooseSpecView *chooseView = [[[NSBundle mainBundle] loadNibNamed:@"LCEChooseSpecView" owner:self options:nil] firstObject];
    chooseView.backgroundColor = [UIColor clearColor];
    return chooseView;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.frame = CGRectMake(0, LCE_SCREEN_HEIGHT, LCE_SCREEN_WIDTH, LCE_SCREEN_HEIGHT);
    }
    return self;
}

- (void)showChoseView:(BOOL)show {
    if (show) {
        [UIView animateWithDuration:0.6 animations:^{
            self.frame = CGRectMake(0, 0, LCE_SCREEN_WIDTH, LCE_SCREEN_HEIGHT);
        }];
    } else {
        self.frame = CGRectMake(0, LCE_SCREEN_HEIGHT, LCE_SCREEN_WIDTH, LCE_SCREEN_HEIGHT);
    }
}


- (IBAction)touchSpaceDissView:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(chooseSpecView:)]) {
        [_delegate chooseSpecView:self];
    }
}

@end
