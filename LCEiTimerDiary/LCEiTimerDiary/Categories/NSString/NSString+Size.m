//
//  NSString+Size.m
//  KenuoTraining
//
//  Created by Robert on 16/2/22.
//  Copyright © 2016年 Robert. All rights reserved.
//

#import "NSString+Size.h"


@implementation NSString (Size)

- (CGFloat)heightWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width {
    UIFont *textFont = font ? font : [UIFont systemFontOfSize:[UIFont systemFontSize]];

    CGSize textSize;

#if __IPHONE_OS_VERSION_MIN_REQUIRED < 70000
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
        paragraph.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName : textFont,
                                     NSParagraphStyleAttributeName : paragraph};
        textSize = [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                      options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine
                                   attributes:attributes
                                      context:nil]
                       .size;
    } else {
        textSize = [self sizeWithFont:textFont
                    constrainedToSize:CGSizeMake(width, CGFLOAT_MAX)
                        lineBreakMode:NSLineBreakByWordWrapping];
    }
#else
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName : textFont,
                                 NSParagraphStyleAttributeName : paragraph};
    textSize = [self boundingRectWithSize:CGSizeMake(floor(width), CGFLOAT_MAX)
                                  options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading
                               attributes:attributes
                                  context:nil]
                   .size;
#endif

    return ceil(textSize.height);
}

- (CGFloat)heightWithFont:(UIFont *)font
       constrainedToWidth:(CGFloat)width
           paragraphStyle:(NSParagraphStyle *)paragraphyStyle {
    
    UIFont *textFont = font ? font : [UIFont systemFontOfSize:[UIFont systemFontSize]];
    NSDictionary *attributes = @{NSFontAttributeName : textFont,
                                 NSParagraphStyleAttributeName : paragraphyStyle};
    CGSize textSize = [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                         options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading
                                      attributes:attributes
                                         context:nil].size;
    return ceil(textSize.height);
}



- (CGFloat)heightWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width andLineSpace:(CGFloat)lineSpace {
    UIFont *textFont = font ? font : [UIFont systemFontOfSize:[UIFont systemFontSize]];

    CGSize textSize;

    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    [paragraph setLineSpacing:5];
    [paragraph setLineBreakMode:NSLineBreakByWordWrapping];
    NSDictionary *attributes = @{NSFontAttributeName : textFont,
                                 NSParagraphStyleAttributeName : paragraph};
    textSize = [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                  options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading
                               attributes:attributes
                                  context:nil]
                   .size;
    return ceil(textSize.height);
}

- (CGFloat)widthWithFont:(UIFont *)font constrainedToHeight:(CGFloat)height {
    UIFont *textFont = font ? font : [UIFont systemFontOfSize:[UIFont systemFontSize]];

    CGSize textSize;

#if __IPHONE_OS_VERSION_MIN_REQUIRED < 70000
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
        paragraph.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName : textFont,
                                     NSParagraphStyleAttributeName : paragraph};
        textSize = [self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height)
                                      options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine
                                   attributes:attributes
                                      context:nil]
                       .size;
    } else {
        textSize = [self sizeWithFont:textFont
                    constrainedToSize:CGSizeMake(CGFLOAT_MAX, height)
                        lineBreakMode:NSLineBreakByWordWrapping];
    }
#else
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName : textFont,
                                 NSParagraphStyleAttributeName : paragraph};
    textSize = [self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height)
                                  options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine
                               attributes:attributes
                                  context:nil]
                   .size;
#endif

    return ceil(textSize.width);
}

@end
