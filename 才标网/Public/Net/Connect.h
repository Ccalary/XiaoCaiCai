//
//  Connect.h
//  才标网
//
//  Created by caohouhong on 17/3/15.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Connect : NSObject
+ (Connect *)sharedInstance;
-(void)doTestGetNetWorkWithUrl:(NSString*)url parameters:(id)parameters success:(void (^)(NSURLSessionDataTask *operation, NSDictionary *responseDic))success failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

-(void)doTestPostNetWorkWithUrl:(NSString*)url parameters:(id)parameters success:(void (^)(id responseObject))success successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

-(void)doTestImagePostNetWorkWithUrl:(NSString*)url parameters:(id)parameters imageArray:(NSArray *)array isNone:(BOOL)isNone success:(void (^)(id responseObject))success
                successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;
@end
