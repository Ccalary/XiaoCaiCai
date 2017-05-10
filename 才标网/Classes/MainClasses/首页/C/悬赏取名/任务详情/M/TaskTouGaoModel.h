//
//  TaskTouGaoModel.h
//  才标网
//
//  Created by baichun on 17/3/20.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TaskTouGaoModel : NSObject
///* 状态-正常  */
//public static final short STATE_NEW  = 0;
///* 状态-已删除 */
//public static final short STATE_DELETED  = 9;
//
/* 任务投稿起名标识 */
@property(nonatomic, assign) int touGaoId;
/* 状态，取值见本类的常量 */
@property(nonatomic, assign) int state;
/* 任务标识 */
@property(nonatomic, assign) int taskId;
/* 投稿名称*/
@property(nonatomic, strong) NSString *brandName;
/* 是否被采纳，取值见ChangLiang中的常量 */
@property(nonatomic, assign) int isUsed;
/* 是否查询，取值见ChangLiang中的常量 */
@property(nonatomic, assign) int isCheck;
/* 是否可提问，取值见ChangLiang中的常量 */
@property(nonatomic, assign) int isCanAsk;
/* 是否可回复，取值见ChangLiang中的常量 */
@property(nonatomic, assign) int isCanAnswer;
/* 累计提问次数 */
@property(nonatomic, assign) int totalAskNum;
/* 释义说明*/
@property(nonatomic, strong) NSString  *reason;
/* 投稿人标识 */
@property(nonatomic, assign) int creatorId;
/* 投稿人姓名 */
@property(nonatomic, strong) NSString  *creatorName;
/* 投稿人头像 */
@property(nonatomic, strong) NSString  *creatorPortrait;
/* 投稿人手机号 */
@property(nonatomic, strong) NSString  *creatorPhone;
/* 投稿时戳 */
@property(nonatomic, assign) int createdTimestamp;
/* 举报处理时戳 */
@property(nonatomic, assign) int handledTime;
/* 举报处理人标识 */
@property(nonatomic, assign) int handlerId;
/* 举报处理人姓名 */
@property(nonatomic, strong) NSString  *handlerName;
/* 最后修改时戳 */
@property(nonatomic, assign) int lastModified;

@property(nonatomic, strong) NSArray *picPaths;
/*============= 冗余 ====================*/
/*投稿释义图片路径集合*/
//private List<String> picPaths;
/* 投稿的提问或回复集合*/
//private List<TaskAskAnswer> taskAskAnswerList;

@property (nonatomic, strong) NSArray *taskAskAnswerList;
/* 任务编号*/
@property(nonatomic, strong) NSString  *taskCode;
/* 任务金额-分*/
@property(nonatomic, assign) int price;
/* 任务金额-元*/
@property(nonatomic, assign) double priceYuan;

@end
