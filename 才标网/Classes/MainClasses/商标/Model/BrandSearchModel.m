//
//  BrandSearchModel.m
//  才标网
//
//  Created by baichun on 17/3/31.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "BrandSearchModel.h"

@implementation BrandSearchModel
+ (NSDictionary *)objectClassInArray
{
    return @{@"goods":@"BrandGoodsModel",@"flow":@"BrandFlowModel"};
}
@end
