//
//  WithdrawApplyModel.h
//  才标网
//
//  Created by caohouhong on 17/3/18.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WithdrawApplyModel : NSObject

///* 状态-处理中 */
//public static final short STATE_DEALING = 1;
///* 状态-处理完毕(提现成功) */
//public static final short STATE_SUCCESS = 2;
///* 状态-已关闭(失败)*/
//public static final short STATE_FAILED = 9;


/**
 
 返回用例：{
 "state": 0,
 "fieldErrors": [],
 "data": {
 "pageSize": 10,
 "start": 0,
 "data": [
     {
     "applyId": 9,
     "applyCode": "2015112000006",
     "memberId": 8,
     "applyAmount": 1500,
     "alipayAccount": "15906182057",
     "ownerName": "陈",
     "state": 1,
     "createdTime": 1448007062,
     "applyAmountYuan": 15
     }
     ],
 "totalCount": 1
 }
 }
 
 */
/* 申请标识 */
@property(nonatomic, assign)int applyId;
/* 提现流水号 */
@property(nonatomic, copy)NSString *applyCode;
/* 提现金额(分) */
@property(nonatomic, assign)int applyAmount;
/* 支付宝账户 */
@property(nonatomic, copy)NSString *alipayAccount;
/* 提现者姓名 */
@property(nonatomic, copy)NSString *ownerName;
/* 状态，取值见常量 */
@property(nonatomic, assign)int state;
/* 申请会员标识 */
@property(nonatomic, assign)int memberId;
/* 申请会员昵称 */
@property(nonatomic, copy)NSString *nickName;
/* 申请时戳 */
@property(nonatomic, assign)int createdTime;
/* 处理人标识 */
@property(nonatomic, assign)int handlerId;
/* 处理人姓名 */
@property(nonatomic, copy)NSString *handlerName;
/* 处理时戳 */
@property(nonatomic, assign)int handledTime;
/* 备注/原因 */
@property(nonatomic, copy)NSString *remark;

/*=========== 冗余 ===============*/
/* 提现金额(元) */
@property(nonatomic, assign)double applyAmountYuan;
@end
