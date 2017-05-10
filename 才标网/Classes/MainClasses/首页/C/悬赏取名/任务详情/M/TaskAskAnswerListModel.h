//
//  TaskAskAnswerListModel.h
//  才标网
//
//  Created by baichun on 17/3/28.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TaskAskAnswerListModel : NSObject
///* 类型-提问 */
//public static final short MODELTYPE_ASK  = 1;
///* 类型-回复 */
//public static final short MODELTYPE_ANSWER  = 2;
//
///* 主键 */
//private int id;
/* 任务投稿标识 */
@property(nonatomic,assign) int touGaoId;
/* 类型，取值见常量 */
@property(nonatomic,assign) int modelType;
/* 提问或回复内容 */
@property(nonatomic,strong) NSString *content;
/* 提问人或回复人标识 */
@property(nonatomic,assign) int creatorId;
/* 提问人或回复人姓名 */
@property(nonatomic,strong) NSString *creatorName;
/* 提问或回复时戳 */
@property(nonatomic,assign) int createdTimestamp;
@end
