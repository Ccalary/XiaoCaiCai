//
//  UIColor+RandomColor.m
//  zhiboPlayer
//
//  Created by aliviya on 16/9/14.
//  Copyright © 2016年 coco. All rights reserved.
//

#import "UIColor+RandomColor.h"

@implementation UIColor(RandomColor)
+(UIColor *)colorWithHex:(NSString *)hexColor{
    return [self colorWithHex:hexColor alpha:1.0f];
}
//http://www.cnblogs.com/xiaofeixiang  iOS技术交流:228407086
+(UIColor *)colorWithHex:(NSString *)hexColor alpha:(float)alpha{
    //删除空格
    NSString *colorStr = [[hexColor stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([colorStr length] < 6||[colorStr length]>7)
    {
        return [UIColor clearColor];
    }
    //
    if ([colorStr hasPrefix:@"#"])
    {
        colorStr = [colorStr substringFromIndex:1];
    }
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    //red
    NSString *redString = [colorStr substringWithRange:range];
    //green
    range.location = 2;
    NSString *greenString = [colorStr substringWithRange:range];
    //blue
    range.location = 4;
    NSString *blueString= [colorStr substringWithRange:range];
    
    // Scan values
    unsigned int red, green, blue;
    [[NSScanner scannerWithString:redString] scanHexInt:&red];
    [[NSScanner scannerWithString:greenString] scanHexInt:&green];
    [[NSScanner scannerWithString:blueString] scanHexInt:&blue];
    return [UIColor colorWithRed:((float)red/ 255.0f) green:((float)green/ 255.0f) blue:((float)blue/ 255.0f) alpha:alpha];
}
@end
