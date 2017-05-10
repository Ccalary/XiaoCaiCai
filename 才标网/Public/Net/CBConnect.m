//
//  CBConnect.m
//  才标网
//
//  Created by caohouhong on 17/3/15.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "CBConnect.h"
#import "Connect.h"
#import "UserHelper.h"

@implementation CBConnect

+ (NSMutableDictionary *)getBaseRequestParams
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    
    [params setObject:[UserHelper getMemberId] forKey:@"memberId"];
    return params;
}



#pragma mark - ===========1.首页(Home)===========
/********************首页(Home)***************************/
//1.0首页信息
+(void)getHomeListHomeAll:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    Connect *con=[Connect sharedInstance];
    [con doTestPostNetWorkWithUrl:HOME_GET_LIST_HOME_ALL parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
}


//1.1任务广场
+(void)getHomeTasksquareInfo:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure{
    
    Connect *con=[Connect sharedInstance];
    [con doTestPostNetWorkWithUrl:HOME_GET_TASKS_LISTTASKS parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];

    
    
}
//1.2任务详情
+(void)getHomeTaskViewTask:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure{
    
    
    Connect *con=[Connect sharedInstance];
    [con doTestPostNetWorkWithUrl:HOME_GET_TASKS_VIEWTASK parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];

    
}
//1.3投稿
+(void)getHomeTaskTouGao:(NSMutableDictionary *) params imageArray:(NSArray *)array isNone:(BOOL)isNone success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure{
    
    
    Connect *con=[Connect sharedInstance];
    [con doTestImagePostNetWorkWithUrl:HOME_GET_TASKS_TOUGAO parameters:params imageArray:array isNone:isNone success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);

    }];
    
    
}

//1.4发布任务
+(void)getHomeTaskAddTask:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure{
    
    Connect *con=[Connect sharedInstance];
    [con doTestPostNetWorkWithUrl:HOME_GET_TASKS_ADDTASK parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
    
    
    
}

//1.5大师列表
+(void)getHomeListDashiMember:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    Connect *con=[Connect sharedInstance];
    [con doTestPostNetWorkWithUrl:HOME_GET_LIST_DASHI_MEMBER parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
}

//1.6任务_发布任务
+(void)getHomeAddTask:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    Connect *con=[Connect sharedInstance];
    [con doTestPostNetWorkWithUrl:HOME_GET_ADD_TASK parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
}


///1.7大师套餐
+(void)getHomeListDashiPackages:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    Connect *con=[Connect sharedInstance];
    [con doTestPostNetWorkWithUrl:HOME_GET_LIST_DASHI_PACKAGES parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
}

///1.8商标其名行业分类_列出全部分类树形结构数据
+(void)getHomeListCateTree:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    Connect *con=[Connect sharedInstance];
    [con doTestPostNetWorkWithUrl:HOME_GET_LIST_CATEGORIES_TREE parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
}

//1.9采纳投稿
+(void)getHomeUseTouGao:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    Connect *con=[Connect sharedInstance];
    [con doTestPostNetWorkWithUrl:HOME_GET_TASKS_USETOUGAO parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
}

    

//1.10编辑投稿
+(void)getModifTouGao:(NSMutableDictionary *) params imageArray:(NSArray *)array isNone:(BOOL)isNone success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure{
    
    
    Connect *con=[Connect sharedInstance];
    [con doTestImagePostNetWorkWithUrl:HOME_GET_MODIF_TOUGAO parameters:params imageArray:array isNone:isNone success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
        
    }];
    
    
}

//1.11举报
+(void)getHomeAddImpeach:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    Connect *con=[Connect sharedInstance];
    [con doTestPostNetWorkWithUrl:HOME_GET_IMPEACH_ADDIMPEACH parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
}
//1.12提问或回复
+(void)getHomeAskAnswer:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    Connect *con=[Connect sharedInstance];
    [con doTestPostNetWorkWithUrl:HOME_GET_TASK_ASKANSWER parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
}

//1.13删除投稿
+(void)getHomeRemove:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    Connect *con=[Connect sharedInstance];
    [con doTestPostNetWorkWithUrl:HOME_GET_TASK_REMOVE parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
}

//1.14自助起名(按关键字)
+(void)getTradeMarkNameByKeyWord:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    Connect *con=[Connect sharedInstance];
    [con doTestPostNetWorkWithUrl:HOME_GET_NAME_BY_KEYWORD parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
}

