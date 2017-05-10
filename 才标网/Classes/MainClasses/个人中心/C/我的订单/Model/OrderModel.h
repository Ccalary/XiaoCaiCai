//
//  OrderModel.h
//  才标网
//
//  Created by caohouhong on 17/4/7.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderModel : NSObject

@property (nonatomic, copy) NSString *invoice_no;//发票
@property (nonatomic, copy) NSString *order_id;//订单id
@property (nonatomic, copy) NSString *status;//订单支付状态 未支付 已支付
@property (nonatomic, copy) NSString *order_status;//订单支付状态 未支付 已支付
@property (nonatomic, copy) NSString *order_number;//订单编号，显示用的
@property (nonatomic, copy) NSString *date_added;//添加日期
@property (nonatomic, copy) NSString *payment_customer_name;//订单人姓名
@property (nonatomic, copy) NSString *payment_customer_telephone;//订单id
@property (nonatomic, copy) NSString *payment_company;//订单id
@property (nonatomic, copy) NSString *payment_method;//付款方式
@property (nonatomic, copy) NSString *comment;//订单留言
@property (nonatomic, copy) NSString *payment_address;//订单地址
@property (nonatomic, strong) NSArray *products;//订单商品集合
//private List<OrderTotals> totals;//订单费用清单集合
@property (nonatomic, strong) NSArray *histories;//订单状态列表集合
@end
