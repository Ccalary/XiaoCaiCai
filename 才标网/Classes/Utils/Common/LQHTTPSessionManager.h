//
//  LQHTTPSessionManager.h
//  lingdaozhe
//
//  Created by liqiang on 16/4/27.
//  Copyright © 2016年 bckj. All rights reserved.
//

//#import <AFNetworking/AFNetworking.h>
#import "AFNetworking.h"

@interface LQHTTPSessionManager : AFHTTPSessionManager

+ (instancetype)sharedManager;

/**
 *  POST请求
 *
 *  @param URLString            请求地址
 *  @param parameters           请求参数
 *  @param showTips             请求等待提示
 *  @param success              成功
 *  @param successBackfailError 成功返回的错误信息
 *  @param failure              失败
 */
- (void)LQPost:(NSString *)URLString
    parameters:(id)parameters
      showTips:(NSString *)showTips
       success:(void (^)(id responseObject))success
successBackfailError:(void (^)(id responseObject))successBackfailError
       failure:(void (^)(NSError *error))failure;

/**
 *   上传文件请求
 *
 *  @param URLString               请求地址
 *  @param parameters              请求参数
 *  @param fileInfos               请求文件字典数组
 *  @param success                 请求成功
 *  @param successBackfailError    请求成功返回的错误信息
 *  @param failure                 请求失败
 */
- (void)LQPost:(NSString *)URLString
    parameters:(id)parameters
      fileInfo:(NSMutableArray *)fileInfos
      showTips:(NSString *)showTips
       success:(void (^)(id responseObject))success
successBackfailError:(void (^)(id responseObject))successBackfailError
       failure:(void (^)(NSError *))failure;

@end
