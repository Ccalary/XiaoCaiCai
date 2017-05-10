//
//  RegisterViewController.m
//  才标网
//
//  Created by caohouhong on 17/3/17.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "RegisterViewController.h"
#import "ToolsHelper.h"
#import "UIButton+countDown.h"
#import "CBConnect.h"
#import "BaseWebViewController.h"
#import "UserHelper.h"

@interface RegisterViewController ()
@property (nonatomic,strong) UIButton *randomCodeBtn;
@property (nonatomic,strong) UITextField *phoneTextField;
@property (nonatomic,strong) UITextField *ranCodeTextField;
@property (nonatomic,strong) UITextField *psdTextField;
@property (nonatomic,strong) UIButton *checkButton;
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = YES;
    [self drawView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
 
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}
- (void)drawView{
    
    UIView *backgroundView = [[UIView alloc ] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight2)];
    backgroundView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backgroundView];
    
    //分割线
    UIView *dividerLine1 = [[UIView alloc] init];
    dividerLine1.backgroundColor = COLOR_LOGINTEXT;
    
    UIView *dividerLine2 = [[UIView alloc] init];
    dividerLine2.backgroundColor = COLOR_LOGINTEXT;

    UIView *dividerLine3 = [[UIView alloc] init];
    dividerLine3.backgroundColor = COLOR_LOGINTEXT;
    
    [self.view sd_addSubviews:@[dividerLine1,dividerLine2,dividerLine3]];
    
    //图标
    UIImageView *logoImageView = [self creatImageViewWithImageName:@"login_logo_1"];
    UIImageView *phoneImageView = [self creatImageViewWithImageName:@"login_phone"];
    UIImageView *randomCodeImageView = [self creatImageViewWithImageName:@"login_key"];
    UIImageView *psdImageView = [self creatImageViewWithImageName:@"login_psd"];
    
    [self.view sd_addSubviews:@[logoImageView,phoneImageView,randomCodeImageView,psdImageView]];
    
    //输入框
    self.phoneTextField = [self creatTextFieldWithPlacehold:@"手机号码"];
    self.phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    self.ranCodeTextField = [self creatTextFieldWithPlacehold:@"验证码"];
    self.ranCodeTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    self.psdTextField = [self creatTextFieldWithPlacehold:@"输入密码"];
    self.psdTextField.secureTextEntry = YES;
    [self.view sd_addSubviews:@[_phoneTextField,_ranCodeTextField,_psdTextField]];
    
    //按钮
    self.randomCodeBtn = [self creatButtonWithTag:10000];
    _randomCodeBtn.layer.borderWidth = 1;
    _randomCodeBtn.layer.borderColor = COLOR_Gray.CGColor;
    _randomCodeBtn.titleLabel.font = SYSTEM_FONT_(15*UIRate);
    [_randomCodeBtn setTitleColor:COLOR_Gray forState:UIControlStateNormal];
    [_randomCodeBtn setTitle:@"获取验证吗" forState:UIControlStateNormal];
    
    UIButton *registerButton = [self creatButtonWithTag:10001];
    [registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [registerButton setBackgroundImage:[UIImage imageNamed:@"icon-zhuce"] forState:UIControlStateNormal];
    registerButton.titleLabel.font = SYSTEM_FONT_(18*UIRate);
    [registerButton setTitle:@"立即注册" forState:UIControlStateNormal];
    registerButton.layer.cornerRadius = 5.0;
    
    NSString *protocalStr = @"我已阅读并同意《才标网用户协议》";
    UILabel *bottomLabel = [[UILabel alloc] init];
    bottomLabel.font = SYSTEM_FONT_(12*UIRate);
    bottomLabel.textColor = COLOR_Gray;
    bottomLabel.attributedText = [ToolsHelper changeSomeText:@"《才标网用户协议》" inText:protocalStr withColor:COLOR_Blue];
    
    UIButton *protocalButton = [self creatButtonWithTag:10003];
    
    
    self.checkButton = [self creatButtonWithTag:10004];

    [_checkButton setImage:[UIImage imageNamed:@"login_xieyi_n"] forState:UIControlStateNormal];
    [_checkButton setImage:[UIImage imageNamed:@"login_xieyi_s"] forState:UIControlStateSelected];
    _checkButton.selected = YES;
    [self.view sd_addSubviews:@[_randomCodeBtn,registerButton,bottomLabel,protocalButton,_checkButton]];
    ///退出按钮
    UIButton *exitBtn = [[UIButton alloc]init];

    [exitBtn setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    [exitBtn addTarget:self action:@selector(exitAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:exitBtn];
    
    
    exitBtn.sd_layout
    .leftSpaceToView(self.view,20*UIRate)
    .topSpaceToView(self.view,20*UIRate)
    .heightIs(30*UIRate)
    .widthIs(30*UIRate);
    
    logoImageView.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(self.view,120*UIRate)
    .widthIs(95*UIRate)
    .heightIs(95*UIRate);
    
    dividerLine1.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(self.view,280*UIRate)
    .widthIs(ScreenWidth - 90*UIRate)
    .heightIs(1);
    
    dividerLine2.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(dividerLine1,50*UIRate)
    .widthRatioToView(dividerLine1,1)
    .heightIs(1);
    
    dividerLine3.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(dividerLine2,50*UIRate)
    .widthRatioToView(dividerLine1,1)
    .heightIs(1);
    
    phoneImageView.sd_layout
    .leftEqualToView(dividerLine1)
    .bottomSpaceToView(dividerLine1,2)
    .widthIs(20*UIRate)
    .heightIs(23*UIRate);

    randomCodeImageView.sd_layout
    .leftEqualToView(dividerLine2)
    .bottomSpaceToView(dividerLine2,2)
    .widthRatioToView(phoneImageView,1)
    .heightEqualToWidth(phoneImageView,1);
    
    psdImageView.sd_layout
    .leftEqualToView(dividerLine3)
    .bottomSpaceToView(dividerLine3,2)
    .widthRatioToView(phoneImageView,1)
    .heightEqualToWidth(phoneImageView,1);
    
    _phoneTextField.sd_layout
    .leftSpaceToView(phoneImageView,20)
    .bottomSpaceToView(dividerLine1,2)
    .widthRatioToView(dividerLine1,0.7)
    .heightIs(20*UIRate);
    
    _ranCodeTextField.sd_layout
    .leftEqualToView(_phoneTextField)
    .bottomSpaceToView(dividerLine2,2)
    .widthRatioToView(dividerLine2,0.5)
    .heightRatioToView(_phoneTextField,1);
    
    _psdTextField.sd_layout
    .leftEqualToView(_phoneTextField)
    .bottomSpaceToView(dividerLine3,2)
    .widthRatioToView(_phoneTextField,1)
    .heightRatioToView(_phoneTextField,1);
    
    _randomCodeBtn.sd_layout
    .rightEqualToView(dividerLine2)
    .bottomSpaceToView(dividerLine2,3)
    .widthIs(90*UIRate)
    .heightIs(25*UIRate);
    _randomCodeBtn.sd_cornerRadiusFromHeightRatio = @(0.5);
    
    registerButton.sd_layout
    .leftEqualToView(dividerLine3)
    .topSpaceToView(dividerLine3,20*UIRate)
    .widthRatioToView(dividerLine3,1)
    .heightIs(40*UIRate);
    
    
    bottomLabel.sd_layout
    .centerXEqualToView(self.view).offset(10*UIRate)
    .bottomSpaceToView(self.view,30*UIRate)
    .widthIs(200*UIRate)
    .heightIs(20*UIRate);
    
    protocalButton.sd_layout
    .rightEqualToView(bottomLabel)
    .centerYEqualToView(bottomLabel)
    .widthIs(130*UIRate)
    .heightIs(40*UIRate);
    
    _checkButton.sd_layout
    .rightSpaceToView(bottomLabel,3)
    .centerYEqualToView(bottomLabel)
    .widthIs(30*UIRate)
    .heightIs(30*UIRate);

}

- (UIImageView *)creatImageViewWithImageName:(NSString *)imageStr{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:imageStr];
    return imageView;
}

- (UITextField *)creatTextFieldWithPlacehold:(NSString *)string{
    UITextField *textField = [[UITextField alloc] init];
    textField.textColor = COLOR_Gray;
    textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:string attributes:@{NSForegroundColorAttributeName: COLOR_Gray}];
    textField.font = SYSTEM_FONT_(15*UIRate);
    
    return textField;
}

