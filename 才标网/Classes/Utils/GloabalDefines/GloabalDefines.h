//
//  GloabalDefines.h
//  我的框架
//
//  Created by liqiang on 16/3/24.
//  Copyright © 2016年 Liqiang. All rights reserved.
//


#ifndef GloabalDefines_h
#define GloabalDefines_h

//通知
#define NOTIFICATION_EnterBackground               @"NOTIFICATION_EnterBackground"
#define NOTIFICATION_EnterForeground               @"NOTIFICATION_EnterForeground"
#define NOTIFICATION_PaySuccess                    @"NOTIFICATION_PaySuccess"

//主要单例
#define UserDefaults                        [NSUserDefaults standardUserDefaults]
#define NotificationCenter                  [NSNotificationCenter defaultCenter]
#define SharedApplication                   [UIApplication sharedApplication]
#define APPDELEGATE                         (AppDelegate *)[[UIApplication sharedApplication] delegate]
#define WINDOW                              [[UIApplication sharedApplication].delegate window]

//  大小尺寸
#define ScreenWidth                         [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight                        ([[UIScreen mainScreen] bounds].size.height-64)
#define ScreenHeight2                       ([[UIScreen mainScreen] bounds].size.height)
#define KScreenHeight                       [[UIScreen mainScreen] bounds].size.height
#define TabBarHeight                        50
#define SizeScale(s) ([[UIScreen mainScreen] bounds].size.height > 568 ?  ([[UIScreen mainScreen] bounds].size.height / 568.0 * (s)) : (s * 1.0))

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

//屏幕适配
#define UIRate  ScreenWidth/375.0


/**
 颜色

 @param r red
 @param g green
 @param b blue
 @param a 透明度
 @return UIColor
 */
#define RGBCOLOR(r, g, b, a) [UIColor colorWithRed:(r / 255.0) green:(g / 255.0) blue:(b / 255.0) alpha:a]

//hex颜色
#define HEXCOLOR(c) [UIColor colorWithRed:((c>>16)&0xFF)/255.0 green:((c>>8)&0xFF)/255.0 blue:(c&0xFF)/255.0 alpha:1.0]

//hexA颜色(带透明度)
#define HEXACOLOR(c,a) [UIColor colorWithRed:((c>>16)&0xFF)/255.0 green:((c>>8)&0xFF)/255.0 blue:(c&0xFF)/255.0 alpha:a]

//font
#define SYSTEM_FONT_(x)               [UIFont systemFontOfSize:x]
#define SYSTEM_FONT_BOLD_(a)          [UIFont boldSystemFontOfSize:a]

#define FONT_TEXTSIZE_VerySmall       SYSTEM_FONT_(10)//特小（图标配字）
#define FONT_TEXTSIZE_Small           SYSTEM_FONT_(12)//小号（特别提示，如时间，地点）
#define FONT_TEXTSIZE_Mid             SYSTEM_FONT_(14)//中号（内容区摘要记录、正文、提示）
#define FONT_TEXTSIZE_LargeMid        SYSTEM_FONT_(15)//中号（内容区摘要记录、正文、提示）
#define FONT_TEXTSIZE_Big             SYSTEM_FONT_(16)//大号（内容区标题、人名、模块入口、按钮）
#define FONT_TEXTSIZE_VeryBig         SYSTEM_FONT_(18)//特大号（导航栏Head标题）

#define COLOR_White                   HEXCOLOR(0xffffff)//白(多用于按钮上)
#define COLOR_Black                   HEXCOLOR(0x333333)//黑（标题、正文）
#define COLOR_Gray                    HEXCOLOR(0x999999)//灰（辅助文字）
#define COLOR_darkGray                HEXCOLOR(0x666666)//深灰（提示文字）
#define COLOR_LightGray               HEXCOLOR(0xc7c7cd)//浅灰（输入提示文字）
#define COLOR_Red                     HEXCOLOR(0xe54650)//红（提醒文字）
#define COLOR_Orange                  HEXCOLOR(0xff9900)//橙（金额）
#define COLOR_OrangeRed               HEXCOLOR(0xff5c0b)//橙红
#define COLOR_OrangeLight             HEXCOLOR(0xff9c00)//橙（亮橙色）
#define COLOR_Green                   HEXCOLOR(0x329d2f)//绿色
#define COLOR_Blue                    HEXCOLOR(0x2196ff)//蓝色  

