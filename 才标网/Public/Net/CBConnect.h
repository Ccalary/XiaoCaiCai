//
//  CBConnect.h
//  才标网
//
//  Created by caohouhong on 17/3/15.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CBConnect : NSObject

//基本参数
+ (NSMutableDictionary *)getBaseRequestParams;

#pragma mark - ===========1.首页(Home)===========
/********************首页(Home)***********************/
//1.0首页信息
+(void)getHomeListHomeAll:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

//1.1任务广场
+(void)getHomeTasksquareInfo:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;
//1.2任务详情
+(void)getHomeTaskViewTask:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

//1.3投稿
+(void)getHomeTaskTouGao:(NSMutableDictionary *) params imageArray:(NSArray *)array isNone:(BOOL)isNone success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

//1.4发布任务
+(void)getHomeTaskAddTask:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

//1.5大师列表
+(void)getHomeListDashiMember:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

//1.6任务_发布任务
+(void)getHomeAddTask:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

///1.7大师套餐
+(void)getHomeListDashiPackages:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

///1.8商标其名行业分类_列出全部分类树形结构数据
+(void)getHomeListCateTree:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

//1.9采纳投稿
+(void)getHomeUseTouGao:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

//1.10编辑投稿
+(void)getModifTouGao:(NSMutableDictionary *) params imageArray:(NSArray *)array isNone:(BOOL)isNone success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;


//1.11举报
+(void)getHomeAddImpeach:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;


//1.12提问或回复
+(void)getHomeAskAnswer:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

//1.13删除投稿
+(void)getHomeRemove:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

//1.14自助起名(按关键字)
+(void)getTradeMarkNameByKeyWord:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

//1.15自助起名(按行业)
+(void)getTradeMarkNameByHangye:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

//1.16商品_买商标或商标咨询注册
+(void)getHomeBuyTradeMark:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

//1.17会员-个人信息详情(大师详情)
+(void)getHomeMemberViewMember:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

///1.18列出全部分类树形结构数据
+(void)getHomeTrademarkCompanyType:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;
#pragma mark -  =========2.商标(BRAND)============
/******************商标(BRAND)*********************/

//2.0 首页信息



///2.1文字检索
+(void)getBrandByword:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;
///2.2图片检索
+(void)getBrandByImage:(NSMutableDictionary *) params imageArray:(NSArray *)array isNone:(BOOL)isNone success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

///2.3商标分类
+(void)getProutServices:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

///2.4商品详情
+(void)getProutDetail:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;
///2.5商品推荐
+(void)getProutProducts:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

///2.6卖商标
+(void)getProutTrademark:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

///2.7商标详情
+(void)getBrandViewTradeMark:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

///2.8 添加订单
+(void)getBrandOrderAddOrder:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

///2.9商标申请
+(void)getTradeMarkApply:(NSMutableDictionary *) params imageArray:(NSArray *)array isNone:(BOOL)isNone success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

///2.10 商标收藏
+(void)getBrandCollectTradeMark:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

///2.11 取消商标收藏
+(void)getBrandUncollectTradeMark:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;
///2.12 商标广告
+(void)getBrandAdListads:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;
#pragma mark - ==========3.个人中心(USERCENTER)=========
/********************个人中心(USERCENTER)******************/
///3.0个人中心首页消息数据
+(void)getUserCenterUnreadMsgNum:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

///3.1 消息列表
+(void)getUserCenterMessageList:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

///3.2 消息已读
+(void)getUserCenterModifyMsgRead:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

///3.3 查看会员帐户
+(void)getUserCenterViewMemberAccount:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

///3.4 查看会员帐户流水历史
+(void)getUserCenterMemberAccountListFlows:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

///3.5 添加提现申请
+(void)getUserCenterAddMemberWithdrawCashApply:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

///3.6 列出某个会员的提现记录列表
+(void)getUserCenterListWithdrawCashApplies:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

///3.7 我_我的悬赏任务列表
+(void)getUserCenterListMyTasks:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

///3.8 我的投稿(我所有投过稿的悬赏任务列表)
+(void)getUserCenterListMyContributeTask:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

///3.9 我_我是大师(我作为大师时收到的任务列表)
+(void)getUserCenterListMyReceivedTask:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

///3.10 商标复查_我的商标复查列表
+(void)getUserCenterListBrandRechecks:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

///3.11 商标复查_复查详情
+(void)getUserCenterViewBrandRechecks:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

///3.12 商标复查_提交商标复查
+(void)getUserCenterAddBrandRechecks:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

///3.13 我的订单－订单列表
+(void)getUserCenterOrderListOrders:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

///3.14 我的订单－订单详情
+(void)getUserCenterOrderViewOrder:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

///3.15个人资料修改
+(void)getUserMemberModifyMeber:(NSMutableDictionary *) params imageArray:(NSArray *)array isNone:(BOOL)isNone success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

///3.16 我的收藏
+(void)getUserCenterListMyCollectionTrademark:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;
///3.17 我的订单－去付款
+(void)getUserOrderViewToPay:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

///3.18 投稿人认证
+(void)getUsercenterAddMemberAuthApply:(NSMutableDictionary *) params imageArray:(NSArray *)array isNone:(BOOL)isNone success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

///3.19 获取投稿人认证信息
+(void)getUsercenterViewMemberAuthApply:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

///3.20 地址获取
+(void)getUsercenterLocationListForTree:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

///3.21 更新会员的累计未读消息数为0
+(void)getUsercenterModifyMsyToZero:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

#pragma mark -  ============4.其它(OTHER)=============

/******************其它(OTHER)***********************/
///4.0 提交推送设备信息
+(void)getOtherSetDeviceInfo:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

///4.1 版本更新
+(void)getOtherGetVersionInfo:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;
//4.2数据字典查询
+(void)getVersionlistDictiionaryItems:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

//4.3支付等
+(void)getOtherOptionByEnName:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

//4.5 关于我们联系我们帮助
+(void)HelpGetEnName:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;
#pragma mark - ==========5.登录注册修改(LOGIN)=========
/********************登录注册修改(LOGIN)******************/

///5.0注册获取验证码

+(void)getLogInMembergetPhoneVerify:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;


///5.1注册
+(void)getLogInMemberRegister:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

///5.2登录
+(void)getLogInMemberLogin:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;


///5.3重置密码
+(void)getLogInMemberResetPassword:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

///5.4登录（微信授权）
+(void)getLoginMemberWeixinOpenid:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

///5.5绑定信息
+(void)getLoginMemberBingRegisOpenId:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;
@end
