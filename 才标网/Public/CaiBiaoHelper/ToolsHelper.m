//
//  ToolsHelper.m
//  才标网
//
//  Created by caohouhong on 17/3/17.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "ToolsHelper.h"
#import "TTGroupTagView.h"
#include <ifaddrs.h>
#include <arpa/inet.h>

@implementation ToolsHelper

///改变某些字的颜色
+ (NSMutableAttributedString *)changeSomeText:(NSString *)str inText:(NSString *)result withColor:(UIColor *)color {
    
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:result];
    if (str.length){
        NSRange colorRange = NSMakeRange([[attributeStr string] rangeOfString:str].location,[[attributeStr string] rangeOfString:str].length);
        [attributeStr addAttribute:NSForegroundColorAttributeName value:color range:colorRange];
    }
    return attributeStr;
}
// log NSSet with UTF8
// if not ,log will be \Uxxx
+ (NSString *)logDic:(NSDictionary *)dic {
    if (![dic count]) {
        return nil;
    }
    NSString *tempStr1 =
    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
                                                 withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str =
    [NSPropertyListSerialization propertyListFromData:tempData
                                     mutabilityOption:NSPropertyListImmutable
                                               format:NULL
                                     errorDescription:NULL];
    return str;
}

// Get IP Address
+(NSString *)getIPAddress
{
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                
                NSString *ifaName = [NSString stringWithUTF8String:temp_addr->ifa_name];
                
                NSString* getedAddress = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *) temp_addr->ifa_addr)->sin_addr)];
                NSString* mask = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *) temp_addr->ifa_netmask)->sin_addr)];
                NSString* gateway = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *) temp_addr->ifa_dstaddr)->sin_addr)];
                
                NSLog(@"ifaName:%@--address:%@--mask:%@--gateway:%@",ifaName,address,mask,gateway);
                
                if([ifaName isEqualToString:@"en0"]) {//无线网
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }else if([ifaName isEqualToString:@"pdp_ip0"]){//3g、4g网
                    address = getedAddress;
                }
                
                
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
}

//计算tag高度
+(NSString *)tagHeightWithArray:(NSArray *)array  andWidht:(CGFloat )width andCornerScale:(double) scale{
    
    TTGroupTagView *taview = [[TTGroupTagView alloc] initWithFrame:CGRectMake(0, 122, width, 50)];
    taview.translatesAutoresizingMaskIntoConstraints = YES;
    [taview addTags:array withCornerScale:scale];
    taview.tagHeight = 20*UIRate;
    NSMutableArray *heightArray = [[NSMutableArray alloc] init];
    NSString *height = @"0";
    
    [heightArray addObject:[NSString stringWithFormat:@"%f", taview.changeHeight]];
    if (heightArray.count > 0){
        height = [NSString stringWithFormat:@"%@",heightArray.firstObject];
    }
    return height;
}

@end
