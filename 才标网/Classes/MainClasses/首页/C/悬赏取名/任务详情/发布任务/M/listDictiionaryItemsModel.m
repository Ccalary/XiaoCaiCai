//
//  listDictiionaryItemsModel.m
//  才标网
//
//  Created by baichun on 17/3/22.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "listDictiionaryItemsModel.h"

@implementation listDictiionaryItemsModel

//关键字替换
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"sid":@"id"};
}

@end
