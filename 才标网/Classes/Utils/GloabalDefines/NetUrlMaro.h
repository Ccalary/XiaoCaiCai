//
//  NetUrlMaro.h
//  才标网
//
//  Created by caohouhong on 17/3/15.
//  Copyright © 2017年 李强. All rights reserved.
//

#ifndef NetUrlMaro_h
#define NetUrlMaro_h

//0,1 来控制走生产还是测试
#if 0

//测试（服务器与图片地址）
#define BASE_URL_REl            @"http://www.58caibiao.com:8790/testapiprj"
//#define BASE_URL_REl            @"http://192.168.0.156:8080/cbapiprj"//陆建
#define IMAGES_OSS_PIC          @"http://imgcdn.58caibiao.com/filetest"
#else

//生产（服务器与图片地址）
#define BASE_URL_REl          @"http://www.58caibiao.com:8788/cbapiprj"
#define IMAGES_OSS_PIC        @"http://imgcdn.58caibiao.com/file"

#endif

//图片地址
#define IMAGE_URL(urlStr)       [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGES_OSS_PIC,urlStr]]


#pragma mark -  ============1.首页(HOME)============
/*******************首页(HOME)*********************/
//1.0 首页信息
#define HOME_GET_LIST_HOME_ALL   BASE_URL_REl@"/webService/task/listHomeAll"

//1.1任务广场
#define HOME_GET_TASKS_LISTTASKS   BASE_URL_REl@"/webService/task/listTasks"

//1.2任务详情
#define HOME_GET_TASKS_VIEWTASK   BASE_URL_REl@"/webService/task/viewTask"

//1.3发布投稿
#define HOME_GET_TASKS_TOUGAO   BASE_URL_REl@"/webService/task/touGao"

//1.4发布任务
#define HOME_GET_TASKS_ADDTASK   BASE_URL_REl@"/webService/task/addTask"

///1.5大师列表
#define HOME_GET_LIST_DASHI_MEMBER   BASE_URL_REl@"/webService/member/listDaShiMembers"

///1.6任务_发布任务
#define HOME_GET_ADD_TASK   BASE_URL_REl@"/webService/task/addTask"

///1.7大师套餐
#define HOME_GET_LIST_DASHI_PACKAGES   BASE_URL_REl@"/webService/version/listDashiPackages"

///1.8商标其名行业分类_列出全部分类树形结构数据
#define HOME_GET_LIST_CATEGORIES_TREE   BASE_URL_REl@"/webService/tradeMark/listCategoriesTree"

//1.9采纳投稿
#define HOME_GET_TASKS_USETOUGAO   BASE_URL_REl@"/webService/task/useTouGao"

//1.10编辑投稿

#define HOME_GET_MODIF_TOUGAO   BASE_URL_REl@"/webService/task/modifyTouGao"
//1.11举报

#define HOME_GET_IMPEACH_ADDIMPEACH   BASE_URL_REl@"/webService/impeach/addImpeach"
//1.12提问或回复

#define HOME_GET_TASK_ASKANSWER   BASE_URL_REl@"/webService/task/askAnswer"

//1.13删除投稿
#define HOME_GET_TASK_REMOVE   BASE_URL_REl@"/webService/task/removeTouGao"

//1.14自助起名(按关键字)
#define HOME_GET_NAME_BY_KEYWORD   BASE_URL_REl@"/webService/trademark/qiMingByKeyword"

//1.15自助起名(按行业)
#define HOME_GET_NAME_BY_HANGYE   BASE_URL_REl@"/webService/trademark/qiMingByHangYe"

//1.16商品_买商标或商标咨询注册
#define HOME_GET_BUY_TRADEMARK   BASE_URL_REl@"/webService/product/buyTrademark"

//1.17会员-个人信息详情(大师详情)
#define HOME_GET_MEMBER_VIEW_MEMBER   BASE_URL_REl@"/webService/member/viewMember"

//1.18列出全部分类树形结构数据
#define HOME_GET_TRADEMARK_COMPANYTYPE   BASE_URL_REl@"/webService/tradeMark/getCompanyTypes"

