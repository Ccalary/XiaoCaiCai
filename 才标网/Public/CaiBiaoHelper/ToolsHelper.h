//
//  ToolsHelper.h
//  才标网
//
//  Created by caohouhong on 17/3/17.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToolsHelper : NSObject
/**
 改变某些字的颜色

 @param str 改变的字体
 @param result 全字体
 @param color 改变的字体颜色
 @return str
 */
+ (NSMutableAttributedString *)changeSomeText:(NSString *)str inText:(NSString *)result withColor:(UIColor *)color;

// log NSSet with UTF8
// if not ,log will be \Uxxx
+ (NSString *)logDic:(NSDictionary *)dic;


// Get IP Address
+(NSString *)getIPAddress;
/**
 计算tag高度

 @param array 字符串数组
 @param width tagView宽度
 @param scale 圆角大小
 @return 高度
 */
+(NSString *)tagHeightWithArray:(NSArray *)array  andWidht:(CGFloat )width andCornerScale:(double) scale;

@end
