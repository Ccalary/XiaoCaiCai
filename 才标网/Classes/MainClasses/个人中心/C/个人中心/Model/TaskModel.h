//
//  TaskModel.h
//  才标网
//
//  Created by caohouhong on 17/3/18.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TaskModel : NSObject
///* 状态-未支付 */
//public static final short STATE_UNPAID  = 1;
///* 状态-已支付 */
//public static final short STATE_PAID  = 2;
///* 状态 -已删除 */
//public static final short STATE_DELETED = 9;
//
///* 起名分类 -商标起名 */
//public static final short NAMED_CATEGORY_BRAMD = 1;
///* 起名分类 -公司起名 */
//public static final short NAMED_CATEGORY_COMPANY = 2;
//
///* 任务所属模块 -悬赏起名 */
//public static final short TASK_MODE_XUANSHANG = 1;
///* 任务所属模块 -大师起名 */
//public static final short TASK_MODE_DASHI = 2;

/* 任务标识 */
@property(nonatomic, assign)int taskId;
/* 任务流水编号*/
@property(nonatomic, copy)NSString *taskCode;
/* 状态，取值见本类的常量 */
@property(nonatomic, assign)int state;
/* 起名分类，取值见本类的常量 */
@property(nonatomic, assign)int namedCategory;
/* 任务标题*/
@property(nonatomic, copy)NSString *taskTitle;
/* 任务所属模块，取值见本类的常量 */
@property(nonatomic, assign)int taskMode;
/* 所属行业分类标识 */
@property(nonatomic, assign)int categoryId;
/* 所属行业分类名称 */
@property(nonatomic, copy)NSString *categoryName;
/* 任务要求数据项内容串 */
@property(nonatomic, copy)NSString *itemContents;
/* 详细要求描述 */
@property(nonatomic, copy)NSString *requireDetail;
/* 悬赏任务的投稿数量 */
@property(nonatomic, assign)int touGaoNum;
/* 悬赏到期时戳 */
@property(nonatomic, assign)int expireTime;
/* 悬赏金额(分)/大师套餐金额 */
@property(nonatomic, assign)int price;
@property(nonatomic, assign)double priceYuan;

/* 大师标识 */
@property(nonatomic, assign)int dashiMemberId;
/* 大师姓名 */
@property(nonatomic, copy)NSString *dashiMemberName;

@property(nonatomic, copy)NSString *dashiName;
@property(nonatomic, copy)NSString *dashiPortrait;

/* 大师特点 */
@property(nonatomic, copy)NSString *teDian;

/* 老板名字 */
@property(nonatomic, copy)NSString *bossName;
/* 起名字数 */
@property(nonatomic, copy)NSString *wordsNum;
/* 生日 */
@property(nonatomic, assign)int birthday;
/* 出生时刻*/
@property(nonatomic, assign)int birthhour;
/* 支付方式，取值见ChangLiang中的定义 */
@property(nonatomic, assign)int payMode;
/* 付款时戳 */
@property(nonatomic, assign)int paidTime;
/* 发布人标识 */
@property(nonatomic, assign)int creatorId;
/* 发布人姓名 */
@property(nonatomic, copy)NSString *creatorName;
/* 发布人头像 */
@property(nonatomic, copy)NSString *creatorPortrait;
/* 发布时戳 */
@property(nonatomic, assign)int createdTimestamp;
/* 举报处理时戳 */
@property(nonatomic, assign)int handledTime;
/* 举报处理人标识 */
@property(nonatomic, assign)int handlerId;
/* 举报处理人姓名 */
@property(nonatomic, copy)NSString *handlerName;
/* 悬赏任务是否已经分钱/已退款，取值见ChangLiang中的常量 */
@property(nonatomic, assign)int isXuanShangFenQian;

/*============= 冗余 ====================*/
/* 投稿(人)集合*/

//private List<TaskTouGao> taskTouGaoList;
@property (nonatomic, strong) NSArray *taskTouGaoList;

@end
