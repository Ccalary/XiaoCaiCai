//
//  ProductModel.h
//  才标网
//
//  Created by baichun on 17/3/31.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductModel : NSObject
@property (nonatomic, copy) NSString *product_id;//商品id
@property (nonatomic, copy) NSString *thumb;//商品缩略图
@property (nonatomic, copy) NSString *name;//商品名称
@property (nonatomic, copy) NSString *descri;//商品描述
@property (nonatomic, copy) NSString *price;//商品价格
@property (nonatomic, copy) NSString *special;//商品促销价格
@property (nonatomic, copy) NSString *tax;
@property (nonatomic, copy) NSString *rating;
/*
 * 备注：price和special 只会一个有值，不会同时存在。
 如果  price有值special为false，商品为正常价格；
 如果  special有值price为false，商品为促销价格；
 * */

@property (nonatomic, copy) NSString *model;//商品型号
@property (nonatomic, copy) NSString *reward;//奖励积分，购买商品得到的积分
@property (nonatomic, copy) NSString *points;//消费积分，可以使用积分购买的商品
@property (nonatomic, copy) NSString *product_quantity;//商品数量
@property (nonatomic, copy) NSString *stock;//库存状态
@property (nonatomic, copy) NSString *popup;//某 图？？
@property (nonatomic, copy) NSString *price_format;//
@property (nonatomic, copy) NSString *special_format;
@property (nonatomic, copy) NSString *minimum;//最小购买数量
//private String[] images; //其它多图
//private String[] attribute_groups;//属性组 暂不使用
@end
