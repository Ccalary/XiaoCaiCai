//
//  ModelMemberAuthApply.h
//  才标网
//
//  Created by 李强 on 2017/2/17.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <Foundation/Foundation.h>

/* 认证类型-投稿人认证 */
#define AUTHTYPE_IDENTITY 1

/* 认证类型-审核结果-审核中 */
#define CHECKRESULT_APPROVING 1
/* 认证类型-审核结果-通过 */
#define CHECKRESULT_APPROVED 2
/* 认证类型-审核结果-不通过 */
#define CHECKRESULT_DISAPPROVED 3

@interface ModelMemberAuthApply : NSObject

/* 申请标识 */
@property (nonatomic, copy) NSString *applyId;
/* 会员标识 */
@property (nonatomic, copy) NSString *memberId;
/* 认证类型，取值见常量 */
@property (nonatomic, copy) NSString *authType;
/* 申请次数 */
@property (nonatomic, copy) NSString *applyTimes;
/* 申请原件1(身份证图片) */
@property (nonatomic, copy) NSString *original1;
/* 申请原件2，预留 */
@property (nonatomic, copy) NSString *original2;
/* 申请原件3，预留 */
@property (nonatomic, copy) NSString *original3;
/* 申请时戳 */
@property (nonatomic, copy) NSString *applyTime;
/* 真实姓名 */
@property (nonatomic, copy) NSString *trueName;
/* 身份证号码，预留 */
@property (nonatomic, copy) NSString *cardNumber;
/* 审核结果，取值见常量 */
@property (nonatomic, copy) NSString *checkResult;
/* 审核人标识 */
@property (nonatomic, copy) NSString *checkerId;
/* 审核人姓名 */
@property (nonatomic, copy) NSString *checkerName;
/* 审核时戳 */
@property (nonatomic, copy) NSString *checkTime;
/* 驳回原因/审核说明 */
@property (nonatomic, copy) NSString *reason;
/* 擅长 */
@property (nonatomic, copy) NSString *attr1;
/* 所在省标识 */
@property (nonatomic, copy) NSString *provinceId;
/* 所在省名 */
@property (nonatomic, copy) NSString *provinceName;
/* 所在市标识 */
@property (nonatomic, copy) NSString *cityId;
/* 所在市名 */
@property (nonatomic, copy) NSString *cityName;
/* 申请人姓名 */
@property (nonatomic, copy) NSString *memberName;

@end
