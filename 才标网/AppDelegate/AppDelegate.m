//
//  AppDelegate.m
//  我的框架
//
//  Created by liqiang on 16/7/19.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "CBConnect.h"
#import "UserHelper.h"
#import "ToolsHelper.h"
#import "BaseTabbarController.h"
#import <AlipaySDK/AlipaySDK.h>

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>

//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

//微信SDK头文件
#import "WXApi.h"

#import "UserHelper.h"
#import "BaseNavigationController.h"
#import "GuideVC.h"

//base64加密
#import "GTMBase64.h"

//极光推送
#import "JPUSHService.h"
#import <AdSupport/AdSupport.h>
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

//消息页面
#import "PushMessageVC.h"

#define WX_APPID @"wx0347561f943b4202"
#import "TalkingData.h"

@interface AppDelegate ()<WXApiDelegate,UITabBarControllerDelegate,GuideVCDelegate,PushMessageDelegate,JPUSHRegisterDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    //注册极光推送
    [self registerJPushWith:launchOptions];

    //初始化talkingData
    [TalkingData sessionStarted:@"8FABB55FFF604D86BFAA0095767BFD53" withChannelId:@"app store"];
    
    //shareSDK
    [self registerShareSDK];
    
    //注册微信支付
    [WXApi registerApp:WX_APPID];
    
    
    //加载DCURLRouter.plist文件数据
    [DCURLRouter loadConfigDictFromPlist:@"DCURLRouter.plist"];
    
   // self.window.rootViewController = [[BaseNavigationController alloc] initWithRootViewController:[[LoginViewController alloc] init]];
    
    if ([UserHelper isOpened]){//不是第一次
        BaseTabbarController *rootTabbar = [[BaseTabbarController alloc] init];
        rootTabbar.delegate = self;
        self.window.rootViewController = rootTabbar;
    }else {
        GuideVC *guideVC = [[GuideVC alloc] init];
        guideVC.delegate = self;
        self.window.rootViewController = guideVC;
    }
    
    return YES;
}

- (BOOL)application:(UIApplication *)application shouldAllowExtensionPointIdentifier:(NSString *)extensionPointIdentifier
{
    NSLog(@"====>%@",extensionPointIdentifier);
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    //发送通知 进入后台
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [application setApplicationIconBadgeNumber:0];
    [JPUSHService setBadge:0];//清空角标
    [application cancelAllLocalNotifications];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    if (![UserHelper IsLogin]){
        
        if ([viewController.tabBarItem.title isEqualToString:@"我"]){
            LoginViewController *loginVC = [[LoginViewController alloc] init];
            BaseNavigationController *baseNav = [[BaseNavigationController alloc] initWithRootViewController:loginVC];
            [[tabBarController selectedViewController] presentViewController:baseNav animated:YES completion:nil];
            return NO;
        }else {
            return YES;
        }
    }
    return YES;
}
#pragma mark - =======PushMessageDelegate 消息页代理==============
-(void)exit{
    
}
#pragma mark - ==============GuideVCDelegate 引导页代理=================
- (void)enterTheApp{
    [UserHelper setIsOpened:@"1"]; //保存已经打开过
    BaseTabbarController *rootTabbar = [[BaseTabbarController alloc] init];
    rootTabbar.delegate = self;
    self.window.rootViewController = rootTabbar;
}

#pragma mark - ================= 支付宝&微信支付 =================
//微信支付 重写AppDelegate的handleOpenURL和openURL方法
// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    
    NSString *urlStr = [options objectForKey:@"UIApplicationOpenURLOptionsSourceApplicationKey"];
    
    
    if ([urlStr isEqualToString:@"com.tencent.xin"])
    {   //  微信支付
        [WXApi handleOpenURL:url delegate:self];
    }
    
    if ([url.host isEqualToString:@"safepay"])
    {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
             id resultStatus = [resultDic objectForKey:@"resultStatus"];
            switch ([resultStatus integerValue]) {
                case 9000:
                    //支付成功
                    [LCProgressHUD showSuccess:@"支付成功"];
                    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationAliPayResultSuccess object:nil];
                    break;
                case 4000:
                     [LCProgressHUD showFailure:@"支付失败"];
                    break;
                case 6001:
                    [LCProgressHUD showMessage:@"支付取消"];
                    break;
                case 6002:
                     [LCProgressHUD showMessage:@"网络连接失败"];
                    break;
                default:
                    break;
            }
        }];
    }
    
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    
    if ([url.host isEqualToString:@"com.tencent.xin"])
    {   //  微信支付
        [WXApi handleOpenURL:url delegate:self];
    }
    
    if ([url.host isEqualToString:@"safepay"])
    {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
    }
    
    return YES;
}