- (UIButton *)creatButtonWithTag:(int)tag{
    UIButton *button = [[UIButton alloc] init];
    button.tag = tag;
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

#pragma mark - Action
- (void)buttonAction:(UIButton *)button{
    switch (button.tag) {
        case 10000://获取验证码
        {
            if (self.phoneTextField.text.length != 11) {
                [LCProgressHUD showMessage:@"请输入正确手机号"];
                return;
            }
            
            _randomCodeBtn.countDownFormat=@"%d秒后重试";
            [_randomCodeBtn countDownWithTimeInterval:60];
            
            NSMutableDictionary *parmas = [[NSMutableDictionary alloc]init];
            [parmas setValue:self.phoneTextField.text forKey:@"telephone"];
            
            [CBConnect getLogInMembergetPhoneVerify:parmas success:^(id responseObject) {
                
            } successBackfailError:^(id responseObject) {
                
            } failure:^(NSURLSessionDataTask *operation, NSError *error) {
                
            }];
            
        }
            break;
        case 10001://立即注册
        {
            if (self.phoneTextField.text.length != 11) {
                [LCProgressHUD showMessage:@"请输入正确手机号"];
                return;
            }
            if (!self.ranCodeTextField.text.length) {
                [LCProgressHUD showMessage:@"请输入验证码"];
                return;
            }
            if (!self.psdTextField.text.length) {
                [LCProgressHUD showMessage:@"请输入密码"];
                return;
            }
            
            if (!self.checkButton.selected){
                [LCProgressHUD showMessage:@"请阅读并同意《才标网用户协议》"];
                return;
            }
            
            [LCProgressHUD showLoading:@"正在注册..."];
            
            NSString *originTel = self.phoneTextField.text;
            NSString *tel = [originTel stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
            NSMutableDictionary *parms = [[NSMutableDictionary alloc]init];
            [parms setValue:tel forKey:@"firstname"];
            [parms setValue:self.phoneTextField.text forKey:@"telephone"];
            [parms setValue:self.psdTextField.text forKey:@"password"];
            [parms setValue:self.ranCodeTextField.text forKey:@"telephone_veri"];
            [CBConnect getLogInMemberRegister:parms success:^(id responseObject) {
                
                [self.navigationController popViewControllerAnimated:YES];
                
                //保存登陆信息
                [UserHelper setLogInfo:responseObject];
                
                //发送通知 注册成功
                [[NSNotificationCenter defaultCenter] postNotificationName:NotificationRegisterSuccess object:nil];
                //上传设备号
                [self requestModifyMsgRead];
                [LCProgressHUD showSuccess:@"注册并登录成功"];
                
            } successBackfailError:^(id responseObject) {
                
            } failure:^(NSURLSessionDataTask *operation, NSError *error) {
                
            }];
        }
            break;
//        case 10002://语音验证码
//        {
//            if (self.phoneTextField.text.length==0) {
//                [LCProgressHUD showMessage:@"请输入手机号"];
//                return;
//            }
     
//        }
//            break;
        case 10003://用户协议
        {
            BaseWebViewController *vc = [[BaseWebViewController alloc] initWithTitle:@"用户协议" andUrl:OTHER_GET_REGISTER_INDEX];
            [self.navigationController pushViewController:vc animated:YES];
            
        }
            break;
        case 10004://同意框
        {
           _checkButton.selected = !_checkButton.selected;

        }
            break;
            
        default:
            break;
    }
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


-(void)exitAction{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
