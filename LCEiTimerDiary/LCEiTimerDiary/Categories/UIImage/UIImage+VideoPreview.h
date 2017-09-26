//
//  UIImage+VideoPreview.h
//  KenuoTraining
//
//  Created by Robert on 16/3/11.
//  Copyright © 2016年 Robert. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^videoGenerateCompletionBlock)(UIImage *preViewImage, NSError *error);


@interface UIImage (VideoPreview)
/**
 *  获取请求下来的视频封面
 *
 *  @param url 网址
 *
 *  @return 视频封面    
 */
+ (void)videoPreviewImage:(NSURL *)url completion:(videoGenerateCompletionBlock)completeBlock;

+ (UIImage *)videoPreviewImage:(NSURL *)url;

@end
