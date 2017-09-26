//
//  UIImage+VideoPreview.m
//  KenuoTraining
//
//  Created by Robert on 16/3/11.
//  Copyright © 2016年 Robert. All rights reserved.
//

#import "UIImage+VideoPreview.h"
#import <AVFoundation/AVFoundation.h>
#import "UIImage+fixOrientation.h"


@implementation UIImage (VideoPreview)

+ (void)videoPreviewImage:(NSURL *)url completion:(videoGenerateCompletionBlock)completeBlock {
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:url options:nil];
    AVAssetImageGenerator *generator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    generator.appliesPreferredTrackTransform = TRUE;

    CMTime thumbTime = CMTimeMakeWithSeconds(0, 30);

    AVAssetImageGeneratorCompletionHandler handler =
        ^(CMTime requestedTime, CGImageRef im, CMTime actualTime, AVAssetImageGeneratorResult result, NSError *error) {
            if (result == AVAssetImageGeneratorSucceeded) {
                UIImage *thumbImg = [UIImage imageWithCGImage:im];
                UIImage *fixImg = [thumbImg fixOrientation];
                if (completeBlock) {
                    completeBlock(fixImg, nil);
                }
            } else if (result == AVAssetImageGeneratorFailed) {
                if (completeBlock) {
                    completeBlock(nil, error);
                }
            }
        };

    generator.maximumSize = KNB_SCREEN_BOUNDS.size;
    [generator generateCGImagesAsynchronouslyForTimes:
                   [NSArray arrayWithObject:[NSValue valueWithCMTime:thumbTime]]
                                    completionHandler:handler];
}

+ (UIImage *)videoPreviewImage:(NSURL *)url {
    NSDictionary *opts = @{AVURLAssetPreferPreciseDurationAndTimingKey : [NSNumber numberWithBool:NO]};

    AVURLAsset *urlAssert = [AVURLAsset URLAssetWithURL:url options:opts];
    AVAssetImageGenerator *imageGenerator = [AVAssetImageGenerator assetImageGeneratorWithAsset:urlAssert];
    imageGenerator.appliesPreferredTrackTransform = YES;
    NSError *error = nil;
    CMTime time = CMTimeMake(1.0, 10);
    CMTime actucalTime;
    CGImageRef cgImage = [imageGenerator copyCGImageAtTime:time actualTime:&actucalTime error:&error];
    if (error) {
        NSLog(@"截取视频图片失败:%@", error.localizedDescription);
    }
    CMTimeShow(actucalTime);

    UIImage *originImage = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    return originImage;
}

@end