//1.15自助起名(按行业)
+(void)getTradeMarkNameByHangye:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    Connect *con=[Connect sharedInstance];
    [con doTestPostNetWorkWithUrl:HOME_GET_NAME_BY_HANGYE parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
}

//1.16商品_买商标或商标咨询注册
+(void)getHomeBuyTradeMark:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    Connect *con=[Connect sharedInstance];
    [con doTestPostNetWorkWithUrl:HOME_GET_BUY_TRADEMARK parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
}

//1.17会员-个人信息详情(大师详情)
+(void)getHomeMemberViewMember:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    Connect *con=[Connect sharedInstance];
    [con doTestPostNetWorkWithUrl:HOME_GET_MEMBER_VIEW_MEMBER parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
}

///1.18列出全部分类树形结构数据
+(void)getHomeTrademarkCompanyType:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    Connect *con=[Connect sharedInstance];
    [con doTestPostNetWorkWithUrl:HOME_GET_TRADEMARK_COMPANYTYPE parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
}



#pragma mark -  =========2.商标(BRAND)============
/******************商标(BRAND)*********************/
//2.0 首页信息



//2.1文字检索
+(void)getBrandByword:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    Connect *con=[Connect sharedInstance];
    [con doTestPostNetWorkWithUrl:BRAND_GET_TRADEMARK_BYWORD parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
}
//2.2图片检索
+(void)getBrandByImage:(NSMutableDictionary *) params imageArray:(NSArray *)array isNone:(BOOL)isNone success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure{
    
    
    Connect *con=[Connect sharedInstance];
    [con doTestImagePostNetWorkWithUrl:BRAND_GET_TRADEMARK_BYPIC parameters:params imageArray:array isNone:isNone success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
        
    }];
    
    
}

//2.3商标分类
+(void)getProutServices:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    Connect *con=[Connect sharedInstance];
    [con doTestPostNetWorkWithUrl:BRAND_GET_PRODUCT_SERVICES parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
}

//2.4商品详情
+(void)getProutDetail:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    Connect *con=[Connect sharedInstance];
    [con doTestPostNetWorkWithUrl:BRAND_GET_PRODUCT_DETAIL parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
}
//2.5商品推荐
+(void)getProutProducts:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    Connect *con=[Connect sharedInstance];
    [con doTestPostNetWorkWithUrl:BRAND_GET_PRODUCT_PRODUCTS parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
}
//2.6卖商标
+(void)getProutTrademark:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    Connect *con=[Connect sharedInstance];
    [con doTestPostNetWorkWithUrl:BRAND_GET_PRODUCT_TRADEMARK parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
}

///2.7 商标详情
+(void)getBrandViewTradeMark:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    Connect *con=[Connect sharedInstance];
    [con doTestPostNetWorkWithUrl:BRAND_VIEW_TRADEMARK parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
}

///2.8 添加订单
+(void)getBrandOrderAddOrder:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    Connect *con=[Connect sharedInstance];
    [con doTestPostNetWorkWithUrl:BRAND_ORDER_ADD_ORDER parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
}

