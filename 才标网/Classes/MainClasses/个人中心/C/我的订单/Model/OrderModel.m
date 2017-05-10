//
//  OrderModel.m
//  才标网
//
//  Created by caohouhong on 17/4/7.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "OrderModel.h"

@implementation OrderModel

+ (NSDictionary *)objectClassInArray
{
    return @{@"products":@"OrderProductModel",@"histories":@"OrderStateHistoryModel"};
}
@end
