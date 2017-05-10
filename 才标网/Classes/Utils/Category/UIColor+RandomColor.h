//
//  UIColor+RandomColor.h
//  zhiboPlayer
//
//  Created by aliviya on 16/9/14.
//  Copyright © 2016年 coco. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (RandomColor)
//16进制转 rbg颜色
+(UIColor *)colorWithHex:(NSString *)hexColor;
@end