#define COLOR_LOGIN                   HEXCOLOR(0xffb739)//登录按钮
#define COLOR_LOGINTEXT               HEXCOLOR(0xd2d7dc)//注册文字
#define COLOR_VOICE                   HEXCOLOR(0xffde00)//语音信息文字


#define COLOR_ButtonBackGround_Red    HEXCOLOR(0xec5050)
#define COLOR_ButtonBackGround_Green  HEXCOLOR(0x06bf04)
#define COLOR_ButtonBackGround_White  HEXCOLOR(0xffffff)
#define COLOR_ButtonBackGround_Gray   HEXCOLOR(0xe1e1e1)
#define COLOR_ButtonBackGround_Blue   HEXCOLOR(0x2196ff) //按钮蓝色
#define COLOR_ButtonBackGround_Orange HEXCOLOR(0xff8400) //按钮橙色

#define COLOR_LineViewColor           HEXCOLOR(0xcccccc)  //浅灰

#define COLOR_BackgroundColor         HEXCOLOR(0xeeeeee)  //米白
#define NAV_BAR_COLOR                 COLOR_White  //浅灰
#define COLOR_Red2                    HEXCOLOR(0xe7454d)//红


#define kCell                         @"kCell"
#define kModel                        @"kModel"
#define kTitle                        @"kTitle"
#define kSubTitle                     @"kSubTitle"
#define kKey                          @"kKey"
#define kValue                        @"kValue"
#define kValue2                       @"kValue2"
#define kUrl                          @"kUrl"
#define kMethod                       @"kMethod"
#define kParameter                    @"kParameter"
#define kENum                         @"kENum"
#define kType                         @"kType"
#define kArray                        @"kArray"
#define kColor                        @"kColor"
#define kImage                        @"kImage"
#define kRead                         @"kRead"
#define kDateTime                     @"kDateTime"



#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define KNOTIFICATION_LOGINCHANGE @"loginStateChange"
#define KNOTIFICATION_CHAT @"chat"
#define KNOTIFICATION_SETTINGCHANGE @"settingChange"
#define KNOTIFICATION_ADDMSG_TO_LIST @"addmsgtolist"
#define CHATVIEWBACKGROUNDCOLOR [UIColor colorWithRed:0.936 green:0.932 blue:0.907 alpha:1]

//商城默认配置
//#define kDefaultAppKey @"1141161024115978#kefuchannelapp29593"
#define kDefaultAppKey @"1124161024178184#kefuchannelapp29044"
//#define kDefaultCustomerName @"kefuchannelimid_012680"
#define kDefaultCustomerName @"kefuchannelimid_008267"
#define kDefaultTenantId  @"29593";
#define kDefaultProjectId @"306713";

//#define kDefaultCustomerName @"130121"
//#define kDefaultAppKey @"culiukeji#99baoyou"
//#define kDefaultCustomerName @"culiutest3"

#define kAppKey @"CSEM_appkey"
#define kCustomerName @"CSEM_name"
#define kCustomerNickname @"CSEM_nickname"
#define kCustomerTenantId @"CSEM_tenantId"
#define kCustomerProjectId @"CSEM_projectId"



#define kEaseMobUserToken @"token"
#define kKefuBaseURL @"https://kefu.easemob.com"


//Ext keyWord
#define kMesssageExtWeChat @"weichat"
#define kMesssageExtWeChat_ctrlType @"ctrlType"
#define kMesssageExtWeChat_ctrlType_enquiry @"enquiry"
#define kMesssageExtWeChat_ctrlType_inviteEnquiry @"inviteEnquiry"
#define kMesssageExtWeChat_ctrlType_transferToKfHint  @"TransferToKfHint"
#define kMesssageExtWeChat_ctrlType_transferToKf_HasTransfer @"hasTransfer"
#define kMesssageExtWeChat_ctrlArgs @"ctrlArgs"
#define kMesssageExtWeChat_ctrlArgs_inviteId @"inviteId"
#define kMesssageExtWeChat_ctrlArgs_serviceSessionId @"serviceSessionId"
#define kMesssageExtWeChat_ctrlArgs_detail @"detail"
#define kMesssageExtWeChat_ctrlArgs_summary @"summary"
#define kMesssageExtWeChat_ctrlArgs_label @"label"


//weak strong
#define kStrongSelf __strong __typeof(self) strongSelf = self;
#define kWeakSelf __weak __typeof__(self) weakSelf = self;


#endif
