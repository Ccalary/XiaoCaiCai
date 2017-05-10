//
//  LQHTTPSessionManager.m
//  lingdaozhe
//
//  Created by liqiang on 16/4/27.
//  Copyright © 2016年 bckj. All rights reserved.
//

#import "LQHTTPSessionManager.h"

#define SERVER_URL           [NSString stringWithFormat:@"%@%@",@"http://www.58caibiao.com:8788",@"/cbapiprj/webService"]


@implementation LQHTTPSessionManager

- (id)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (!self)
    {
        return nil;
    }
    
    // Requset 非JSON
    self.requestSerializer = [AFHTTPRequestSerializer serializer];
    // Response JSON
    self.responseSerializer = [AFJSONResponseSerializer serializer];
    // Timte Out
    self.requestSerializer.timeoutInterval = 20;
    
    
    return self;
}

#pragma mark - Static Public
+ (instancetype)sharedManager
{
    static LQHTTPSessionManager *sessionManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sessionManager = [[LQHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:SERVER_URL]];
        NSString *serveir = SERVER_URL;
        NSLog(@"serverurl --- %@",serveir);
    });
    return sessionManager;
}

#pragma mark -
#pragma mark ================= Static Public =================
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
      failure:(void (^)(NSError *error))failure
{
    if (showTips.length)
    {
        [LCProgressHUD showLoading:showTips];
    }
    
    DLog(@"\n===========POST===========\n%@:\n%@", URLString, parameters);
    [self POST:URLString
    parameters:parameters
       success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
           DLog(@"\n===========success===========\n%@:\n%@", URLString, responseObject);
           [self parsingRequestBack:responseObject sucess:success successBackfailError:successBackfailError showTips:showTips];
       } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
           DLog(@"\n===========error===========\n%@:\n%@", URLString, error);
           
           if (showTips.length)
           {
               [LCProgressHUD showFailure:@"网络异常，请稍后再试"];
           }
           
           failure(error);
       }];
}

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
       failure:(void (^)(NSError *error))failure
{
    if (showTips.length)
    {
        [LCProgressHUD showLoading:showTips];
    }
    
    DLog(@"\n===========POST===========\n%@:\n%@", URLString, parameters);
    
    [self POST:URLString
    parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        int m = 0;
        for (NSDictionary *fileInfo in fileInfos)
        {
            if (fileInfo)
            {
                [formData appendPartWithFileData:fileInfo[@"kFileData"]
                                            name:fileInfo[@"kName"]
                                        fileName:fileInfo[@"kFileName"]
                                        mimeType:fileInfo[@"kMimeType"]];
            }
            m ++;
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        DLog(@"\n===========success===========\n%@:\n%@", URLString, responseObject);
        [self parsingRequestBack:responseObject sucess:success successBackfailError:successBackfailError showTips:showTips];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DLog(@"\n===========error===========\n%@:\n%@", URLString, error);
        if (showTips.length)
        {
            [LCProgressHUD showFailure:@"网络异常，请稍后再试"];
        }
        failure(error);
    }];
}

/**
 *  请求成功后的数据解析
 *
 *  @param responseObject         地址
 *  @param success                成功
 *  @param successBackfailError   失败
 *  @param showTips               提示
 */
- (void)parsingRequestBack:(id)responseObject
                    sucess:(void (^)(id responseObject))success
      successBackfailError:(void (^)(id responseObject))successBackfailError
                  showTips:(NSString *)showTips
{
    BaseModel *baseModel = [BaseModel mj_objectWithKeyValues:responseObject];
    
    if(baseModel.state == 0)
    {
        [LCProgressHUD hide];

        success(baseModel.data);
        return;
    }
    
    if (baseModel.fieldErrors.count)
    {
        ModelFieldError *modelFieldError = [baseModel.fieldErrors firstObject];
        
        if ([modelFieldError.message isEqualToString:@""])
        {
            [LCProgressHUD hide];
        }
        else if (![modelFieldError.message isEqualToString:@"无数据"])
        {
            if (showTips.length)
            {
                [LCProgressHUD showFailure:modelFieldError.message];
            }
        }
        else
        {
            [LCProgressHUD hide];
        }
        
        successBackfailError(modelFieldError);
    }
}

@end
