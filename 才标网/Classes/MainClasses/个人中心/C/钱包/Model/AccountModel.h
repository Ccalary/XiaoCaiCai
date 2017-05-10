//
//  AccountModel.h
//  才标网
//
//  Created by caohouhong on 17/3/18.
//  Copyright © 2017年 李强. All rights reserved.
//  会员帐户流水

#import <Foundation/Foundation.h>

@interface AccountModel : NSObject
///* 状态-普通 */
//public static final short STATE_NORMAL = 0;
///* 状态-已删除 */
//public static final short STATE_DELETE = 9;
//
///* 支出-变动类型-提现申请 */
//public static final short FLOWTYPE_WITHDRAWCASH_APPLY = 1;
///* 收入-变动类型-提现失败，退还提现金额 */
//public static final short FLOWTYPE_WITHDRAWCASH_FAILED = 2;
///* 收入-变动类型-投稿被采纳 */
//public static final short FLOWTYPE_TOUGAO_CAINA = 3;
///* 收入-变动类型-悬赏到期，退还金额 */
//public static final short FLOWTYPE_REBACK_XUANSHANG_PRICE = 4;
///* 收入-变动类型-平分赏金 */
//public static final short FLOWTYPE_SHARE_XUANSHANG_PRICE = 5;
///* 收入-变动类型-大师被邀请起名 */
//public static final short FLOWTYPE_DASHI_QIMING_PRICE = 6;
//
//
///* 变动原因-会员申请提现*/
//public static final String FLOWTYPE_WITHDRAWCASH_APPLY_REASON = "申请提现";
///* 变动原因详述-会员申请提现 */
//public static final String FLOWTYPE_WITHDRAWCASH_APPLY_REASON_DETAIL = "申请提现";
//
///* 变动原因-会员提现失败*/
//public static final String FLOWTYPE_WITHDRAWCASH_APPLY_FAIL_REASON = "提现失败";
///* 变动原因详述-会员提现失败 */
//public static final String FLOWTYPE_WITHDRAWCASH_APPLY_FAIL_REASON_DETAIL = "提现失败";
//
///* 变动原因-投稿被采纳*/
//public static final String FLOWTYPE_TOUGAO_CAINA_REASON = "稿费";
///* 变动原因详述-投稿被采纳 */
//public static final String FLOWTYPE_TOUGAO_CAINA_REASON_DETAIL = "投稿被采纳";
//
///* 变动原因-退还悬赏金额*/
//public static final String FLOWTYPE_REBACK_XUANSHANG_PRICE_REASON = "退还赏金";
///* 变动原因详述-退还悬赏金额 */
//public static final String FLOWTYPE_REBACK_XUANSHANG_PRICE_REASON_DETAIL = "悬赏到期，退还金额";
//
///* 变动原因-平分赏金*/
//public static final String FLOWTYPE_DASHI_QIMING_PRICE_REASON = "稿费";
///* 变动原因详述-平分赏金 */
//public static final String FLOWTYPE_DASHI_QIMING_PRICE_REASON_DETAIL = "悬赏到期，平分赏金";
//
///* 变动原因-大师被邀请起名*/
//public static final String FLOWTYPE_SHARE_XUANSHANG_PRICE_REASON = "大师稿费";
///* 变动原因详述-大师被邀请起名 */
//public static final String FLOWTYPE_SHARE_XUANSHANG_PRICE_REASON_DETAIL = "大师被邀请起名";
//


/**
 "pageSize": 10,
 "start": 0,
 "data": [
   {
    "flowId": 10,
    "memberId": 8,
    "flowType": 4,
    "flowAmount": -1500,
    "accountBalance": 500,
    "cashApplyId": 9,
    "createdTime": 1448007062,
    "day": 20,
    "month": 11,
    "state": 0,
    "flowAmountYuan": -15
    }
 ],
 "totalCount": 1

 */

/* 流水标识 */
@property(nonatomic, assign)int flowId;
/* 会员标识 */
@property(nonatomic, assign)int memberId;
/* 变动类型，取值见常量 */
@property(nonatomic, assign)short flowType;
/* 变动金额(分) */
@property(nonatomic, assign)int flowAmount;
/* 变动后余额 (分)*/
@property(nonatomic, assign)int accountBalance;
/* 任务模块，取值见EntityType中的常量 */
@property(nonatomic, assign)int taskMode;
/* 任务标识 */
@property(nonatomic, assign)int taskId;
/* 复查标识 */
@property(nonatomic, assign)int recheckId;
/* 提现申请标识 */
@property(nonatomic, assign)int cashApplyId;
/* 分成基数价(分) */
@property(nonatomic, assign)int basePrice;
/* 分成比例 */
@property(nonatomic, assign)double earnPrecent;
/* 变动原因 */
@property(nonatomic, copy)NSString *reason;
/* 变动原因描述 */
@property(nonatomic, copy)NSString *reasonDetail;

/*
 * 冗余属性针对不同的变动类型，含义不同：
 *
 */
/* 冗余属性1 */
@property(nonatomic, copy)NSString *attr1;
/* 冗余属性2 */
@property(nonatomic, copy)NSString *attr2;
/* 冗余属性3 */
@property(nonatomic, copy)NSString *attr3;
/* 冗余属性4 */
@property(nonatomic, copy)NSString *attr4;
/* 冗余属性5 */
@property(nonatomic, copy)NSString *attr5;
/* 创建时戳 */
@property(nonatomic, assign)int createdTime;
/* 日期，yyyyMMdd */
@property(nonatomic, assign)int day;
/* 日期所在月，yyyyMM */
@property(nonatomic, assign)int month;
/* 状态，预留 */
@property(nonatomic, assign)int state;

/*=========== 冗余 ===============*/
/* 变动金额(元) */
@property(nonatomic, assign)double flowAmountYuan;
/* 变动后余额 (元)*/
@property(nonatomic, assign)double accountBalanceYuan;
@end
