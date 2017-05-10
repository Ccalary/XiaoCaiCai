//
//  UIImage+Scale.h
//  RomanticAppiontment
//
//  Created by jacob on 15/6/11.
//  Copyright (c) 2015年 baichun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage(Scale)

+ (UIImage *)imageMax800WithImage:(UIImage *)img;
+ (UIImage *)imageShrinkSize:(CGSize)size withImage:(UIImage *)img;

+ (UIImage *)imageScalingSize:(CGSize)size withImage:(UIImage *)img;
+ (UIImage *)imageShrinkMinSize:(CGSize)size withImage:(UIImage *)img;
/**
 *  对图片尺寸进行压缩--
 */
-(UIImage*)imageScaledToSize:(CGSize)newSize;

/**
 *  截取图片的一部分
 */
+ (UIImage *)getPartOfImage:(UIImage *)img rect:(CGRect)partRect;

- (UIImage *)imageByScalingToSize:(CGSize)targetSize;

/**
 *  根据图片url获取图片尺寸
 */
+(CGSize)getImageSizeWithURL:(id)imageURL;

@end
