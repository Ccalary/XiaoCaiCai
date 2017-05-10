//
//  UIImage+Scale.m
//  RomanticAppiontment
//
//  Created by jacob on 15/6/11.
//  Copyright (c) 2015年 baichun. All rights reserved.
//

#import "UIImage+Scale.h"

@implementation UIImage(Scale)

+ (UIImage *)imageMax800WithImage:(UIImage *)img
{
    CGFloat h = img.size.height;
    CGFloat w = img.size.width;
    if(h <= 800 && w <= 800)
    {
        return img;
    }
    else
    {
        float b = (float)800.0/w < (float)800.0/h ? (float)800.0/w : (float)800.0/h;
        CGSize itemSize = CGSizeMake(b*w, b*h);
        UIGraphicsBeginImageContext(itemSize);
        CGRect imageRect = CGRectMake(0, 0, b*w, b*h);
        [img drawInRect:imageRect];
        img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return img;
    }
    return img;
}

/*
 图片自适应，已比例大的为准，等比例显示宽和高
 */
+ (UIImage *)imageShrinkSize:(CGSize)size withImage:(UIImage *)img
{
    CGFloat h = size.height;
    CGFloat w = size.width;
    
    CGFloat heightImg = img.size.height;
    CGFloat widthImg = img.size.width;
    if(heightImg > h && widthImg > w)
    {
        UIImage *imgNew = [[UIImage alloc] init];
        
        float b = (float)w/widthImg > (float)h/heightImg ? (float)w/widthImg : (float)h/heightImg;
        CGSize itemSize = CGSizeMake(b*widthImg, b*heightImg);
        UIGraphicsBeginImageContext(itemSize);
        CGRect imageRect = CGRectMake(0, 0, b*widthImg, b*heightImg);
        [img drawInRect:imageRect];
        imgNew = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return imgNew;

    }
    
    return img;
}
/**
 *  对图片尺寸进行压缩--
 */
-(UIImage*)imageScaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [self drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}

+ (UIImage *)imageScalingSize:(CGSize)size withImage:(UIImage *)img
{
    CGFloat h = size.height;
    CGFloat w = size.width;
    
    CGFloat heightImg = img.size.height;
    CGFloat widthImg = img.size.width;
//    if(heightImg > h && widthImg > w)
//    {
        UIImage *imgNew = [[UIImage alloc] init];
        
        float b = (float)w/widthImg > (float)h/heightImg ? (float)w/widthImg : (float)h/heightImg;
        CGSize itemSize = CGSizeMake(b*widthImg, b*heightImg);
        UIGraphicsBeginImageContext(itemSize);
        CGRect imageRect = CGRectMake(0, 0, b*widthImg, b*heightImg);
        [img drawInRect:imageRect];
        imgNew = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return imgNew;
        
//    }else
    return img;
}

+ (UIImage *)imageShrinkMinSize:(CGSize)size withImage:(UIImage *)img
{
    CGFloat h = size.height;
    CGFloat w = size.width;
    
    CGFloat heightImg = img.size.height;
    CGFloat widthImg = img.size.width;
    if(heightImg > h && widthImg > w)
    {
        UIImage *imgNew = [[UIImage alloc] init];
        
        float b = (float)w/widthImg < (float)h/heightImg ? (float)w/widthImg : (float)h/heightImg;
        CGSize itemSize = CGSizeMake(b*widthImg, b*heightImg);
        UIGraphicsBeginImageContext(itemSize);
        CGRect imageRect = CGRectMake(0, 0, b*widthImg, b*heightImg);
        [img drawInRect:imageRect];
        imgNew = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return imgNew;
        
    }
    
    return img;
}

+ (UIImage *)getPartOfImage:(UIImage *)img rect:(CGRect)partRect
{
    CGImageRef imageRef = img.CGImage;
    CGImageRef imagePartRef = CGImageCreateWithImageInRect(imageRef, partRect);
    UIImage *retImg = [UIImage imageWithCGImage:imagePartRef];
    CGImageRelease(imagePartRef);
    return retImg;
}

