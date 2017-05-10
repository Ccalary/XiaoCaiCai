//
//  NSString+GetSize.m
//  WaterMan
//
//  Created by liqiang on 15/12/18.
//  Copyright © 2015年 baichun. All rights reserved.
//

#import "NSString+GetSize.h"

@implementation NSString (GetSize)

- (CGSize)calculateStringSizeWithMaxSize:(CGSize)maxSize font:(UIFont *)font
{
    NSDictionary *attribute = @{NSFontAttributeName: font};
    CGSize size = [self boundingRectWithSize:maxSize options: NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
    
    return size;
}

+ (CGSize)calculateStringSizeWithMaxSize:(CGSize)maxSize font:(UIFont *)font string:(NSString *)string
{
    NSDictionary *attribute = @{NSFontAttributeName: font};
    CGSize size = [string boundingRectWithSize:maxSize options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    
    return size;
}

//计算多行高度
+ (CGFloat )calculateStringHeightWithWidth:(CGFloat)width font:(UIFont *)font string:(NSString *)string
{
    NSDictionary *attribute = @{NSFontAttributeName: font};
    CGSize size = [string boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    
    return size.height;
}

@end
