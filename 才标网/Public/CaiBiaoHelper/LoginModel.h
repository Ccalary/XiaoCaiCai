//
//  LoginModel.h
//  才标网
//
//  Created by caohouhong on 17/3/18.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 "memberId": 1057,
 "state": 1,
 "memberName": "朱燕雯",
 "mobilePhone": "15051119610",
 "portrait": "http://wx.qlogo.cn/mmopen/PiajxSqBRaEIcViby2e4ZCC8wwmNbPYAjNTrANX6AplHkprnuZYUITUmWssv62psBPPW369f05fDd7lJVncDMBug/0",
 "isDaShi": 0,
 "isTouGaoRen": 0,
 "memberAuthApply": {
 "applyId": 1,
 "authType": 1,
 "applyTimes": 9,
 "original1": "2.jpg",
 "applyTime": 1487148437,
 "trueName": "玩泥巴2",
 "checkResult": 2,
 "attr1": "无所不能",
 "provinceId": 19,
 "provinceName": "江苏省",
 "cityId": 4648,
 "cityName": "无锡市",
 "memberName": "小小小"
}
 */

@interface LoginModel : NSObject
///用户id
@property (nonatomic, copy) NSString *memberId;
@property (nonatomic, copy) NSString *state;
///用户名
@property (nonatomic, copy) NSString *memberName;
///用户手机号
@property (nonatomic, copy) NSString *mobilePhone;
///用户头像地址
@property (nonatomic, copy) NSString *portrait;
///是否是大师（0－否，1－是）
@property (nonatomic, copy) NSString *isDaShi;
///是否投稿人（0－否，1－是）
@property (nonatomic, copy) NSString *isTouGaoRen;

//@property (nonatomic, copy) MemberExtend *memberId;

@end