#pragma mark -  =========2.商标(BRAND)============
/******************商标(BRAND)*********************/
//2.0商标首页信息

//2.1文字检索
#define BRAND_GET_TRADEMARK_BYWORD   BASE_URL_REl@"/webService/trademark/listTrademarksByWord"

//2.2图片检索
#define BRAND_GET_TRADEMARK_BYPIC   BASE_URL_REl@"/webService/trademark/listTrademarksByPic"
//2.3商标分类
#define BRAND_GET_PRODUCT_SERVICES   BASE_URL_REl@"/webService/product/listProductServices"
//2.4商品详情
#define BRAND_GET_PRODUCT_DETAIL   BASE_URL_REl@"/webService/product/viewProductDetail"

//2.5推荐商品
#define BRAND_GET_PRODUCT_PRODUCTS   BASE_URL_REl@"/webService/product/listFeaturedProducts"
//2.6卖商标
#define BRAND_GET_PRODUCT_TRADEMARK   BASE_URL_REl@"/webService/product/transferTrademark"

///2.7 商标详情
#define BRAND_VIEW_TRADEMARK  BASE_URL_REl@"/webService/trademark/viewTrademark"

///2.8 添加订单
#define BRAND_ORDER_ADD_ORDER  BASE_URL_REl@"/webService/order/addOrder"

///2.9 商标申请
#define BRAND_VIEW_TRADEMARKAPPLY  BASE_URL_REl@"/webService/trademark/trademarkApply"

///2.10 商标收藏
#define BRAND_COLLECT_TRADEMARK  BASE_URL_REl@"/webService/trademark/collectTrademark"

///2.11 取消商标收藏
#define BRAND_UNCOLLECT_TRADEMARK  BASE_URL_REl@"/webService/trademark/unCollectTrademark"

///2.12 商标广告
#define BRAND_AD_LISTADS BASE_URL_REl@"/webService/ad/listAds"

#pragma mark -  =========3.个人中心(USERCENTER)============
/******************个人中心(USERCENTER)**************/
///3.0个人中心首页消息数据
#define USERCENTER_GET_UNREAD_MESSAGE_NUM  BASE_URL_REl@"/webService/message/getUnRedMsgNum"

///3.1 消息列表
#define USERCENTER_MESSAGE_LIST  BASE_URL_REl@"/webService/message/listMessages"

///3.2 消息已读
#define USERCENTER_MODIFY_MSG_READ  BASE_URL_REl@"/webService/message/modifyMsgToRead"

///3.3 查看会员帐户
#define USERCENTER_VIEW_MEMBER_ACCOUNT  BASE_URL_REl@"/webService/account/viewMemberAccount"

///3.4 查看会员帐户流水历史
#define USERCENTER_MEMBER_ACCOUNT_LIST_FLOWS  BASE_URL_REl@"/webService/account/listMemberAccountFlows"

///3.5 添加提现申请
#define USERCENTER_ADD_MEMBER_WITHDRAW_APPLY  BASE_URL_REl@"/webService/account/addMemberWithdrawCashApply"

///3.6 列出某个会员的提现记录列表
#define USERCENTER_WITHDRAW_APPLIES_LIST  BASE_URL_REl@"/webService/account/listWithdrawCashApplies"

///3.7 我_我的悬赏任务列表
#define USERCENTER_LIST_MY_TASKS  BASE_URL_REl@"/webService/task/listMyTasks"

///3.8 我的投稿(我所有投过稿的悬赏任务列表)
#define USERCENTER_LIST_MY_CONTRIBUTE_TASK  BASE_URL_REl@"/webService/task/listMyTouGaoXuanShangTasks"

///3.9 我_我是大师(我作为大师时收到的任务列表)
#define USERCENTER_LIST_MY_RECEIVED_TASK  BASE_URL_REl@"/webService/task/listMyReceivedDashiTasks"

///3.10 商标复查_我的商标复查列表
#define USERCENTER_LIST_BRAND_RECHECKS  BASE_URL_REl@"/webService/task/listBrandRechecks"

