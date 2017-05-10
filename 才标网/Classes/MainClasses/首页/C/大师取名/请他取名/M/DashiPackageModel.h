//
//  DashiPackageModel.h
//  才标网
//
//  Created by caohouhong on 17/3/23.
//  Copyright © 2017年 李强. All rights reserved.
//  大师套餐实体类

#import <Foundation/Foundation.h>

@interface DashiPackageModel : NSObject

///* 状态 -新建 */
//public static final short STATE_NEW = 0;
///* 状态 -已删除 */
//public static final short STATE_DELETED = 9;

/* 套餐标识 */
@property(nonatomic, assign) int daShiPackageId;
/* 状态，取值见本类常量 */
@property(nonatomic, assign) int state;
/* 套餐价格(分) */
@property(nonatomic, assign) int price;
/* 套餐价格(元) */
@property(nonatomic, assign) double priceYuan;
/* 冗余--套餐图片路径集合 */
@property(nonatomic, strong) NSArray *picList;

@end
