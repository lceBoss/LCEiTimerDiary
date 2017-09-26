//
//  UIImage+QRCode.m
//  KenuoTraining
//
//  Created by 妖狐小子 on 2017/4/28.
//  Copyright © 2017年 Robert. All rights reserved.
//

#import "UIImage+QRCode.h"


@implementation UIImage (QRCode)

+ (UIImage *)imageWithUrlLinkString:(NSString *)link size:(CGSize)size {
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    // 为二维码准备背后的二进制数据
    NSData *data = [link dataUsingEncoding:NSUTF8StringEncoding];
    // 使用kvc的方式将data赋给filter
    [filter setValue:data forKey:@"inputMessage"];
    // 生成图片
    CIImage *outputImage = [filter outputImage];
    // 不带icon的图片
    UIImage *qrImage = [self createNonInterpolatedUIImageFormCIImage:outputImage size:size];
    // 带icon的图片
    UIImage *image = [self addSmallImageForQRImage:qrImage];
    return image;
}

/**
 *  根据CIImage生成指定大小的UIImage
 *
 *  @param image CIImage
 *  @param size  图片宽度
 */
+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)ciImage size:(CGSize)size {
    CGRect extent = CGRectIntegral(ciImage.extent);
    CGFloat scale = MIN(size.width / CGRectGetWidth(extent), size.height / CGRectGetHeight(extent));

    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:ciImage fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);

    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);

    UIImage *qrImage = [UIImage imageWithCGImage:scaledImage]; // 不带icon的图片
    return qrImage;
}

/** 在二维码中心加一个小图 */
+ (UIImage *)addSmallImageForQRImage:(UIImage *)qrImage {
    UIGraphicsBeginImageContextWithOptions(qrImage.size, NO, [[UIScreen mainScreen] scale]);
    [qrImage drawInRect:CGRectMake(0, 0, qrImage.size.width, qrImage.size.height)];
    UIImage *image = [UIImage imageNamed:@"app_icon"];
    CGFloat imageW = 50;
    CGFloat imageX = (qrImage.size.width - imageW) * 0.5;
    CGFloat imgaeY = (qrImage.size.height - imageW) * 0.5;
    [image drawInRect:CGRectMake(imageX, imgaeY, imageW, imageW)];
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return result;
}


@end
