//
//  NSDate+dataWithTimeIntervel.m
//  lingdaozhe
//
//  Created by aliviya on 16/5/26.
//  Copyright © 2016年 bckj. All rights reserved.
//

#import "NSString+dataWithTimeIntervel.h"

@implementation NSString (dataWithTimeIntervel)

+(NSString *)dataWithTimeIntevel:(NSString *)timeIntervel{
    NSDate *createDate = [NSDate dateWithTimeIntervalSince1970:[timeIntervel floatValue]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:ss";
    NSString *createString = [formatter stringFromDate:createDate];
    return createString;
}

@end
