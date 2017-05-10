//
//  CompanyTypeModel.m
//  才标网
//
//  Created by caohouhong on 17/4/19.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "CompanyTypeModel.h"

@implementation CompanyTypeModel

//关键字替换
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"sid":@"id",@"descript":@"description"};
}
@end
