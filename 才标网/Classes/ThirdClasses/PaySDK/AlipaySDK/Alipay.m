//
//  Alipay.m
//  才标网
//
//  Created by caohouhong on 17/3/30.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "Alipay.h"
#import "Order.h"
#import "RSADataSigner.h"
#import <AlipaySDK/AlipaySDK.h>

#define Alipay_APPID           @"2016032201233696"  //appID
#define ALIPAY_APP_URLSCHEME   @"com.pinqilai.alipay"
///私钥
#define Alipay_PrivateKey @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBALpQrV93pc1BYTZmczxSP790u1k1WO5+Mor0ZuCT49nhYR8o37HP68MmGtQ7YddXiKBP+SS6OV3X2ceD0uBb05F/bQv/TLRmQOXNfRpTlqgoJkerh997SVNQrQqrZcOjNzVnDtTrhTJx+uQwh5Tex79OVmPjwduMzrp7B5geC7vpAgMBAAECgYBJKMDLSeobDN8lQ1lgiFNr1GR0hRQkof0qvwleifPgbDV8zMn5wlErUd0bFS44JrEJch28pDs+dDGZvFOjsasDPIofpS9BLUJhYhyEAPP51LenIAUOSTXnP/wX7rEtZIS58BE8lWONVdY4rbRabvcPJOYgHYoHNgHePI8NGe+N4QJBAPF/kO+gbR9ruHfWWFK5gZ06+x2lDWT0cGjyfWlGJK8gojyPkAQiM/cQ2Ze8yJGgX9/sx0Ak0PiSZtImyTrSqwUCQQDFgM7FHT5WnVKxsM3YwQeoSmIGbueDLhCgghF6dSHpOU75mfFqJBN/CX3asmeECBhsY/OMLLjEVUYWIiZHwAqVAkBPQGDM8qW88PnZgeL8StppQcjU4qxxm/IjzqgvWxCA1EHJhAdsA9lv0/zEWfSsLago8Sg2OZ7GZC0P/CB/iFENAkAoRh/j6hawKtyWB2uya4pYMvLSRQNIqLgTQvK1efU0Tc9g7pdgAYNIQHM9iWu6bLwuPiOHzgbPYmQsV0JfFzYRAkEAicce0x/r3bdhtr8cjCdSg3dMN4X1mMIa7ejb+88yhou4tLwtJRKB1+UfXRf2xVN/JGem4SZZXk728KIOTB2RBg=="

@interface Alipay(){
}
@property (nonatomic, strong) NSString *subject;//订单信息
@property (nonatomic, strong) NSString *price;//价格
@property (nonatomic, strong) NSString *outTradeNo;//订单id

@end

@implementation Alipay


- (instancetype)initWithProductSubject:(NSString *)subject andPrice:(NSString *)price andOutTradeNo:(NSString *)outTradeNo
{
    self = [super init];
    if (self) {
        self.subject = subject;
        self.price = price;
        self.outTradeNo = outTradeNo;
    }
    return self;
}


//
//选中商品调用支付宝极简支付
//
- (void)doAlipayPay
{
    //重要说明
    //这里只是为了方便直接向商户展示支付宝的整个支付流程；所以Demo中加签过程直接放在客户端完成；
    //真实App里，privateKey等数据严禁放在客户端，加签过程务必要放在服务端完成；
    //防止商户私密数据泄露，造成不必要的资金损失，及面临各种安全风险；
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *appID = Alipay_APPID;
    
    // 如下私钥，rsa2PrivateKey 或者 rsaPrivateKey 只需要填入一个
    // 如果商户两个都设置了，优先使用 rsa2PrivateKey
    // rsa2PrivateKey 可以保证商户交易在更加安全的环境下进行，建议使用 rsa2PrivateKey
    // 获取 rsa2PrivateKey，建议使用支付宝提供的公私钥生成工具生成，
    // 工具地址：https://doc.open.alipay.com/docs/doc.htm?treeId=291&articleId=106097&docType=1
    NSString *rsa2PrivateKey = @"";
    NSString *rsaPrivateKey = Alipay_PrivateKey;
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //partner和seller获取失败,提示
    if ([appID length] == 0 ||
        ([rsa2PrivateKey length] == 0 && [rsaPrivateKey length] == 0))
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少appId或者私钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order* order = [Order new];
    
    // NOTE: app_id设置
    order.app_id = appID;
    
    // NOTE: 支付接口名称
    order.method = @"alipay.trade.app.pay";
    
    // NOTE: 参数编码格式
    order.charset = @"utf-8";
    
    // NOTE: 当前时间点
    NSDateFormatter* formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    order.timestamp = [formatter stringFromDate:[NSDate date]];
    
    // NOTE: 支付版本
    order.version = @"1.0";
    
    // NOTE: sign_type 根据商户设置的私钥来决定
    order.sign_type = (rsa2PrivateKey.length > 1)?@"RSA2":@"RSA";
    
    order.notify_url = @"http://www.liulianchuguo.com:8789/cbbackprj/alipayTaskSuccess.action";
    
    // NOTE: 商品数据
    order.biz_content = [BizContent new];
    order.biz_content.body = @"购买";
    order.biz_content.subject = self.subject;
    order.biz_content.out_trade_no = self.outTradeNo; //订单ID（由商家自行制定）
    order.biz_content.timeout_express = @"30m"; //超时时间设置
    order.biz_content.total_amount = [NSString stringWithFormat:@"%.2f", [self.price doubleValue]]; //商品价格
    

    
    //将商品信息拼接成字符串
    NSString *orderInfo = [order orderInfoEncoded:NO];
    NSString *orderInfoEncoded = [order orderInfoEncoded:YES];
    NSLog(@"orderSpec = %@",orderInfo);
    
    // NOTE: 获取私钥并将商户信息签名，外部商户的加签过程请务必放在服务端，防止公私钥数据泄露；
    //       需要遵循RSA签名规范，并将签名字符串base64编码和UrlEncode
    NSString *signedString = nil;
    RSADataSigner* signer = [[RSADataSigner alloc] initWithPrivateKey:((rsa2PrivateKey.length > 1)?rsa2PrivateKey:rsaPrivateKey)];
    if ((rsa2PrivateKey.length > 1)) {
        signedString = [signer signString:orderInfo withRSA2:YES];
    } else {
        signedString = [signer signString:orderInfo withRSA2:NO];
    }
    
    // NOTE: 如果加签成功，则继续执行支付
    if (signedString != nil) {
        //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
        NSString *appScheme = ALIPAY_APP_URLSCHEME;
        
        // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
        NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@",
                                 orderInfoEncoded, signedString];
        
       // NOTE: 调用支付结果开始支付
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic)
        {
            //网页的回调会走到这，app 的回调到appDelegate里
            
        }];
    }
}

@end
