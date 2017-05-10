//
//  NSDate+LQCategory.m
//  lingdaozhe
//
//  Created by liqiang on 16/4/27.
//  Copyright © 2016年 bckj. All rights reserved.
//

#import "NSDate+LQCategory.h"
#import "NSDateFormatter+Category.h"

@implementation NSDate (LQCategory)


/*距离当前的时间间隔描述*/
- (NSString *)timeIntervalDescription
{
    NSTimeInterval timeInterval = [self timeIntervalSinceNow];
    
    if (timeInterval > -60 && timeInterval < 0) {
        return @"刚刚";
    } else if (timeInterval > -3600 && timeInterval < 0) {
        return [NSString stringWithFormat:@"%.f分钟前", -timeInterval / 60];
    } else if (timeInterval > -86400 && timeInterval < 0) {
        return [NSString stringWithFormat:@"%.f小时前", -timeInterval / 3600];
    } else if (timeInterval > -2592000 && timeInterval < 0) {//30天内
        return [NSString stringWithFormat:@"%.f天前", -timeInterval / 86400];
    } else if (timeInterval > -31536000 && timeInterval < 0) {//30天至1年内
        NSDateFormatter *dateFormatter = [NSDateFormatter dateFormatterWithFormat:@"MM-dd"];
        return [dateFormatter stringFromDate:self];
    } else if (timeInterval < -31536000)  {
        return [NSString stringWithFormat:@"%.f年前", -timeInterval / 31536000];
    }else if (timeInterval < 60) {
        return @"马上";
    } else if (timeInterval < 3600) {
        return [NSString stringWithFormat:@"%.f分钟后", timeInterval / 60];
    } else if (timeInterval < 86400) {
        return [NSString stringWithFormat:@"%.f小时后", timeInterval / 3600];
    } else if (timeInterval < 2592000) {
        return [NSString stringWithFormat:@"%.f天后", timeInterval / 86400];
    } else if (timeInterval < 31536000) {
        NSDateFormatter *dateFormatter = [NSDateFormatter dateFormatterWithFormat:@"MM-dd"];
        return [dateFormatter stringFromDate:self];
    } else {
        return [NSString stringWithFormat:@"%.f年后", timeInterval / 31536000];
    }
}

+ (NSString *)getTimeStatus:(NSString *)timeStamp
{
    NSTimeInterval distance = [[NSDate date] timeIntervalSince1970] - [timeStamp doubleValue];
    
    NSString *timeStatusStr;
    
    if (distance < 60) {
        timeStatusStr = [NSString stringWithFormat:@"%@",@"刚刚"];
    }
    else if (distance < 60 * 60) {
        int distanceInt = distance / 60;
        timeStatusStr = [NSString stringWithFormat:@"%d %@", distanceInt, @"分钟前"];
    }
    else if (distance < 60 * 60 * 24) {
        int distanceInt = distance / 60 / 60;
        timeStatusStr = [NSString stringWithFormat:@"%d %@", distanceInt, @"小时前"];
    }
    else if (distance < 60 * 60 * 24 * 2) {
        timeStatusStr = [NSString stringWithFormat:@"%@", @"昨天"];
    }else {
        
        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
        dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
        
        if (distance < 60 * 60 * 24 * 365){
            [dateFormatter setDateFormat:@"MM月dd日"];
        }else {
             [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
        }
        NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeStamp doubleValue]];
        timeStatusStr = [dateFormatter stringFromDate:date];
    }
    return timeStatusStr;
}

