
//
//  UserHelper.m
//  才标网
//
//  Created by caohouhong on 17/3/18.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "UserHelper.h"

@implementation UserHelper
//是否登录
+(BOOL)IsLogin{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *isLogin=[defaults objectForKey:@"isLogin"];
    return [isLogin isEqualToString:@"1"];
}

//保存登录信息
+(void)setLogInfo:(NSDictionary *)dic{
    NSUserDefaults *de=[NSUserDefaults standardUserDefaults];
    [de setObject:@"1" forKey:@"isLogin"];//登录
    [de setObject:[dic objectForKey:@"portrait"] forKey:@"portrait"];//头像
    [de setObject:[dic objectForKey:@"addressId"] forKey:@"addressId"];
    [de setObject:[dic objectForKey:@"isTouGaoRen"] forKey:@"isTouGaoRen"];//是否进行投稿认证 0 否 1是
    [de setObject:[dic objectForKey:@"memberName"] forKey:@"memberName"];//名字
    [de setObject:[dic objectForKey:@"isDaShi"] forKey:@"isDaShi"];//是否大师 1是 0否
    [de setObject:[dic objectForKey:@"memberId"] forKey:@"memberId"];//id
    [de setObject:[dic objectForKey:@"mobilePhone"] forKey:@"mobilePhone"];//电话
    [de setObject:[dic objectForKey:@"state"] forKey:@"state"];//?
    [de setObject:[dic objectForKey:@"groupId"] forKey:@"groupId"];//?
    
    [de synchronize];
}

//退出
+(void)logout{
    NSUserDefaults *de=[NSUserDefaults standardUserDefaults];
    [de setObject:@"0" forKey:@"isLogin"];
    [de setObject:@"" forKey:@"portrait"];
    [de setObject:@"" forKey:@"addressId"];
    [de setObject:@"" forKey:@"isTouGaoRen"];
    [de setObject:@"" forKey:@"memberName"];
    [de setObject:@"" forKey:@"isDaShi"];
    [de setObject:@"" forKey:@"memberId"];
    [de setObject:@"" forKey:@"mobilePhone"];
    [de setObject:@"" forKey:@"state"];
    [de setObject:@"" forKey:@"groupId"];
    [de synchronize];
}

///是否展示过引导页
+(BOOL)isOpened{
    NSString *app_Version = [UserHelper getAppVersion];
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *isOpen=[defaults objectForKey:[NSString stringWithFormat:@"isOpened%@",app_Version]];
    return [isOpen isEqualToString:@"1"];
}

///保存是否展示过引导页
+ (void)setIsOpened:(NSString *)isFirst{
    
    NSString *app_Version = [UserHelper getAppVersion];
    
    NSUserDefaults *de=[NSUserDefaults standardUserDefaults];
    [de setObject:isFirst forKey:[NSString stringWithFormat:@"isOpened%@",app_Version]];
    [de synchronize];
}

//获取用户id
+(NSString *)getMemberId
{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    if (![defaults objectForKey:@"memberId"]) {
        return @"";
    }
    NSString *memberId = [NSString stringWithFormat:@"%@",[defaults objectForKey:@"memberId"]];
    return memberId;
}
//获取名字
+(NSString *)getMemberName
{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:@"memberName"];
}

//保存名字
+ (void)setMemberName:(NSString *)memberName{
    NSUserDefaults *de=[NSUserDefaults standardUserDefaults];
    [de setObject:memberName forKey:@"memberName"];
    [de synchronize];
}

//保存头像地址
+ (void)setMemberHeaderPhoto:(NSString *)photo{
    NSUserDefaults *de=[NSUserDefaults standardUserDefaults];
    [de setObject:photo forKey:@"portrait"];
    [de synchronize];
}

//获取头像地址
+(NSString *)getMemberHeaderPhoto
{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:@"portrait"];
}
// 获取是否大师
+(BOOL)getMemberIsDaShi
{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *isLogin= [NSString stringWithFormat:@"%d",[[defaults objectForKey:@"isDaShi"] intValue]];
    return [isLogin isEqualToString:@"1"];
    
}
// 获取是否投稿人
+(BOOL)getMemberIsTouGaoRen
{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *isLogin= [NSString stringWithFormat:@"%d",[[defaults objectForKey:@"isTouGaoRen"] intValue]];
    return [isLogin isEqualToString:@"1"];
}
/// 保存PshToken
+(void)setPushToken:(NSString *)pushToken{
    NSUserDefaults *de=[NSUserDefaults standardUserDefaults];
    [de setObject:pushToken forKey:@"pushToken"];
    [de synchronize];
}

/// 获取PushToken
+(NSString *)getPushToken{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:@"pushToken"];
}



/// 保存客服链接
+(void)setServiceUrl:(NSString *)ServiceUrl{
    NSUserDefaults *de=[NSUserDefaults standardUserDefaults];
    [de setObject:ServiceUrl forKey:@"ServiceUrl"];
    [de synchronize];
}

/// 获取客服链接
+(NSString *)getServiceUrl{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:@"ServiceUrl"];
}

//获得版本号
+(NSString *)getAppVersion{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
    return app_Version;
}
@end
