//
//  UtilString.m
//  lingdaozhe
//
//  Created by liqiang on 16/4/20.
//  Copyright © 2016年 bckj. All rights reserved.
//

#import "UtilString.h"
//#import "CheckMethod.h"
@implementation UtilString

/**
 *  判断是否为空字符串
 */
+ (NSString *)getNoNilString:(NSString *)str
{
    if (!str||[str isEqualToString:@""]||[str isEqualToString:@"null"])
    {
        return @"";
    }
    else
    {
        return [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
}

+ (NSString *)documentsPath:(NSString *)fileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:fileName];
}

+(BOOL)checkTeleIsCorrect:(NSString *)textstring{
    
    NSString *str=[UtilString getNoNilString:textstring];
    if (![str length]) {
        [LCProgressHUD showFailure:@"手机号为空"];
        return NO ;
    }
    
//    if (![CheckMethod validateMobile:str]) {
//        
//        [LCProgressHUD showFailure:@"手机号格式不正确"];
//        //        [MBProgressHUD showErrorHUDAddedToWindowWithErrorStr:@"手机号格式不正确" animated:YES showTime:TIPS_DELAY_TIME_NORMAL];
//        return NO;
//    }
    
    
    return YES;
}
+(NSString *)dateStringWithIntevel:(int)intervel{
    NSDate *tmpdate = [NSDate dateWithTimeIntervalSince1970:intervel];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy-MM-dd";
    NSString *string = [format stringFromDate:tmpdate];
    return string;
}
//yyyy-MM-dd HH:mm:ss
+(NSString *)dateStringDetail2WithIntevel:(int)intervel{
    NSDate *tmpdate = [NSDate dateWithTimeIntervalSince1970:intervel];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *string = [format stringFromDate:tmpdate];
    return string;
}
//今天的就用 十分秒  今天以前 用年月日
+(NSString *)dateStringDetailWithIntevel:(int)timestamp{
    
    NSString *returnString = @"";
    NSDate *sendTime = [NSDate dateWithTimeIntervalSince1970:timestamp];
    NSDate *nowTime = [NSDate date];
    NSDateFormatter *formate = [[NSDateFormatter alloc] init];
    
    [formate setDateFormat:@"yyyy/MM/dd"];
    
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];//设置成中国阳历
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSDateComponents *comps1 = [[NSDateComponents alloc] init];
    
    
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitDay |NSCalendarUnitHour |NSCalendarUnitMonth |NSCalendarUnitSecond | NSCalendarUnitWeekday|NSCalendarUnitMinute;//这句我也不明白具体时用来做什么。。。
    comps = [calendar components:unitFlags fromDate:nowTime];
    long day1 = [comps day];//获取日期对应的长整形字符串
    long year1 = [comps year];//获取年对应的长整形字符串
    long month1 = [comps month];//获取月对应的长整形字符串
    
    comps1 = [calendar components:unitFlags fromDate:sendTime];
    long day2 = [comps1 day];//获取日期对应的长整形字符串
    long year2 = [comps1 year];//获取年对应的长整形字符串
    long month2 = [comps1 month];//获取月对应的长整形字符串
    long hour = [comps1 hour];
    long minite = [comps1 minute];
    
    if (day1==day2&&year1==year2&&month1==month2) {
        NSLog(@"今天");
        if (minite<10) {
            returnString = [NSString stringWithFormat:@"%ld:0%ld",hour,minite];
            
        }else{
            returnString = [NSString stringWithFormat:@"%ld:%ld",hour,minite];
        }
    }else if(year1==year2){
        returnString = [NSString stringWithFormat:@"%02ld月%02ld日 %02ld:%02ld",month2,day2,hour,minite];
        
    }else{
        returnString = [NSString stringWithFormat:@"%02ld年%02ld月%02ld日",year2,month2,day2];
    }
    return returnString;
    
}



/*获取yyyy.MM.dd hh:mm:ss格式的时间*/
+(NSString *)getTimeFormmatterHMS:(NSNumber *)time formatStr:(NSString *)timeFormatStr
{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    if (timeFormatStr &&![timeFormatStr isEqualToString:@""]) {
        [formatter setDateFormat:timeFormatStr];
    }else{
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    NSTimeInterval orderTime=[time doubleValue];
    NSDate *orderTimedate=[NSDate dateWithTimeIntervalSince1970:orderTime];
    return [NSString stringWithFormat:@"%@",[formatter stringFromDate:orderTimedate]];
}


@end