//WXApiDelegate
-(void)onResp:(BaseResp *)resp
{
    if ([resp isKindOfClass:[PayResp class]]) {
        PayResp*response=(PayResp*)resp;  // 微信终端返回给第三方的关于支付结果的结构体
        switch (response.errCode) {
            case WXSuccess:
            {
            // 支付成功后发送通知，在控制器里面进行操作
            [[NSNotificationCenter defaultCenter] postNotificationName:NotificationWexinPayResultSuccess object:nil];
                NSLog(@"支付成功");
                
            }
                break;
            case WXErrCodeCommon:
            { //签名错误、未注册APPID、项目设置APPID不正确、注册的APPID与设置的不匹配、其他异常等
                NSLog(@"支付失败");
                [LCProgressHUD showFailure:@"支付失败"];
            }
                break;
            case WXErrCodeUserCancel:
            { //用户点击取消并返回
                NSLog(@"取消支付");
                [LCProgressHUD showFailure:@"取消支付"];
            }
                break;
            case WXErrCodeSentFail:
            { //发送失败
                NSLog(@"发送失败");
                [LCProgressHUD showFailure:@"发送失败"];
            }
                break;
            case WXErrCodeUnsupport:
            { //微信不支持
                NSLog(@"微信不支持");
                [LCProgressHUD showFailure:@"微信不支持"];
            }
                break;
            case WXErrCodeAuthDeny:
            { //授权失败
                NSLog(@"授权失败");
                [LCProgressHUD showFailure:@"授权失败"];
            }
                break;
            default:
                break;
        }
    }else{
        NSLog(@"error -- %@",resp);
    }
}

#pragma mark -  =========shareSDK三方登录分享============
- (void)registerShareSDK{
    /**
     *  设置ShareSDK的appKey，如果尚未在ShareSDK官网注册过App，请移步到http://mob.com/login 登录后台进行应用注册，
     *  在将生成的AppKey传入到此方法中。
     *  方法中的第二个第三个参数为需要连接社交平台SDK时触发，
     *  在此事件中写入连接代码。第四个参数则为配置本地社交平台时触发，根据返回的平台类型来配置平台信息。
     *  如果您使用的时服务端托管平台信息时，第二、四项参数可以传入nil，第三项参数则根据服务端托管平台来决定要连接的社交SDK。
     */
    [ShareSDK registerApp:@"1c95a29ad6dc9"
     
          activePlatforms:@[@(SSDKPlatformTypeWechat),
                            @(SSDKPlatformTypeQQ)]
                 onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             case SSDKPlatformTypeQQ:
                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                 break;
             default:
                 break;
                 
         }
     }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:@"wxe2053cbb105fa55b"
                                       appSecret:@"99887af53031e6b616c8d8ae87c7a5c1"];
                 break;
             case SSDKPlatformTypeQQ:
                 [appInfo SSDKSetupQQByAppId:@"1106004243"
                                      appKey:@"SSYsolH7ix6zRk6i"
                                    authType:SSDKAuthTypeBoth];
                 break;
             default:
                 break;
         }
     }];
}

-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    NSLog(@"handleOpenURL %@",url);
    return YES;
}

