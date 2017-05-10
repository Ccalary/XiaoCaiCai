//
//  LoginViewController.m
//  才标网
//
//  Created by baichun on 17/4/1.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "LoginViewController.h"
#import "CBConnect.h"
#import "UserHelper.h"
#import <ShareSDK/ShareSDK.h>
#import "RegisterViewController.h"
#import "RegisteredVC.h"
#import <ShareSDKExtension/SSEThirdPartyLoginHelper.h>
#import "listDictiionaryItemsModel.h"
#import "RegisteredVC.h"
#import "BindingIphone.h"
#import "UserHelper.h"

@interface LoginViewController ()<UITextFieldDelegate>
@property(nonatomic,strong)UITextField *accountTextF;
@property(nonatomic,strong)UITextField *pwdTextF;
@property(nonatomic,strong)NSString *itemContent;
// APP授权类型
//0：微信开放平台
//1：腾讯QQ
@property(nonatomic,strong)NSString *social_type;

/*三方注册后，是否需要绑定手机步骤，取值见ChangLiang中的常量 */
@property (nonatomic,strong) NSString *isBandPhone;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self drawView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(registerSuccessNotification) name:NotificationRegisterSuccess object:nil];
    
    [self requesData];
}

//移除通知
- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

-(void)drawView{

    UIView *backgroundimageView = [[UIView alloc]init];
    backgroundimageView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backgroundimageView];
    //图片旋转
    UIImage *backImage = [UIImage imageNamed:@"nav_back"];
    backImage = [UIImage imageWithCGImage:backImage.CGImage scale:0.5 orientation:UIImageOrientationLeft];
    UIImageView *backImageView = [[UIImageView alloc] init];
    backImageView.image = backImage;
    [self.view addSubview:backImageView];
    
    ///退出按钮
    UIButton *exitBtn = [[UIButton alloc]init];
    [exitBtn addTarget:self action:@selector(exitAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:exitBtn];
    
    UIImageView *iconImageView = [[UIImageView alloc]init];
    iconImageView.image = [UIImage imageNamed:@"login_logo_1"];
    [self.view addSubview:iconImageView];
    
    UIImageView *inputImageView = [[UIImageView alloc]init];
    inputImageView.image = [UIImage imageNamed:@"login_input"];
    [self.view addSubview:inputImageView];
    
    
    UIImageView *inputImageView1 = [[UIImageView alloc]init];
    inputImageView1.image = [UIImage imageNamed:@"login_input"];
    [self.view addSubview:inputImageView1];
    
    UIImageView *phoneImageView = [[UIImageView alloc]init];
    phoneImageView.image = [UIImage imageNamed:@"login_phone"];
    [self.view addSubview:phoneImageView];
    
    
    self.accountTextF = [[UITextField alloc]init];
    UIColor *color = COLOR_Gray;
    _accountTextF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"手机号码" attributes:@{NSForegroundColorAttributeName: color}];
    self.accountTextF.font = [UIFont systemFontOfSize:15*UIRate];
    self.accountTextF.textColor = COLOR_Gray;
    self.accountTextF.delegate = self;
    self.accountTextF.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:self.accountTextF];
    
    UIImageView *passWordImageView = [[UIImageView alloc]init];
    passWordImageView.image = [UIImage imageNamed:@"login_psd"];
    [self.view addSubview:passWordImageView];
    
    self.pwdTextF = [[UITextField alloc]init];
    _pwdTextF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入密码" attributes:@{NSForegroundColorAttributeName: color}];
    self.pwdTextF.font = [UIFont systemFontOfSize:15*UIRate];
    self.pwdTextF.textColor = COLOR_Gray;
    self.pwdTextF.delegate = self;
    self.pwdTextF.secureTextEntry=YES;
    [self.view addSubview:self.pwdTextF];
    
    
    UIButton *loginButton = [[UIButton alloc]init];
    [loginButton setTitle:@"登  录" forState:UIControlStateNormal];
    [loginButton setBackgroundImage:[UIImage imageNamed:@"login_login"] forState:UIControlStateNormal];
    loginButton.titleLabel.font = [UIFont systemFontOfSize:18*UIRate];
    [loginButton addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:loginButton];
    
    UIButton *registerBtn=[[UIButton alloc]init];
    [registerBtn setTitle:@"快速注册" forState:UIControlStateNormal];
    [registerBtn setTitleColor:COLOR_Gray forState:UIControlStateNormal];
    registerBtn.titleLabel.font = [UIFont systemFontOfSize:16*UIRate];
    [registerBtn addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerBtn];
    
    UIButton *findPwd=[[UIButton alloc]init];
    [findPwd setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [findPwd setTitleColor:COLOR_Gray forState:UIControlStateNormal];
    findPwd.titleLabel.font = [UIFont systemFontOfSize:16*UIRate];
    
    [findPwd addTarget:self action:@selector(findPwdAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:findPwd];
    
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = COLOR_LOGINTEXT;
    [self.view addSubview:lineView];
    
    UIView *lineView1 = [[UIView alloc]init];
    lineView1.backgroundColor = COLOR_LOGINTEXT;
    [self.view addSubview:lineView1];
    
    UILabel *thirdLal = [[UILabel alloc]init];
    thirdLal.text = @"使用第三方登录";
    thirdLal.font = [UIFont systemFontOfSize:15*UIRate];
    thirdLal.textColor = COLOR_Gray;
    thirdLal.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:thirdLal];
    
    UIButton *wxBtn = [[UIButton alloc]init];
    [wxBtn setImage:[UIImage imageNamed:@"login_weixin"] forState:UIControlStateNormal];
    [wxBtn addTarget:self action:@selector(wxBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:wxBtn];
    
    UIButton *qqBtn = [[UIButton alloc]init];
    [qqBtn setImage:[UIImage imageNamed:@"login_qq"] forState:UIControlStateNormal];
      [qqBtn addTarget:self action:@selector(qqBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:qqBtn];
    
    
    backgroundimageView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .bottomSpaceToView(self.view,0)
    .topSpaceToView(self.view,0);
    
    backImageView.sd_layout
    .leftSpaceToView(self.view,24*UIRate)
    .topSpaceToView(self.view,29*UIRate)
    .heightIs(22*UIRate)
    .widthIs(22*UIRate);
    
    exitBtn.sd_layout
    .centerXEqualToView(backImageView)
    .centerYEqualToView(backImageView)
    .heightIs(30*UIRate)
    .widthIs(30*UIRate);
    
    iconImageView.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(self.view,110*UIRate)
    .heightIs(95*UIRate)
    .widthIs(95*UIRate);
    
    inputImageView.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(iconImageView,38*UIRate)
    .heightIs(40*UIRate)
    .widthIs(275*UIRate);
    
    inputImageView1.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(inputImageView,13*UIRate)
    .heightIs(40*UIRate)
    .widthIs(275*UIRate);
    
    
    loginButton.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(inputImageView1,25*UIRate)
    .heightIs(40*UIRate)
    .widthIs(275*UIRate);
    
    [loginButton setSd_cornerRadiusFromHeightRatio:@(0.5)];
    
    registerBtn.sd_layout
    .leftSpaceToView(self.view,70*UIRate)
    .topSpaceToView(loginButton,12*UIRate)
    .widthIs(75*UIRate)
    .heightIs(16*UIRate);
    
    
    findPwd.sd_layout
    .rightSpaceToView(self.view,60*UIRate)
    .topSpaceToView(loginButton,12*UIRate)
    .widthIs(80*UIRate)
    .heightIs(16*UIRate);
   
    
    lineView.sd_layout
    .leftSpaceToView(self.view,0)
    .topSpaceToView(registerBtn,100*UIRate)
    .heightIs(1)
    .widthIs(111*UIRate);
    
    lineView1.sd_layout
    .rightSpaceToView(self.view,0)
    .topSpaceToView(findPwd,100*UIRate)
    .heightIs(1)
    .widthIs(111*UIRate);
    
    thirdLal.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(registerBtn,92*UIRate)
    .heightIs(15*UIRate)
    .widthIs(130*UIRate);
    
    wxBtn.sd_layout
    .topSpaceToView(thirdLal,23*UIRate)
    .leftSpaceToView(self.view,90*UIRate)
    .widthIs(55*UIRate)
    .heightIs(55*UIRate);
    
    qqBtn.sd_layout
    .topSpaceToView(thirdLal,23*UIRate)
    .rightSpaceToView(self.view,90*UIRate)
    .widthIs(55*UIRate)
    .heightIs(55*UIRate);
    
    
    phoneImageView.sd_layout
    .leftSpaceToView(self.view,70*UIRate)
    .topSpaceToView(iconImageView,47*UIRate)
    .widthIs(20*UIRate)
    .heightIs(25*UIRate);
    
    passWordImageView.sd_layout
    .topSpaceToView(phoneImageView,27*UIRate)
    .widthIs(20*UIRate)
    .leftSpaceToView(self.view,70*UIRate)
    .heightIs(25*UIRate);
    
    _accountTextF.sd_layout
    .leftSpaceToView(phoneImageView,20*UIRate)
    .topEqualToView(phoneImageView)
    .bottomEqualToView(phoneImageView)
    .widthIs(180*UIRate);
    
    _pwdTextF.sd_layout
    .leftEqualToView(_accountTextF)
    .topEqualToView(passWordImageView)
    .bottomEqualToView(passWordImageView)
    .widthIs(180*UIRate);
    
    
}
-(void)loginAction{
    if (self.accountTextF.text.length != 11) {
        [LCProgressHUD showMessage:@"请输入正确手机号"];
        return;
    }
    if (self.pwdTextF.text.length == 0) {
        [LCProgressHUD showMessage:@"请输入密码"];
        return;
    }
    
    NSMutableDictionary *parmas = [[NSMutableDictionary alloc]init];
    [parmas setValue:self.accountTextF.text forKey:@"username"];
    [parmas setValue:self.pwdTextF.text forKey:@"password"];
    [CBConnect getLogInMemberLogin:parmas success:^(id responseObject) {
        
        //保存登陆信息
        [UserHelper setLogInfo:responseObject];
        //上传设备号和用户ID
        [self requestModifyMsgRead];
        //返回
        [self dismissViewControllerAnimated:YES completion:^{
         [LCProgressHUD showMessage:@"登录成功"];
        }];
        
    } successBackfailError:^(id responseObject) {
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}

-(void)registerAction{
    //注册
    RegisterViewController *vc = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];

}

-(void)findPwdAction{
    // 忘记密码
    RegisteredVC *vc = [[RegisteredVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

//微信登陆
- (void)wxBtnAction{
    //微信登录
    [ShareSDK cancelAuthorize:SSDKPlatformTypeWechat];
    [ShareSDK getUserInfo:SSDKPlatformTypeWechat
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
     {
         if (state == SSDKResponseStateSuccess)
         {
             [LCProgressHUD showLoading:@"登录中..."];
             self.social_type = @"0";
             NSMutableDictionary *parms = [[NSMutableDictionary alloc] init];
             [parms setValue:user.credential.rawData[@"openid"] forKey:@"open_id"];
             [parms setValue:self.social_type forKey:@"social_type"];
             [parms setValue:user.nickname forKey:@"firstname"];
             [parms setValue:user.icon forKey:@"image"];
             
             [CBConnect getLoginMemberWeixinOpenid:parms success:^(id responseObject) {
                 self.isBandPhone = [NSString stringWithFormat:@"%@", responseObject[@"isBandPhone"]];
                 // 0  不绑定  1 绑定
                 if ([self.isBandPhone isEqualToString:@"1"]) {
                   
                     BindingIphone *vc = [[BindingIphone alloc]init];
                     vc.firstname = responseObject[@"memberName"];
                     vc.social_type = self.social_type;
                     vc.openid = user.credential.rawData[@"openid"];
                     vc.responseObject = responseObject;
                     [self.navigationController pushViewController:vc animated:YES];
                     
                 }else{
                     
                     //保存登陆信息
                     [UserHelper setLogInfo:responseObject];
                     //上传设备号和用户ID
                     [self requestModifyMsgRead];
                     //返回
                     [self dismissViewControllerAnimated:YES completion:^{
                         [LCProgressHUD showMessage:@"登录成功"];
                     }];
                 }

             } successBackfailError:^(id responseObject) {
                 
             } failure:^(NSURLSessionDataTask *operation, NSError *error) {
                 
             }];
         }
         else
         {
             NSLog(@"%@",error);
         }
     }];
}

//QQ 登录
- (void)qqBtnAction{
    //QQ
    [ShareSDK cancelAuthorize:SSDKPlatformTypeQQ];
    [ShareSDK getUserInfo:SSDKPlatformTypeQQ
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
     {
         if (state == SSDKResponseStateSuccess)
         {
             [LCProgressHUD showLoading:@"登录中..."];
             self.social_type = @"1";
             NSMutableDictionary *parms = [[NSMutableDictionary alloc] init];
             [parms setValue:user.credential.rawData[@"openid"] forKey:@"open_id"];
             [parms setValue:self.social_type forKey:@"social_type"];
             [parms setValue:user.nickname forKey:@"firstname"];
             [parms setValue:user.rawData[@"figureurl_qq_2"] forKey:@"image"];
             [CBConnect getLoginMemberWeixinOpenid:parms success:^(id responseObject) {
                 self.isBandPhone = [NSString stringWithFormat:@"%@", responseObject[@"isBandPhone"]];
                 DLog(@"%@",self.isBandPhone);
                if ([self.isBandPhone isEqualToString:@"1"]) {
                 
                     BindingIphone *vc = [[BindingIphone alloc]init];
                     vc.firstname = responseObject[@"memberName"];
                     vc.social_type = self.social_type;
                     vc.openid = user.credential.rawData[@"openid"];
                     vc.responseObject = responseObject;
                     [self.navigationController pushViewController:vc animated:YES];
                     
                 }else{
                     
                     //保存登陆信息
                     [UserHelper setLogInfo:responseObject];
                     //上传设备号和用户ID
                     [self requestModifyMsgRead];
                     //返回
                     [self dismissViewControllerAnimated:YES completion:^{
                         [LCProgressHUD showMessage:@"登录成功"];
                     }];
 
                 }
                 
                
             } successBackfailError:^(id responseObject) {
                 
             } failure:^(NSURLSessionDataTask *operation, NSError *error) {
                 
             }];
  
         }
         else
         {
             NSLog(@"%@",error);
         }
     }];

}

//返回
-(void)exitAction
{
    //清空是否从推送而来
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - =============通知===========
- (void)registerSuccessNotification{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - ========网络－上传设备=========
- (void)requestModifyMsgRead{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:[UserHelper getMemberId] forKey:@"receiverId"];
    [params setValue:@(2) forKey:@"deviceType"];//设备类型，1-android；2-IOS
    [params setValue:[UserHelper getPushToken] forKey:@"deviceId"];
    
    [CBConnect getOtherSetDeviceInfo:params success:^(id responseObject) {
        
    } successBackfailError:^(id responseObject) {
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}


#pragma mark - ================网络======================
-(void)requesData{
    NSMutableDictionary *parms = [[NSMutableDictionary alloc]init];
    [parms setObject:@"dg_isBandPhone" forKey:@"groupCode"];
    [CBConnect getVersionlistDictiionaryItems:parms success:^(id responseObject) {
         NSArray *array = [listDictiionaryItemsModel mj_objectArrayWithKeyValuesArray:responseObject];
        for (listDictiionaryItemsModel *model in array){
            self.itemContent = model.itemContent;
        }
    } successBackfailError:^(id responseObject) {
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
    
}
@end