///2.9商标申请
+(void)getTradeMarkApply:(NSMutableDictionary *) params imageArray:(NSArray *)array isNone:(BOOL)isNone success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure{
    
    
    Connect *con=[Connect sharedInstance];
    [con doTestImagePostNetWorkWithUrl:BRAND_VIEW_TRADEMARKAPPLY parameters:params imageArray:array isNone:isNone success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
}

///2.10 商标收藏
+(void)getBrandCollectTradeMark:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    Connect *con=[Connect sharedInstance];
    [con doTestPostNetWorkWithUrl:BRAND_COLLECT_TRADEMARK parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
}

///2.11 取消商标收藏
+(void)getBrandUncollectTradeMark:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    Connect *con=[Connect sharedInstance];
    [con doTestPostNetWorkWithUrl:BRAND_UNCOLLECT_TRADEMARK parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
}
///2.12 商标广告
+(void)getBrandAdListads:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    Connect *con=[Connect sharedInstance];
    [con doTestPostNetWorkWithUrl:BRAND_AD_LISTADS parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
}


#pragma mark - ==========3.个人中心(USERCENTER)=========
/********************个人中心(USERCENTER)******************/
///3.0个人中心首页消息数据
+(void)getUserCenterUnreadMsgNum:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    Connect *con=[Connect sharedInstance];
    [con doTestPostNetWorkWithUrl:USERCENTER_GET_UNREAD_MESSAGE_NUM parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
}

///3.1 消息列表
+(void)getUserCenterMessageList:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    Connect *con=[Connect sharedInstance];
    [con doTestPostNetWorkWithUrl:USERCENTER_MESSAGE_LIST parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
}

///3.2 消息已读
+(void)getUserCenterModifyMsgRead:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    Connect *con=[Connect sharedInstance];
    [con doTestPostNetWorkWithUrl:USERCENTER_MODIFY_MSG_READ parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
}

///3.3 查看会员帐户
+(void)getUserCenterViewMemberAccount:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    Connect *con=[Connect sharedInstance];
    [con doTestPostNetWorkWithUrl:USERCENTER_VIEW_MEMBER_ACCOUNT parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
}

///3.4 查看会员帐户流水历史
+(void)getUserCenterMemberAccountListFlows:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    Connect *con=[Connect sharedInstance];
    [con doTestPostNetWorkWithUrl:USERCENTER_MEMBER_ACCOUNT_LIST_FLOWS parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
}

///3.5 添加提现申请
+(void)getUserCenterAddMemberWithdrawCashApply:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    Connect *con=[Connect sharedInstance];
    [con doTestPostNetWorkWithUrl:USERCENTER_ADD_MEMBER_WITHDRAW_APPLY parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
}

///3.6 列出某个会员的提现记录列表
+(void)getUserCenterListWithdrawCashApplies:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    Connect *con=[Connect sharedInstance];
    [con doTestPostNetWorkWithUrl:USERCENTER_WITHDRAW_APPLIES_LIST parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
}

///3.7 我_我的悬赏任务列表
+(void)getUserCenterListMyTasks:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    Connect *con=[Connect sharedInstance];
    [con doTestPostNetWorkWithUrl:USERCENTER_LIST_MY_TASKS parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
}

///3.8 我的投稿(我所有投过稿的悬赏任务列表)
+(void)getUserCenterListMyContributeTask:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    Connect *con=[Connect sharedInstance];
    [con doTestPostNetWorkWithUrl:USERCENTER_LIST_MY_CONTRIBUTE_TASK parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
}

///3.9 我_我是大师(我作为大师时收到的任务列表)
+(void)getUserCenterListMyReceivedTask:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    Connect *con=[Connect sharedInstance];
    [con doTestPostNetWorkWithUrl:USERCENTER_LIST_MY_RECEIVED_TASK parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
}

///3.10 商标复查_我的商标复查列表
+(void)getUserCenterListBrandRechecks:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    Connect *con=[Connect sharedInstance];
    [con doTestPostNetWorkWithUrl:USERCENTER_LIST_BRAND_RECHECKS parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
}

///3.11 商标复查_复查详情
+(void)getUserCenterViewBrandRechecks:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    Connect *con=[Connect sharedInstance];
    [con doTestPostNetWorkWithUrl:USERCENTER_VIEW_BRAND_RECHECK parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
}

///3.12 商标复查_提交商标复查
+(void)getUserCenterAddBrandRechecks:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    Connect *con=[Connect sharedInstance];
    [con doTestPostNetWorkWithUrl:USERCENTER_ADD_BRAND_RECHECK parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
}

///3.13 我的订单－订单列表
+(void)getUserCenterOrderListOrders:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    Connect *con=[Connect sharedInstance];
    [con doTestPostNetWorkWithUrl:USERCENTER_ORDER_LIST_ORDERS parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
}

///3.14 我的订单－订单详情
+(void)getUserCenterOrderViewOrder:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    Connect *con=[Connect sharedInstance];
    [con doTestPostNetWorkWithUrl:USERCENTER_ORDER_VIEW_ORDER parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
}
///3.15个人资料修改
+(void)getUserMemberModifyMeber:(NSMutableDictionary *) params imageArray:(NSArray *)array isNone:(BOOL)isNone success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure{
    Connect *con=[Connect sharedInstance];
    [con doTestImagePostNetWorkWithUrl:USERCENTER_MEMBER_MODIFYMEMBER parameters:params imageArray:array isNone:isNone success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
        
    }];
}

///3.16 我的收藏
+(void)getUserCenterListMyCollectionTrademark:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    Connect *con=[Connect sharedInstance];
    [con doTestPostNetWorkWithUrl:USERCENTER_LIST_MY_COLLECTION_TRADEMARK parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
}

