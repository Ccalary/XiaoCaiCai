//
//  NSDate+LQCategory.h
//  lingdaozhe
//
//  Created by liqiang on 16/4/27.
//  Copyright © 2016年 bckj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (LQCategory)

/**
 *  秒转分返回string类型
 */
+ (NSString*)TimeformatFromSeconds:(long)seconds;


/// 过去时间戳转状态
+ (NSString *)getTimeStatus:(NSString *)timeStamp;


///未来时间状态的显示
+ (NSString *)getTimeStatusWithFutureTime:(double)timeStamp;

/**
 *  时戳转string
 */
+ (NSString *)dateWithTimeStamp:(long long)timeStamp dateFormat:(NSString *)dateFormat;

/**
 *  NSDate转string
 *
 *  @param timeDate   date
 *  @param dateFormat 时间格式
 *
 *  @return
 */
+ (NSString *)dateStringWithTimeDate:(NSDate *)timeDate dateFormat:(NSString *)dateFormat;

/**
 *  时戳转NSDate
 *
 *  @param timeIntervalInMilliSecond 时戳
 */
+ (NSDate *)dateWithTimeIntervalInMilliSecondSince1970:(double)timeIntervalInMilliSecond;

/**
 *  距离当前的时间间隔描述
 */
- (NSString *)timeIntervalDescription;


/**
 *  NSData 转农历字符串
 */
+ (NSString*)getChineseCalendarWithDate:(NSDate *)date;

/**
 *  NSData转中文星期几
 */
+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate;

@end