#pragma mark - ==========极光推送===============
- (void)registerJPushWith:(NSDictionary *)launchOptions{
    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    
    // 3.0.0及以后版本注册可以这样写，也可以继续用旧的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    //如不需要使用IDFA，advertisingIdentifier 可为nil
    [JPUSHService setupWithOption:launchOptions appKey:@"6eccb7f7f2dfe17c91ac9fd5"
                          channel:@"AppStore"
                 apsForProduction:JPUSH_IS_PRO //不同环境不同配置
            advertisingIdentifier:advertisingId];
    
    //2.1.9版本新增获取registration id block接口。
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        if(resCode == 0){
            NSLog(@"registrationID获取成功：%@",registrationID);
            
        }
        else{
            NSLog(@"registrationID获取失败，code：%d",resCode);
        }
    }];
    
    //JPush 监听登陆成功
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(kJPushnetworkDidLogin:)
                                                 name:kJPFNetworkDidLoginNotification
                                               object:nil];

}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    DLog(@"%@", [NSString stringWithFormat:@"极光推送获得的Device Token: %@", deviceToken]);
   
    [JPUSHService registerDeviceToken:deviceToken];
    _pushTokenStr = [[[[deviceToken description] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (_pushTokenStr.length > 41){
         _pushTokenStr = [_pushTokenStr substringToIndex:40];
    }
   
    NSLog(@"上传token= %@", _pushTokenStr);
    NSString *deviceIdString = [GTMBase64 encodeBase64String:_pushTokenStr];
    
    // 存到
    [UserHelper setPushToken:deviceIdString];
    
    //上传设备号
    [self requestModifyMsgRead];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:
(UIUserNotificationSettings *)notificationSettings {
}
// Called when your app has been activated by the user selecting an action from
// a local notification.
// A nil action identifier indicates the default action.
// You should call the completion handler as soon as you've finished handling
// the action.
- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void (^)())completionHandler {
}

// Called when your app has been activated by the user selecting an action from
// a remote notification.
// A nil action identifier indicates the default action.
// You should call the completion handler as soon as you've finished handling
// the action.
- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void (^)())completionHandler {
}
#endif

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    [JPUSHService handleRemoteNotification:userInfo];
    NSLog(@"iOS7及以上系统，收到通知:%@", [ToolsHelper logDic:userInfo]);
    
    if ([[UIDevice currentDevice].systemVersion floatValue]<10.0 || application.applicationState>0) {
    }
    
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    [JPUSHService showLocalNotificationAtFront:notification identifierKey:nil];
}

#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#pragma mark- JPUSHRegisterDelegate
//- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
//    NSDictionary * userInfo = notification.request.content.userInfo;
//    
//    UNNotificationRequest *request = notification.request; // 收到推送的请求
//    UNNotificationContent *content = request.content; // 收到推送的消息内容
//    
//    NSNumber *badge = content.badge;  // 推送消息的角标
//    NSString *body = content.body;    // 推送消息体
//    UNNotificationSound *sound = content.sound;  // 推送消息的声音
//    NSString *subtitle = content.subtitle;  // 推送消息的副标题
//    NSString *title = content.title;  // 推送消息的标题
//    
//    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
////        [JPUSHService handleRemoteNotification:userInfo];
//        NSLog(@"iOS10 前台收到远程通知:%@", [ToolsHelper logDic:userInfo]);
//    }
//    else {
//        // 判断为本地通知
//        NSLog(@"iOS10 前台收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
//    }
//    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
//}

- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    UNNotificationRequest *request = response.notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        NSLog(@"iOS10 收到远程通知:%@", [ToolsHelper logDic:userInfo]);
        
        if ([UserHelper IsLogin] && [UserHelper isOpened]){//是否登录
            PushMessageVC *vc = [[PushMessageVC alloc]init];
             BaseNavigationController *baseNav = [[BaseNavigationController alloc] initWithRootViewController:vc];
            [self.window.rootViewController presentViewController:baseNav animated:YES completion:^{
            }];

        }else {
          // 如果没登录  不做处理
            
        }
    }
    else {
        // 判断为本地通知
        NSLog(@"iOS10 收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
    }
    
    completionHandler();  // 系统要求执行这个方法
}
#endif

/**
 *  登录成功，设置别名，移除监听
 *  @param notification 信息
 */
- (void)kJPushnetworkDidLogin:(NSNotification *)notification {
    DLog(@"极光推送已登录");
    //本处用的token做为别名
    [JPUSHService setAlias:self.pushTokenStr callbackSelector:nil object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:kJPFNetworkDidLoginNotification
                                                  object:nil];
}

#pragma mark - ========网络－上传设备=========
- (void)requestModifyMsgRead{
    
    if (![UserHelper getMemberId].length){
        return;
    }
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:[UserHelper getMemberId] forKey:@"receiverId"];
    [params setValue:@(2) forKey:@"deviceType"];//设备类型，1-android；2-IOS
    [params setValue:[UserHelper getPushToken] forKey:@"deviceId"];
    
    [CBConnect getOtherSetDeviceInfo:params success:^(id responseObject) {
        
    } successBackfailError:^(id responseObject) {
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}


@end
