//
//  ModelMemberCase.h
//  才标网
//
//  Created by caohouhong on 17/3/21.
//  Copyright © 2017年 李强. All rights reserved.
//  大师案例实体类

#import <Foundation/Foundation.h>

@interface ModelMemberCase : NSObject

///* 状态 -新建 */
//public static final short STATE_NEW = 0;
///* 状态 -已删除 */
//public static final short STATE_DELETED = 9;

/* 案例标识 */
@property(nonatomic, assign) int caseId;
/* 大师会员标识 */
@property(nonatomic, assign) int memberId;
/* 状态，取值见本类中的常量 */
@property(nonatomic, assign) int state;
/* 案例名称 */
@property(nonatomic, copy) NSString *caseName;
/* 案例图片 */
@property(nonatomic, copy) NSString *picPath;
/* 创建人标识 */
@property(nonatomic, assign) int creatorId;
/* 创建人姓名 */
@property(nonatomic, copy) NSString *creatorName;
/* 创建时戳 */
@property(nonatomic, assign) int createdTimestamp;
/* 扩展属性1 */
@property(nonatomic, copy) NSString *attr1;
/* 扩展属性2 */
@property(nonatomic, copy) NSString *attr2;
/* 扩展属性3 */
@property(nonatomic, copy) NSString *attr3;

@end
