//
//  UIImage+QRCode.h
//  KenuoTraining
//
//  Created by 妖狐小子 on 2017/4/28.
//  Copyright © 2017年 Robert. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIImage (QRCode)

+ (UIImage *)imageWithUrlLinkString:(NSString *)link size:(CGSize)size;

@end
