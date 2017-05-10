//
//  NSDictionary+TSLogHelper.m
//  大苏精密
//
//  Created by 唐硕 on 16/7/29.
//  Copyright © 2016年 唐硕. All rights reserved.
//

#import "NSDictionary+TSLogHelper.h"

@implementation NSDictionary (TSLogHelper)

#if DEBUG 

-(NSString *)descriptionWithLocale:(nullable id)locale {
    return [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
}

#endif

@end
