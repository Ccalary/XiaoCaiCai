//
//  ProductModel.m
//  才标网
//
//  Created by baichun on 17/3/31.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "ProductModel.h"

@implementation ProductModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"descri":@"description"};
}
@end
