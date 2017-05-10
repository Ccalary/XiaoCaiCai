//
//  UtilString.h
//  lingdaozhe
//
//  Created by liqiang on 16/4/20.
//  Copyright © 2016年 bckj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UtilString : NSObject

/**
 *  判断是否为空字符串
 */
+ (NSString *)getNoNilString:(NSString *)str;
+ (NSString *)documentsPath:(NSString *)fileName;
//检查手机号是否是正确的手机号

+(BOOL)checkTeleIsCorrect:(NSString *)textstring;

//根据秒数获取时间字符串  yyyy-MM-dd
+(NSString *)dateStringWithIntevel:(int)intervel;
//hh:ss   or yyyy-MM-dd

+(NSString *)dateStringDetailWithIntevel:(int)timestamp;
+(NSString *)dateStringDetail2WithIntevel:(int)intervel;



/*获取yyyy.MM.dd hh:mm:ss格式的时间*/
+(NSString *)getTimeFormmatterHMS:(NSNumber *)time formatStr:(NSString *)timeFormatStr;

@end
