//
//  MessageModel.h
//  才标网
//
//  Created by caohouhong on 17/3/18.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageModel : NSObject

///* 状态-未推送 */
//public static final short STATE_NEW = 1;
///* 状态-已推送 */
//public static final short STATE_SENT = 2;
///* 状态-删除 */
//public static final short STATE_DELETED = 9;
//
//
///* 消息所属分组-任务消息 */
//public static final short GROUP_TYPE_TASK = 1;
///* 消息所属分组-后台推送的消息 */
//public static final short GROUP_TYPE_DISCOUNT = 2;
///* 消息所属分组-系统消息 */
//public static final short GROUP_TYPE_SYSTEM = 3;
///* 消息所属分组-商标复查消息 */
//public static final short GROUP_TYPE_BRAND_RECHECK = 4;
///* 消息所属分组-暂时无用 */
//public static final short GROUP_TYPE_CMD = 99;
//
///* 消息指向实体-悬赏任务*/
//public static final short LINK_TYPE_XUANSHAGN_TASK = 1;
///* 消息指向实体-大师任务*/
//public static final short LINK_TYPE_DASHI_TASK = 2;
///* 消息指向实体-商标复查*/
//public static final short LINK_TYPE_BRAND_RECHECK = 3;
///* 消息指向实体-外网链接*/
//public static final short LINK_TYPE_HTTP = 11;
///* 消息指向实体模块-无指向*/
//public static final short LINK_TYPE_NONE = 99;
//
//
///* 内容模板-任务消息--参与悬赏任务(投稿了) */
//public static final String CONTENTTEMPLATE_XUANSHAGN_TASK_JOIN = "{memberName}参与了你的悬赏任务";
///* 内容模板-商标复查消息--商标复查完成 */
//public static final String CONTENTTEMPLATE_BRAND_RECHECK_OK = "{brandName}商标复查完成";
///* 内容模板-提现成功 */
//public static final String CONTENTTEMPLATE_WITHDRAWCASH_SUCCESS = "您本次申请提现{applyAmount/100}元已转入您的支付宝账户，请注意查收";
///* 内容模板-提现失败 */
//public static final String CONTENTTEMPLATE_WITHDRAWCASH_FAILED = "你提交的{applyAmount/100}元提现申请失败。";

///* 业务类型-会员-提现失败 */
//public static final short BUSINESSTYPE_MEMBER_WITHDRAWCASH_FAILED = 6;

/**
 "pageSize": 24,
 "start": 0,
 "data": [
     {
     "messageId": 1,
     "groupType": 1,
     "state": 2,
     "linkType": 1,
     "linkParams": "6",
     "messageContent": "sdfa",
     "createEnterpriseId": 12,
     "createdTimestamp": 1467094960,
     "creatorId": 1,
     "creatorName": "asd",
     "sentTimestamp": 1
     }
     ],
 "totalCount": 1

 */

/* 消息标识 */
@property(nonatomic, assign) int messageId;
/* 所属分组，取值见常量 */
@property(nonatomic, assign) short groupType;
/* 状态，取值见常量 */
@property(nonatomic, assign) short state;
/* 消息指向实体模块，取值见常量 */
@property(nonatomic, assign) short linkType;
/* 消息指向实体参数 */
@property(nonatomic, copy) NSString *linkParams;
/* 消息指向实体参数的名称 */
@property(nonatomic, copy) NSString *linkParamsName;
/* 消息标题(预留) */
@property(nonatomic, copy) NSString *messageTitle;
/* 消息内容，内容参照模板，替换参数 */
@property(nonatomic, copy) NSString *messageContent;
/* 创建时戳 */
@property(nonatomic, assign)int createdTimestamp;
/* 创建人标识 */
@property(nonatomic, assign)int creatorId;
/* 创建人姓名 */
@property(nonatomic, copy) NSString *creatorName;
/* 推送时戳 */
@property(nonatomic, assign)int sentTimestamp;
/* 删除时戳 */
@property(nonatomic, assign)int deletedTime;

/*========== 冗余 ===========*/
/*多个消息接收者标识 */
@property (nonatomic, retain) NSArray * receverIds;
/*linkType的说明文字 */
@property(nonatomic, copy) NSString *linkTypeText;
@end
