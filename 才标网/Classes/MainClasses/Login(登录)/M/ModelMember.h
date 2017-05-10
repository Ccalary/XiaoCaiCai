//
//  ModelMember.h
//  才标网
//
//  Created by 李强 on 2017/2/17.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ModelMemberAuthApply.h"
#import "ModelMemberExtend.h"

@interface ModelMember : NSObject

///* 状态-正常 */
//public static final short STATE_NORMAL = 1;
///* 状态-禁用*/
//public static final short STATE_DISABLED = 0;
///* 状态-删除*/
//public static final short STATE_DELETE = 9;

/* 会员标识 */
@property (nonatomic, copy) NSString *memberId;
/* 状态 */
@property (nonatomic, copy) NSString *state;
/* 姓名 */
@property (nonatomic, copy) NSString *memberName;
/* 手机号码 */
@property (nonatomic, copy) NSString *mobilePhone;
/* 头像 */
@property (nonatomic, copy) NSString *portrait;
/*是否大师，取值见ChangLiang中的常量 */
@property (nonatomic, copy) NSString *isDaShi;
/*是否投稿人，取值见ChangLiang中的常量 */
@property (nonatomic, copy) NSString *isTouGaoRen;

/*bc_member_dashi_extend 大师扩展信息*/
/* 起名特点 */
@property (nonatomic, copy) NSString *teDian;
/* 大师简介 */
@property (nonatomic, copy) NSString *introduce;

/* 会员扩展对象 */
@property (nonatomic, strong) ModelMemberExtend *memberExtend;

/* 冗余--投稿人认证对象 */
@property (nonatomic, strong) ModelMemberAuthApply *memberAuthApply;

/* 冗余--大师案例集合 */
@property (nonatomic, strong) NSArray *caseList;

//+ (ModelMember *)shareModelMember;

@end
