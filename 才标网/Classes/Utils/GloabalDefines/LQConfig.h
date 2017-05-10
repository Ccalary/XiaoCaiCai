//
//  LQConfig.h
//  ZhouMo
//
//  Created by liqiang on 2016/11/3.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#ifndef LQConfig_h
#define LQConfig_h


#if 1 //测试服务器
#define IP                         @"http://121.40.94.85:8788"
#define IMAGES_OSS_PIC             @"http://imgcdn.58caibiao.com/filetest"
#else//证书服务器
#define IP                         @"http://121.40.94.85:8788"
#define IMAGES_OSS_PIC             @"http://imgcdn.58caibiao.com/filetest"
#endif


#define SERVER_URL                 [NSString stringWithFormat:@"%@%@",IP,@"/cbapiprj/webService"]
#define IMAGE_URL(urlStr)          [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGES_OSS_PIC,urlStr]]


/**
 *  1表示fir 2表示appstore
 */
#define VersionInfoId 2

//QQ
#define APPKEY_QQ                  @"1105680264"
#define APPSECRET_QQ               @"p27QEt3ZZ33kpQo6"

//微博
#define APPKEY_WEIBO               @"3579242948"
#define APPSECRET_WEIBO            @"fc53bc735e7e25617c219236f8214278"

//微信
#define APPKEY_WECHAT              @"wxb42e236277b4f786"
#define APPSECRET_WECHAT           @"b79e7580d1ab3f2ac9c04eabab94f804"


#pragma mark -  ====微信支付参数配置====
// APPID
#define WX_APPID @"wx0347561f943b4202"//wxe2053cbb105fa55b

// AppSecret。
#define WX_APPSecret @"484c29f428f0cc31187c45b8d7eabba1"//99887af53031e6b616c8d8ae87c7a5c1
// 微信支付商户号
#define WX_MCH_ID  @"1325174801"
// 安全校验码（MD5）密钥，商户平台登录账户和密码登录http://pay.weixin.qq.com 平台设置的“API密钥”，为了安全，请设置为以数字和字母组成的32字符串。
#define WX_PartnerKey @"2f48ae43f36f4a6aa84e7ff6198ee604"
//微信统一下单接口连接
#define WX_PAY_URL @"https://api.mch.weixin.qq.com/pay/unifiedorder"



#endif /* LQConfig_h */
