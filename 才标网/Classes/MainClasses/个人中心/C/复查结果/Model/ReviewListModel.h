//
//  ReviewListModel.h
//  才标网
//
//  Created by caohouhong on 17/3/20.
//  Copyright © 2017年 李强. All rights reserved.
//  商标复查实体类

#import <Foundation/Foundation.h>

@interface ReviewListModel : NSObject
///* 状态-新建(未支付) */
//public static final short STATE_NEW  = 0;
///* 状态-待处理(已支付) */
//public static final short STATE_WAIT  = 1;
///* 状态-已处理 */
//public static final short STATE_HANDLED  = 2;

/* 商标复查标识 */
@property(nonatomic, assign)int recheckId;
/* 复查流水号*/
@property(nonatomic, copy)NSString *recheckCode;
/* 状态，取值见本类的常量 */
@property(nonatomic, assign)int state;
/* 商标名称*/
@property(nonatomic, copy)NSString *brandName;
/* 复查费用(分)*/
@property(nonatomic, assign)int price;
/* 支付方式，取值见ChangLiang中的定义 */
@property(nonatomic, assign)int payMode;
/* 提交人标识 */
@property(nonatomic, assign)int creatorId;
/* 提交人姓名 */
@property(nonatomic, copy)NSString *creatorName;
/* 提交时戳 */
@property(nonatomic, assign)int createdTimestamp;
/* 处理人标识 */
@property(nonatomic, assign)int handlerId;
/* 处理人姓名 */
@property(nonatomic, copy)NSString *handlerName;
/* 处理时戳 */
@property(nonatomic, assign)int handledTime;
/* 处理结果 */
@property(nonatomic, copy)NSString *resultText;
/* 处理结果图片 */
@property(nonatomic, copy)NSString *resultPic;
@end