- (UIImage *)imageByScalingToSize:(CGSize)targetSize
{
    UIImage *sourceImage = self;
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) ==NO) {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if (widthFactor < heightFactor)
            scaleFactor = widthFactor;
        else
            scaleFactor = heightFactor;
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        // center the image
        if (widthFactor < heightFactor) {
            
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        } else if (widthFactor > heightFactor) {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    // this is actually the interesting part:
    UIGraphicsBeginImageContext(targetSize);
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [sourceImage drawInRect:thumbnailRect];
    newImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    if(newImage == nil)
        NSLog(@"could not scale image");
    return newImage ;
}

#pragma mark -
#pragma mark ==================================
/**
 *  根据图片url获取图片尺寸
 */
+(CGSize)getImageSizeWithURL:(id)imageURL
{
    NSURL* URL = nil;
    if([imageURL isKindOfClass:[NSURL class]]){
        URL = imageURL;
    }
    if([imageURL isKindOfClass:[NSString class]]){
        URL = [NSURL URLWithString:imageURL];
    }
    if(URL == nil)
    {
        return CGSizeZero;                  // url不正确返回CGSizeZero
    }
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:URL];
    NSString* pathExtendsion = [URL.pathExtension lowercaseString];
    
    CGSize size = CGSizeZero;
    if([pathExtendsion isEqualToString:@"png"]){
        size =  [self getPNGImageSizeWithRequest:request];
    }
    else if([pathExtendsion isEqual:@"gif"])
    {
        size =  [self getGIFImageSizeWithRequest:request];
    }
    else{
        size = [self getJPGImageSizeWithRequest:request];
    }
    if(CGSizeEqualToSize(CGSizeZero, size))                    // 如果获取文件头信息失败,发送异步请求请求原图
    {
        NSError *error;
        NSData* data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:URL] returningResponse:nil error:&error];
        
        UIImage* image = [UIImage imageWithData:data];
        if(image)
        {
            size = image.size;
        }
    }
    return size;
}
//  获取PNG图片的大小
+(CGSize)getPNGImageSizeWithRequest:(NSMutableURLRequest*)request
{
    NSLog(@"%@",[request.URL absoluteString]);
    UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:[request.URL absoluteString]];
    
    if (image)
    {
        NSLog(@"h**@@@***>%f",image.size.height);
        NSLog(@"w***@@@**>%f",image.size.width);
        return image.size;
    }
    else
    {
        NSData * data = [NSData dataWithContentsOfURL:request.URL];
        UIImage *image = [UIImage imageWithData:data];
        
        NSLog(@"h*****>%f",image.size.height);
        NSLog(@"w*****>%f",image.size.width);
        return image.size;
    }
    return CGSizeMake(0, 0);
}
//  获取gif图片的大小
+(CGSize)getGIFImageSizeWithRequest:(NSMutableURLRequest*)request
{
    [request setValue:@"bytes=6-9" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if(data.length == 4)
    {
        short w1 = 0, w2 = 0;
        [data getBytes:&w1 range:NSMakeRange(0, 1)];
        [data getBytes:&w2 range:NSMakeRange(1, 1)];
        short w = w1 + (w2 << 8);
        short h1 = 0, h2 = 0;
        [data getBytes:&h1 range:NSMakeRange(2, 1)];
        [data getBytes:&h2 range:NSMakeRange(3, 1)];
        short h = h1 + (h2 << 8);
        return CGSizeMake(w, h);
    }
    return CGSizeZero;
}
//  获取jpg图片的大小
+(CGSize)getJPGImageSizeWithRequest:(NSMutableURLRequest*)request
{
    NSLog(@"%@",[request.URL absoluteString]);
    UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:[request.URL absoluteString]];
    
    if (image)
    {
        NSLog(@"h**@@@***>%f",image.size.height);
        NSLog(@"w***@@@**>%f",image.size.width);
        return image.size;
    }
    else
    {
        NSData * data = [NSData dataWithContentsOfURL:request.URL];
        UIImage *image = [UIImage imageWithData:data];
        
        NSLog(@"h*****>%f",image.size.height);
        NSLog(@"w*****>%f",image.size.width);
        return image.size;
    }
    return CGSizeMake(0, 0);
}

@end
