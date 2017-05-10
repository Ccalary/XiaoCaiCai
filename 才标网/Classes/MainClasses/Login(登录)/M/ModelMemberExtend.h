//
//  ModelMemberExtend.h
//  才标网
//
//  Created by caohouhong on 17/3/21.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelMemberExtend : NSObject
/* 大师会员标识*/
@property(nonatomic, assign) int memberId;
/* 起名特点 */
@property(nonatomic, copy) NSString *teDian;
/* 大师简介 */
@property(nonatomic, copy) NSString *introduce;
/* 发布的悬赏任务数 */
@property(nonatomic, assign) int xuanShangNum;
/* 悬赏总金额(分) */
@property(nonatomic, assign) int xuanShangTotalPrice;
/* 发布的大师任务数 */
@property(nonatomic, assign) int daShiTaskNum;
/* 成功起名次数 */
@property(nonatomic, assign) int daShiTaskNum2;
/* 大师任务总金额(分) */
@property(nonatomic, assign) int daShiTaskTotalPrice;
/* 大师分成比例 -范围是0.01~1，为1表示全部都给大师。0表示不给大师一分钱*/
@property(nonatomic, assign) double earnPrecent;
/* 投稿数 */
@property(nonatomic, assign) int touGaoTotalNum;
/* 采纳数 */
@property(nonatomic, assign) int usedTotalNum;
/* 总收入 */
@property(nonatomic, assign) int totalIncomePrice;
/* 所在省标识 */
@property(nonatomic, assign) int provinceId;
/* 所在省名 */
@property(nonatomic, copy) NSString *provinceName;
/* 所在市标识 */
@property(nonatomic, assign)  int cityId;
/* 所在市名 */
@property(nonatomic, copy) NSString *cityName;
/* 未读推送消息数 */
@property(nonatomic, assign) int messageNum;

/* 未读悬赏任务消息数 */
@property(nonatomic, assign) int xuanShangTaskMsgNum;
/* 未读大师任务消息数 */
@property(nonatomic, assign) int daShiTaskMsgNum;
/* 未读我的投稿消息数 */
@property(nonatomic, assign) int myTouGaoMsgNum;

/* 未读我是大师消息数 */
@property(nonatomic, assign) int iAmDaShiMsgNum;
/* 未读复查结果消息数 */
@property(nonatomic, assign) int recheckMsgNum;
/* 账户余额（元） */
@property(nonatomic, assign) double accountBalanceYuan;
/* 是否已认证  1:已认证 0：未认证*/
@property(nonatomic, assign) int isAuthApply;

@end