///3.17 我的订单－去付款
+(void)getUserOrderViewToPay:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    Connect *con=[Connect sharedInstance];
    [con doTestPostNetWorkWithUrl:USERCENTER_ORDER_TOPAY parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
}

///3.18 投稿人认证
+(void)getUsercenterAddMemberAuthApply:(NSMutableDictionary *) params imageArray:(NSArray *)array isNone:(BOOL)isNone success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure{
    Connect *con=[Connect sharedInstance];
    [con doTestImagePostNetWorkWithUrl:USERCENTER_ADD_MEMBER_AUTH_APPLY parameters:params imageArray:array isNone:isNone success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
        
    }];
}

///3.19 获取投稿人认证信息
+(void)getUsercenterViewMemberAuthApply:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    Connect *con=[Connect sharedInstance];
    [con doTestPostNetWorkWithUrl:USERCENTER_VIEW_MEMBER_AUTH_APPLY parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
}

///3.20 地址获取
+(void)getUsercenterLocationListForTree:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    Connect *con=[Connect sharedInstance];
    [con doTestPostNetWorkWithUrl:USERCENTER_LOCATION_LIST_FOR_TREE parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
}

///3.21 更新会员的累计未读消息数为0
+(void)getUsercenterModifyMsyToZero:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    Connect *con=[Connect sharedInstance];
    [con doTestPostNetWorkWithUrl:USERCENTER_MODIFY_MSY_TO_ZERO parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
}


#pragma mark -  ============4.其它(OTHER)=============
/******************其它(OTHER)***********************/
///4.0 提交推送设备信息
+(void)getOtherSetDeviceInfo:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    Connect *con=[Connect sharedInstance];
    [con doTestPostNetWorkWithUrl:OTHER_SET_DIVICE_INFO parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
}


///4.1 版本更新
+(void)getOtherGetVersionInfo:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    Connect *con=[Connect sharedInstance];
    [con doTestPostNetWorkWithUrl:OTHER_GET_VERSION_INFO parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
}
//4.2数据字典查询
+(void)getVersionlistDictiionaryItems:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure{
    
    Connect *con=[Connect sharedInstance];
    [con doTestPostNetWorkWithUrl:HOME_GET_VERSION_LISTDICTIONARY parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
}

//4.3支付等
+(void)getOtherOptionByEnName:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure{
    
    Connect *con=[Connect sharedInstance];
    [con doTestPostNetWorkWithUrl:OTHER_GET_VERSION_OPTION_BY_ENNAME parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
}
//4.5 关于我们联系我们帮助
+(void)HelpGetEnName:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure{
    
    Connect *con=[Connect sharedInstance];
    [con doTestPostNetWorkWithUrl:HELP_GET_VERSION_SYSTEM_ENNAME parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
}


#pragma mark - ==========5.登录注册修改(LOGIN)=========
/********************登录注册修改(LOGIN)******************/


///5.0注册获取验证码
+(void)getLogInMembergetPhoneVerify:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    Connect *con=[Connect sharedInstance];
    [con doTestPostNetWorkWithUrl:LOGIN_GET_MEMBER_GETPHONEVERIFY parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
}

///5.1注册
+(void)getLogInMemberRegister:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    Connect *con=[Connect sharedInstance];
    [con doTestPostNetWorkWithUrl:LOGIN_GET_MEMBER_REGISTER parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
}

///5.2登录
+(void)getLogInMemberLogin:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    Connect *con=[Connect sharedInstance];
    [con doTestPostNetWorkWithUrl:LOGIN_GET_MEMBER_LOGIN parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
}


///5.3重置密码
+(void)getLogInMemberResetPassword:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    Connect *con=[Connect sharedInstance];
    [con doTestPostNetWorkWithUrl:LOGIN_GET_MEMBER_RESETPASSWORD parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
}

///5.4登录（微信授权）
+(void)getLoginMemberWeixinOpenid:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    Connect *con=[Connect sharedInstance];
    [con doTestPostNetWorkWithUrl:LOGIN_MEMBER_WEIXIN_OPENID parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
}
///5.5绑定信息
+(void)getLoginMemberBingRegisOpenId:(NSMutableDictionary *) params success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    Connect *con=[Connect sharedInstance];
    [con doTestPostNetWorkWithUrl:LOGIN_MEMBER_BINGREGIS_OPENID parameters:params success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
}



@end
