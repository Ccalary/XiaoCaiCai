//
//  BindingIphone.m
//  才标网
//
//  Created by baichun on 17/4/5.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "BindingIphone.h"
#import "ModifyVC.h"
#import "CBConnect.h"
#import "UIButton+countDown.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
#import "NavigationView.h"
#import "UserHelper.h"
@interface BindingIphone ()<UITextFieldDelegate>

@property(nonatomic,strong)UIButton *obtainBtn;

@property (nonatomic,strong) UITextField *accounTextF;

@property (nonatomic,strong) UITextField *validationTextF;
@property (nonatomic,strong) UIButton *confirmBtn;

@end

@implementation BindingIphone
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"绑定手机";
    self.view.backgroundColor = [UIColor whiteColor];
    [self drawView];
}
-(void)drawView{
    
    __weak typeof (self) weakSelf = self;
    NavigationView *nav = [[NavigationView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64) andTitle:@"忘记密码" block:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    [self.view addSubview:nav];
    
    
    self.accounTextF = [[UITextField alloc]init];
    _accounTextF.font = [UIFont systemFontOfSize:15];
    _accounTextF.placeholder = @"    手机号";
    _accounTextF.delegate = self;
    
    
    _accounTextF.borderStyle = UITextBorderStyleLine;
    _accounTextF.layer.masksToBounds = YES;
    _accounTextF.layer.borderWidth = 1;
    _accounTextF.layer.borderColor = COLOR_LightGray.CGColor;
    
    
    
    [self.view addSubview:_accounTextF];
    
    self.validationTextF = [[UITextField alloc]init];
    _validationTextF.font = [UIFont systemFontOfSize:15];
    _validationTextF.placeholder = @"    请输入短信验证码";
    _validationTextF.delegate = self;
    
    _validationTextF.borderStyle = UITextBorderStyleLine;
    _validationTextF.layer.masksToBounds = YES;
    _validationTextF.layer.borderWidth = 1;
    _validationTextF.layer.borderColor = COLOR_LightGray.CGColor;
    
    [self.view addSubview:_validationTextF];
    
    [_accounTextF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    [_validationTextF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    _obtainBtn = [[UIButton alloc]init];
    [_obtainBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_obtainBtn setTitleColor:COLOR_Gray forState:UIControlStateNormal];
    _obtainBtn.layer.masksToBounds = YES;
    _obtainBtn.layer.borderWidth = 1;
    _obtainBtn.layer.borderColor = COLOR_LightGray.CGColor;
    _obtainBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_obtainBtn addTarget:self action:@selector(obtainBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_obtainBtn];
    
    
    self.confirmBtn = [[UIButton alloc]init];
    [_confirmBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [_confirmBtn setTitleColor:COLOR_White forState:UIControlStateNormal];
    _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    _confirmBtn.backgroundColor = COLOR_LightGray;
    [_confirmBtn addTarget:self action:@selector(confirmBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_confirmBtn];
    
//    UILabel *promptLabel = [[UILabel alloc]init];
//    promptLabel.text = @"还未收到短信验证码？试试";
//    promptLabel.font = [UIFont systemFontOfSize:13];
//    promptLabel.textColor = COLOR_LightGray;
//    [self.view addSubview:promptLabel];
//    
//    
//    UIButton *voiceBtn = [[UIButton alloc]init];
//    [voiceBtn setTitle:@"语音验证码" forState:UIControlStateNormal];
//    voiceBtn.titleLabel.font = [UIFont systemFontOfSize:13];
//    voiceBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    [voiceBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//    [self.view addSubview:voiceBtn];
    
    _accounTextF.sd_layout
    .leftSpaceToView(self.view,15*UIRate)
    .topSpaceToView(self.view,84*UIRate)
    .rightSpaceToView(self.view,15*UIRate)
    .heightIs(45*UIRate);
    
    
    _validationTextF.sd_layout
    .leftSpaceToView(self.view,15*UIRate)
    .topSpaceToView(_accounTextF,20*UIRate)
    .widthIs(225*UIRate)
    .heightIs(45*UIRate);
    
    
    _obtainBtn.sd_layout
    .leftSpaceToView(_validationTextF,12.5*UIRate)
    .topSpaceToView(_accounTextF,20*UIRate)
    .rightSpaceToView(self.view,15*UIRate)
    .heightIs(45*UIRate);
    
    _confirmBtn.sd_layout
    .leftSpaceToView(self.view,15*UIRate)
    .topSpaceToView(_validationTextF,20*UIRate)
    .rightSpaceToView(self.view,15*UIRate)
    .heightIs(45*UIRate);
    
//    promptLabel.sd_layout
//    .leftSpaceToView(self.view,15*UIRate)
//    .topSpaceToView(_confirmBtn,20*UIRate)
//    .widthIs(190*UIRate)
//    .heightIs(15*UIRate);
//    
//    
//    voiceBtn.sd_layout
//    .rightSpaceToView(self.view,80*UIRate)
//    .leftSpaceToView(promptLabel,1*UIRate)
//    .topSpaceToView(_confirmBtn,20*UIRate)
//    .heightIs(15*UIRate);
    
}
#pragma mark -输入框实时变化改变颜色

-(void)textFieldDidChange :(UITextField *)theTextField{
    
    if (_accounTextF.text.length == 11 && _validationTextF.text.length) {
        
        _confirmBtn.backgroundColor = COLOR_LOGIN;
    }else{
        _confirmBtn.backgroundColor = COLOR_LightGray;
    }

    
}



//获取验证码
-(void)obtainBtn:(UIButton *)btn{
    if (self.accounTextF.text.length != 11) {
        [LCProgressHUD showMessage:@"请输入正确手机号"];
        return;
    }
    
    _obtainBtn.countDownFormat=@"%d秒后重试";
    [_obtainBtn countDownWithTimeInterval:60];
    
    NSMutableDictionary *parmas = [[NSMutableDictionary alloc]init];
    [parmas setValue:self.accounTextF.text forKey:@"telephone"];
    [parmas setValue:@"edit" forKey:@"type"];
    [CBConnect getLogInMembergetPhoneVerify:parmas success:^(id responseObject) {
        [LCProgressHUD showSuccess:@"发送成功"];
    } successBackfailError:^(id responseObject) {
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
    
    
    
}
//下一步
-(void)confirmBtnAction{
    if (self.accounTextF.text.length!=11) {
        [LCProgressHUD showMessage:@"请输入正确的手机号"];
        return;
    }
    if (self.validationTextF.text.length!=4) {
        [LCProgressHUD showMessage:@"请输入正确的验证码"];
        return;
    }
    NSMutableDictionary *parms = [[NSMutableDictionary alloc]init];
    [parms setValue:self.openid forKey:@"social_open_id"];//openid
    [parms setValue:self.social_type forKey:@"social_type"];//是qq还是微信
    [parms setValue:self.firstname forKey:@"firstname"];//名字
    [parms setValue:self.accounTextF.text forKey:@"telephone"];//电话
    [parms setValue:self.validationTextF.text forKey:@"telephone_veri"];//验证码
    [CBConnect getLoginMemberBingRegisOpenId:parms success:^(id responseObject) {
        
        //保存登陆信息
        [UserHelper setLogInfo:self.responseObject];
        //上传设备号和用户ID
        [self requestModifyMsgRead];
        [self.navigationController popViewControllerAnimated:YES];
        //发送通知 注册成功
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationRegisterSuccess object:nil];

    } successBackfailError:^(id responseObject) {
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
    
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
