//
//  CheckMethod.m
//  RomanticAppiontment
//
//  Created by baichun on 15-2-10.
//  Copyright (c) 2015年 baichun. All rights reserved.
//

#import "CheckMethod.h"

@implementation CheckMethod


//验证手机
+ (BOOL) validateMobile:(NSString *)mobile
{
    if([mobile length]!=11){
        return NO;
    }
    return YES;
//    //手机号以13， 15，18开头，八个 \d 数字字符
//    NSString *phoneRegex = @"^((13[0-9])|(14[0-9])|(17[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
//    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
//    return [phoneTest evaluateWithObject:mobile];
}

//验证邮箱
+ (BOOL)validateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

+(BOOL)validatePassword:(NSString *)passwordStr{
    
    if ([passwordStr length] <6||[passwordStr length]>16) {
        return NO;
    }
    
    return YES;
}


+(BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    
 
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}



//是否只包含 compareStr 里的字符
+(BOOL)validateIsFitText:(NSString *)isFitStr compareStr:(NSString *)compareStr{
    
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:compareStr]invertedSet];
    
    NSString *filtered = [[isFitStr componentsSeparatedByCharactersInSet:cs]componentsJoinedByString:@""]; //按cs分离出数组,数组按@""分离出字符串
    
    BOOL canChange = [isFitStr isEqualToString:filtered];
    return canChange;
}




+(NSString *)chineseToPinYin:(NSString *)chinaStr{
    if ([chinaStr length]) {
        NSMutableString *ms = [[NSMutableString alloc] initWithString:chinaStr];
        if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformMandarinLatin, NO)) {
            NSLog(@"pinyin: %@", ms);
            return ms;
        }
        if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformStripDiacritics, NO)) {
            NSLog(@"pinyin: %@", ms);
            return ms;
        }  
    }
    return @"";
}

+(int)limitOfText:(LimitLengthType)type{
    switch (type) {
        case LimitLengthTypeOfNone:
            return 0;
            break;
        case LimitLengthTypeOfMobile:
            return 11;
            break;
        case LimitLengthTypeOfNickName:
            return 16;
            break;
        case LimitLengthTypeOfPassword:
            return 32;
            break;
        case LimitLengthTypeOfSfNumber:
            return 16;
            break;
        case LimitLengthTypeOfBusiness:
            return 16;
            break;
        case LimitLengthTypeOfCompanyName:
            return 32;
            break;
        case LimitLengthTypeOfShortName:
            return 12;
            break;
        case LimitLengthTypeOfPersonBrief:
            return 200;
            break;
        case LimitLengthTypeOfInJob:
            return 32;
            break;
        case LimitLengthTypeOfEmail:
            return 32;
            break;
        default:
            break;
    }
    return 0;
}

@end