//未来时间的显示
+ (NSString *)getTimeStatusWithFutureTime:(double)timeStamp
{
    NSTimeInterval distance =  timeStamp  - [[NSDate date] timeIntervalSince1970];
    
    NSString *timeStatusStr;
    
    if (distance < 0){
        timeStatusStr = [NSString stringWithFormat:@"%@",@"已经"];
    }else if (distance < 60) {
        timeStatusStr = [NSString stringWithFormat:@"%@",@"马上"];
    }
    else if (distance < 60 * 60) {
        int distanceInt = distance / 60;
        timeStatusStr = [NSString stringWithFormat:@"%d %@", distanceInt, @"分钟后"];
    }
    else if (distance < 60 * 60 * 24) {
        int distanceInt = distance / 60 / 60;
        timeStatusStr = [NSString stringWithFormat:@"%d %@", distanceInt, @"小时后"];
    }
    else if (distance < 60 * 60 * 24 * 2) {
        timeStatusStr = [NSString stringWithFormat:@"%@", @"明天"];
    }else if (distance < 60 * 60 * 24 * 15) {
        int distanceInt = distance / 60 / 60 / 24;
        timeStatusStr = [NSString stringWithFormat:@"%d %@", distanceInt, @"天后"];
    }else {
        
        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
        dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
        
        if (distance < 60 * 60 * 24 * 365){
            [dateFormatter setDateFormat:@"MM月dd日"];
        }else {
            [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
        }
        NSDate* date = [NSDate dateWithTimeIntervalSince1970:timeStamp];
        timeStatusStr = [dateFormatter stringFromDate:date];
    }
    return timeStatusStr;
}


/**
 *  秒转分返回string类型
 */
+ (NSString*)TimeformatFromSeconds:(long)seconds
{
    long hour = seconds/7200;
    long minute = (seconds%3600)/60;
    long second = seconds%60;
    
    //format of hour
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",hour];
    //format of minute
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",minute];
    //format of second
    NSString *str_second = [NSString stringWithFormat:@"%02ld",second];
    //format of time
    
    NSString *format_time;
    
    if (hour)
    {
        format_time = [NSString stringWithFormat:@"%@:%@:%@",str_hour,str_minute,str_second];
    }
    else
    {
        format_time = [NSString stringWithFormat:@"%@:%@",str_minute,str_second];
    }
    
    return format_time;
}

/**
 *  时戳转string
 *
 *  @param timeFormatStr 时间格式
 *  @param time          时戳
 */
+ (NSString *)dateWithTimeStamp:(long long)timeStamp dateFormat:(NSString *)dateFormat
{
    if (!dateFormat.length)
    {
        dateFormat = @"yyyy-MM-dd HH:mm:ss";
    }
    
    NSDate *detaildate = [NSDate dateWithTimeIntervalInMilliSecondSince1970:timeStamp];
    return [NSDate dateStringWithTimeDate:detaildate dateFormat:dateFormat];
}

/**
 *  NSDate转string
 *
 *  @param timeDate   date
 *  @param dateFormat 时间格式
 *
 *  @return
 */
+ (NSString *)dateStringWithTimeDate:(NSDate *)timeDate dateFormat:(NSString *)dateFormat
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:dateFormat];
    
    NSString *currentDateStr = [dateFormatter stringFromDate: timeDate];
    
    return currentDateStr;
    
}

/**
 *  时戳转NSDate
 *
 *  @param timeIntervalInMilliSecond 时戳
 */
+ (NSDate *)dateWithTimeIntervalInMilliSecondSince1970:(double)timeIntervalInMilliSecond
{
    NSDate *ret = nil;
    double timeInterval = timeIntervalInMilliSecond;
    // judge if the argument is in secconds(for former data structure).
    if(timeIntervalInMilliSecond > 140000000000) {
        timeInterval = timeIntervalInMilliSecond / 1000;
    }
    ret = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    return ret;
}

+ (NSString*)getChineseCalendarWithDate:(NSDate *)date
{
    NSArray *chineseYears = [NSArray arrayWithObjects:
                             @"甲子", @"乙丑", @"丙寅", @"丁卯",  @"戊辰",  @"己巳",  @"庚午",  @"辛未",  @"壬申",  @"癸酉",
                             @"甲戌",   @"乙亥",  @"丙子",  @"丁丑", @"戊寅",   @"己卯",  @"庚辰",  @"辛己",  @"壬午",  @"癸未",
                             @"甲申",   @"乙酉",  @"丙戌",  @"丁亥",  @"戊子",  @"己丑",  @"庚寅",  @"辛卯",  @"壬辰",  @"癸巳",
                             @"甲午",   @"乙未",  @"丙申",  @"丁酉",  @"戊戌",  @"己亥",  @"庚子",  @"辛丑",  @"壬寅",  @"癸丑",
                             @"甲辰",   @"乙巳",  @"丙午",  @"丁未",  @"戊申",  @"己酉",  @"庚戌",  @"辛亥",  @"壬子",  @"癸丑",
                             @"甲寅",   @"乙卯",  @"丙辰",  @"丁巳",  @"戊午",  @"己未",  @"庚申",  @"辛酉",  @"壬戌",  @"癸亥", nil];
    
    NSArray *chineseMonths=[NSArray arrayWithObjects:
                            @"正月", @"二月", @"三月", @"四月", @"五月", @"六月", @"七月", @"八月",
                            @"九月", @"十月", @"冬月", @"腊月", nil];
    
    NSArray *chineseDays=[NSArray arrayWithObjects:
                          @"初一", @"初二", @"初三", @"初四", @"初五", @"初六", @"初七", @"初八", @"初九", @"初十",
                          @"十一", @"十二", @"十三", @"十四", @"十五", @"十六", @"十七", @"十八", @"十九", @"二十",
                          @"廿一", @"廿二", @"廿三", @"廿四", @"廿五", @"廿六", @"廿七", @"廿八", @"廿九", @"三十",  nil];
    
    NSCalendar *localeCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    
    NSDateComponents *localeComp = [localeCalendar components:unitFlags fromDate:date];
    
    NSLog(@"%zd_%zd_%zd",localeComp.year,localeComp.month,localeComp.day);
    
    NSString *y_str = [chineseYears objectAtIndex:localeComp.year-1];
    NSString *m_str = [chineseMonths objectAtIndex:localeComp.month-1];
    NSString *d_str = [chineseDays objectAtIndex:localeComp.day-1];
    
    NSString *chineseCal_str =[NSString stringWithFormat: @"%@_%@_%@",y_str,m_str,d_str];
    
    return chineseCal_str;  
}

+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate
{
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"星期天", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    return [weekdays objectAtIndex:theComponents.weekday];
}

@end
