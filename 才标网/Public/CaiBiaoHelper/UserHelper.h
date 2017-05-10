//
//  UserHelper.h
//  才标网
//
//  Created by caohouhong on 17/3/18.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserHelper : NSObject
//是否登录
+(BOOL)IsLogin;

//保存登录信息
+(void)setLogInfo:(NSDictionary *)dic;

//退出
+(void)logout;

///是否展示过引导页
+(BOOL)isOpened;
///保存是否展示过引导页 1 为展示过
+ (void)setIsOpened:(NSString *)isFirst;

//获取用户id
+(NSString *)getMemberId;

//获取名字
+(NSString *)getMemberName;
//保存名字
+(void)setMemberName:(NSString *)memberName;

//获取头像地址
+(NSString *)getMemberHeaderPhoto;
//保存头像地址
+ (void)setMemberHeaderPhoto:(NSString *)photo;
// 获取是否大师
+(BOOL)getMemberIsDaShi;
// 获取是否投稿人
+(BOOL)getMemberIsTouGaoRen;
/// 保存PshToken
+(void)setPushToken:(NSString *)pushToken;
/// 获取PushToken
+(NSString *)getPushToken;

/// 保存客服链接
+(void)setServiceUrl:(NSString *)ServiceUrl;

/// 获取PushToken
+(NSString *)getServiceUrl;

/////是否从推送打开app
//+(BOOL)isFromPushOpenApp;
/////保存是否从推送打开app
//+ (void)setisFromPushOpenApp:(NSString *)isFirst;
@end
