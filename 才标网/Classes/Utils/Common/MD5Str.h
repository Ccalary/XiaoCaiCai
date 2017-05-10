//
//  MD5.h
//  hygys
//
//  Created by admin on 15/9/9.
//  Copyright (c) 2015年 BBKJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MD5Str : NSObject

+ (NSString *)md5HexDigest:(NSString*)input;
+ (NSString *)MD5HexDigest:(NSString*)input;

+ (NSString *)sha1:(NSString *)input;

+ (NSString *)getIPAddress:(BOOL)preferIPv4;

+ (NSDictionary *)getIPAddresses;


@end
