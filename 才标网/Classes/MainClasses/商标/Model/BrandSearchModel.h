//
//  BrandSearchModel.h
//  才标网
//
//  Created by baichun on 17/3/31.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BrandSearchModel : NSObject
/*
 
 "intcls" : "1",
 "tmanme" : "LIGOOD",
 "follow" : "false",
 "cxkey" : "16699129",
 "image" : "http:\/\/uat.58caibiao.com\/image\/catalog\/trademark\/16699129.jpg",
 "appdate" : "2015-04-13",
 "appname" : "青岛海利信农用化学有限公司",
 "tmlaw" : "商标注册申请等待驳回通知发文"
 */


@property (nonatomic, copy) NSString  *cxkey;//注册号
@property (nonatomic, copy) NSString  *intcls;//国际分类
@property (nonatomic, copy) NSString  *tmname;//商标名称
@property (nonatomic, copy) NSString  *appdate;//申请日期
@property (nonatomic, copy) NSString  *appname;//申请人中文名
@property (nonatomic, copy) NSString  *tmlaw;//当前流程状态
@property (nonatomic, copy) NSString  *image;//商标图片url地址
@property (nonatomic, copy) NSString  *appaddr;//申请人地址
@property (nonatomic, copy) NSString  *csggqh;//初审公告期号
@property (nonatomic, copy) NSString  *csdate;//初审日期
@property (nonatomic, copy) NSString  *regIssue;//注册公告期号
@property (nonatomic, copy) NSString  *regdate;//注册日期
@property (nonatomic, copy) NSString  *gjzcrq;//国际注册日期
@property (nonatomic, copy) NSString  *agentname;//代理机构
//核定使用商品或服务集合
@property (nonatomic, strong) NSArray *goods;
//商标流程集合
@property (nonatomic, strong) NSArray *flow;

@property (nonatomic, copy) NSString  *follow;//是否收藏
@end