///3.11 商标复查_复查详情
#define USERCENTER_VIEW_BRAND_RECHECK  BASE_URL_REl@"/webService/task/viewBrandRecheck"

///3.12 商标复查_提交商标复查
#define USERCENTER_ADD_BRAND_RECHECK  BASE_URL_REl@"/webService/task/addBrandRecheck"

///3.13 我的订单－订单列表
#define USERCENTER_ORDER_LIST_ORDERS  BASE_URL_REl@"/webService/order/listOrders"

///3.14 我的订单－订单详情
#define USERCENTER_ORDER_VIEW_ORDER  BASE_URL_REl@"/webService/order/viewOrder"

///3.15 个人资料修改
#define USERCENTER_MEMBER_MODIFYMEMBER  BASE_URL_REl@"/webService/member/modifyMember"

///3.16 我的收藏
#define USERCENTER_LIST_MY_COLLECTION_TRADEMARK  BASE_URL_REl@"/webService/trademark/listMyCollectTrademark"
///3.17 我的订单去付款
#define USERCENTER_ORDER_TOPAY  BASE_URL_REl@"/webService/order/toPay"

///3.18 投稿人认证
#define USERCENTER_ADD_MEMBER_AUTH_APPLY  BASE_URL_REl@"/webService/member/addMemberAuthApply"

///3.19 获取投稿人认证信息
#define USERCENTER_VIEW_MEMBER_AUTH_APPLY  BASE_URL_REl@"/webService/member/viewMemberAuthApply"

///3.20 地址获取
#define USERCENTER_LOCATION_LIST_FOR_TREE  BASE_URL_REl@"/webService/location/listLocationForTree"  

///3.21 更新会员的累计未读消息数为0
#define USERCENTER_MODIFY_MSY_TO_ZERO  BASE_URL_REl@"/webService/message/modifyMsgToZero"

#pragma mark -  ============4.其它(OTHER)=============
/******************其它(OTHER)***********************/
/// 支付宝
#define ALIPAY_APP_URLSCHEME   @"com.pinqilai.alipay"

///4.0 提交推送设备信息
#define OTHER_SET_DIVICE_INFO  BASE_URL_REl@"/webService/message/setMessageDeviceInfo"

///4.1 版本更新
#define OTHER_GET_VERSION_INFO  BASE_URL_REl@"/webService/version/getVersionInfo"

//4.2数据字典类型查询
#define HOME_GET_VERSION_LISTDICTIONARY   BASE_URL_REl@"/webService/version/listDictiionaryItems"

//4.3 支付等
#define OTHER_GET_VERSION_OPTION_BY_ENNAME   BASE_URL_REl@"/webService/version/getSystemOptionByEnName"

//4.4 才标网用户协议 
#define OTHER_GET_REGISTER_INDEX   @"http://www.58caibiao.com:8788/index.html"


//4.5 关于我们联系我们帮助
#define HELP_GET_VERSION_SYSTEM_ENNAME   BASE_URL_REl@"/webService/version/getOtherSystemOptionByEnName"

#pragma mark - ==========5.登录注册修改(LOGIN)=========
/********************登录注册修改(LOGIN)******************/
///5.0 注册获取验证码
#define LOGIN_GET_MEMBER_GETPHONEVERIFY   BASE_URL_REl@"/webService/member/getPhoneVerify"

///5.1 注册                                          webService/member/register
#define LOGIN_GET_MEMBER_REGISTER   BASE_URL_REl@"/webService/member/register"

//5.2 登录
#define LOGIN_GET_MEMBER_LOGIN   BASE_URL_REl@"/webService/member/login"

///5.3 重置密码
#define LOGIN_GET_MEMBER_RESETPASSWORD   BASE_URL_REl@"/webService/member/resetPassword"

///5.4登录（微信授权）
#define LOGIN_MEMBER_WEIXIN_OPENID   BASE_URL_REl@"/webService/member/loginByWeixinOpenId"
///5.5绑定手机
#define LOGIN_MEMBER_BINGREGIS_OPENID   BASE_URL_REl@"/webService/member/bindRegistInfo"


#endif /* NetUrlMaro_h */
