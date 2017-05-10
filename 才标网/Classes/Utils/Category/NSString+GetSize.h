//
//  NSString+GetSize.h
//  WaterMan
//
//  Created by liqiang on 15/12/18.
//  Copyright © 2015年 baichun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (GetSize)

- (CGSize)calculateStringSizeWithMaxSize:(CGSize)maxSize font:(UIFont *)font;

+ (CGSize)calculateStringSizeWithMaxSize:(CGSize)maxSize font:(UIFont *)font string:(NSString *)string;

//计算多行高度
+ (CGFloat )calculateStringHeightWithWidth:(CGFloat)width font:(UIFont *)font string:(NSString *)string;
@end
