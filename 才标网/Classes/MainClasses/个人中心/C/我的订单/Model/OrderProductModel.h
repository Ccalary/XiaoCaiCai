//
//  OrderProductModel.h
//  才标网
//
//  Created by caohouhong on 17/4/7.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderProductModel : NSObject
@property (nonatomic, copy) NSString *name;//商品名称
@property (nonatomic, copy) NSString *price;//商品金额"￥0.01"
@property (nonatomic, copy) NSString *total;//商品总价
@property (nonatomic, copy) NSString *quantity;//商品购买数据
@property (nonatomic, copy) NSString *distribute_amount;
@property (nonatomic, copy) NSString *thumb; //图片

@end
