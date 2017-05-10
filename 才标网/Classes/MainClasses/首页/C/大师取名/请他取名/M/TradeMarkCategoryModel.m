//
//  TradeMarkCategoryModel.m
//  才标网
//
//  Created by caohouhong on 17/3/22.
//  Copyright © 2017年 李强. All rights reserved.
//  

#import "TradeMarkCategoryModel.h"

@implementation TradeMarkCategoryModel

+ (NSDictionary *)objectClassInArray
{
    return @{@"children":@"TradeMarkCategoryModel"};
}

//替换关键字
+(NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"sid" : @"id"};
}

@end
