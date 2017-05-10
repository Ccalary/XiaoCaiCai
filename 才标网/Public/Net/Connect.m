//
//  Connect.m
//  才标网
//
//  Created by caohouhong on 17/3/15.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "Connect.h"

@implementation Connect
+ (Connect *)sharedInstance {
    static Connect * _sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[Connect alloc] init];
    });
    
    return _sharedInstance;
}

//get
-(void)doTestGetNetWorkWithUrl:(NSString*)url parameters:(id)parameters success:(void (^)(NSURLSessionDataTask *operation, NSDictionary *responseDic))success failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    [self doGetWithUrl:url parameters:parameters success:^(NSURLSessionDataTask *operation, NSDictionary *responseDic) {
        success(operation, responseDic);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
}

/**
 post接口请求

 @param url 接口地址
 @param parameters 参数
 @param success 成功
 @param successBackfailError 返回失败
 @param failure 请求失败
 */
-(void)doTestPostNetWorkWithUrl:(NSString*)url parameters:(id)parameters success:(void (^)(id responseObject))success
           successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    
    [self doPostWithUrl:url parameters:parameters success:^(id responseObject) {
        success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
    
}

/**
 图片上传（文件流上传）
 
 @param url 接口地址
 @param parameters 参数
 @param success 成功
 @param array UIImage 的数组
 @param isNone 是否为空 如果是空则传none.png
 @param successBackfailError 返回失败
 @param failure 请求失败
 */

-(void)doTestImagePostNetWorkWithUrl:(NSString*)url parameters:(id)parameters imageArray:(NSArray *)array isNone:(BOOL)isNone success:(void (^)(id responseObject))success
           successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    
    [self doPostImageWithUrl:url parameters:parameters imageArray:array isNone:isNone success:^(id responseObject) {
         success(responseObject);
    } successBackfailError:^(id responseObject) {
        successBackfailError(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(operation,error);
    }];
}



-(void)doGetWithUrl:(NSString*)url parameters:(id)parameters success:(void (^)(NSURLSessionDataTask *operation, NSDictionary *responseDic))success failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success){
            success(task,responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure){
            failure(task,error);
        }
    }];
    
}

/**
 post上传
 
 @param url 接口地址
 @param parameters 参数
 @param success 成功
 @param successBackfailError 返回失败
 @param failure 请求失败
 */

-(void)doPostWithUrl:(NSString*)url parameters:(id)parameters success:(void (^)(id responseObject))success
successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
        DLog(@"request url: %@ param :%@",url, parameters);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success){
            DLog(@"result:%@",responseObject);
            [self parsingRequestBack:responseObject sucess:success successBackfailError:successBackfailError];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure){
            failure(task,error);
            [LCProgressHUD showFailure:@"网络异常，请稍后再试"];
        }
    }];
}

/**
 图片上传（文件流上传）

 @param url 接口地址
 @param parameters 参数
 @param success 成功
 @param array UIImage 的数组
 @param isNone 是否为空 如果是空则传none.png
 @param successBackfailError 返回失败
 @param failure 请求失败
 */
-(void)doPostImageWithUrl:(NSString*)url parameters:(id)parameters imageArray:(NSArray *)array isNone:(BOOL)isNone  success:(void (^)(id responseObject))success
successBackfailError:(void (^)(id responseObject))successBackfailError failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
         DLog(@"request url: %@ param :%@",url, parameters);
        
        for (UIImage *image in array){
            NSData *imageData = UIImageJPEGRepresentation(image, 0.2);
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat =@"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
            //如果后台默认为空，则默认命名none.png
            if (isNone){
                fileName = @"none.png";
            }
            //上传的参数(上传图片，以文件流的格式)
            [formData appendPartWithFileData:imageData
                                        name:@"file"
                                    fileName:fileName
                                    mimeType:@"image/jpeg"];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success){
            DLog(@"result:%@",responseObject);
            [self parsingRequestBack:responseObject sucess:success successBackfailError:successBackfailError];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure){
            failure(task,error);
            [LCProgressHUD showFailure:@"网络异常，请稍后再试"];
        }
    }];
}



/**
 *  请求成功后的数据解析
 */

- (void)parsingRequestBack:(id)responseObject
                    sucess:(void (^)(id responseObject))success
      successBackfailError:(void (^)(id responseObject))successBackfailError
{
    BaseModel *baseModel = [BaseModel mj_objectWithKeyValues:responseObject];
    
    if(baseModel.state == 0) //0是成功
    {
        [LCProgressHUD hide];
        
        success(baseModel.data);
        return;
    }
    
    if (baseModel.fieldErrors.count)
    {
        ModelFieldError *modelFieldError = [baseModel.fieldErrors firstObject];
        
        if (modelFieldError.field != -6) { //请求失败
            [LCProgressHUD showFailure:modelFieldError.message];
        }else{
            [LCProgressHUD hide];
        }
        successBackfailError(modelFieldError);
    }
}


@end
