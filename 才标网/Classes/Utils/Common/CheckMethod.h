//
//  CheckMethod.h
//  RomanticAppiontment
//
//  Created by baichun on 15-2-10.
//  Copyright (c) 2015年 baichun. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum : NSUInteger {
    LimitLengthTypeOfNone,
    LimitLengthTypeOfMobile,     //手机号
    LimitLengthTypeOfPassword,   //密码
    LimitLengthTypeOfNickName,   //昵称
    LimitLengthTypeOfSfNumber,   //水夫号
    LimitLengthTypeOfBusiness,   //商号
    LimitLengthTypeOfCompanyName,//企业名称
    LimitLengthTypeOfShortName,  //短名
    LimitLengthTypeOfPersonBrief,//个人简介
    LimitLengthTypeOfInJob,      //所在单位
    LimitLengthTypeOfEmail           //邮箱号
} LimitLengthType;

@interface CheckMethod : NSObject
/*验证手机*/
+ (BOOL) validateMobile:(NSString *)mobile;

/*验证邮箱*/
+ (BOOL)validateEmail:(NSString *)email;
/*验证密码长度*/
+(BOOL)validatePassword:(NSString *)passwordStr;

/*验证是否是数字*/
+(BOOL)validateNumber:(NSString*)number ;

+(BOOL)validateIsFitText:(NSString *)isFitStr compareStr:(NSString *)compareStr;

//中文转拼音
+(NSString *)chineseToPinYin:(NSString *)chinaStr;

+(int)limitOfText:(LimitLengthType)type;

@end
