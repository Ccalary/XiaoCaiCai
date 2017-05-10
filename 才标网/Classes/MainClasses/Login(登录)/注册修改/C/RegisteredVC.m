//
//  RegisteredVC.m
//  才标网
//
//  Created by baichun on 17/3/17.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "RegisteredVC.h"
#import "UIButton+countDown.h"
#import "ModifyVC.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
#import "CBConnect.h"
#import "NavigationView.h"

@interface RegisteredVC ()<UITextFieldDelegate>
   
@property(nonatomic, strong)UIButton *obtainBtn;

@property (nonatomic, strong) UITextField *accounTextF;

@property (nonatomic, strong) UITextField *validationTextF;
@property (nonatomic, strong) UIButton *confirmBtn;

@end

@implementation RegisteredVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"忘记密码";
    self.view.backgroundColor = [UIColor whiteColor];
    [self drawView];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}


-(void)drawView{
    
    __weak typeof (self) weakSelf = self;
    NavigationView *nav = [[NavigationView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64) andTitle:@"忘记密码" block:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    [self.view addSubview:nav];

    UILabel *accountLabel = [[UILabel alloc] init];
    accountLabel.layer.borderWidth = 1;
    accountLabel.layer.borderColor = COLOR_LightGray.CGColor;
    [self.view addSubview:accountLabel];
    
    self.accounTextF = [[UITextField alloc]init];
    _accounTextF.font = [UIFont systemFontOfSize:15*UIRate];
    _accounTextF.placeholder = @"手机号";
    _accounTextF.delegate = self;
    _accounTextF.keyboardType = UIKeyboardTypeNumberPad;
    [_accounTextF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:_accounTextF];
    
    UILabel *codeLabel = [[UILabel alloc] init];
    codeLabel.layer.borderWidth = 1;
    codeLabel.layer.borderColor = COLOR_LightGray.CGColor;
    [self.view addSubview:codeLabel];
    
    self.validationTextF = [[UITextField alloc]init];
    _validationTextF.font = [UIFont systemFontOfSize:15*UIRate];
    _validationTextF.placeholder = @"请输入短信验证码";
    _validationTextF.keyboardType = UIKeyboardTypeNumberPad;
    _validationTextF.delegate = self;
    [_validationTextF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:_validationTextF];

   _obtainBtn = [[UIButton alloc]init];
    [_obtainBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_obtainBtn setTitleColor:COLOR_Gray forState:UIControlStateNormal];
    _obtainBtn.layer.masksToBounds = YES;
    _obtainBtn.layer.borderWidth = 1;
    _obtainBtn.layer.borderColor = COLOR_LightGray.CGColor;
    _obtainBtn.titleLabel.font = [UIFont systemFontOfSize:15*UIRate];
    [_obtainBtn addTarget:self action:@selector(obtainBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_obtainBtn];
    
    
    self.confirmBtn = [[UIButton alloc]init];
    [_confirmBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [_confirmBtn setTitleColor:COLOR_White forState:UIControlStateNormal];
    _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:18*UIRate];
    _confirmBtn.backgroundColor = COLOR_LightGray;
    [_confirmBtn addTarget:self action:@selector(confirmBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_confirmBtn];
    
    accountLabel.sd_layout
    .leftSpaceToView(self.view,15*UIRate)
    .topSpaceToView(self.view,84*UIRate)
    .rightSpaceToView(self.view,15*UIRate)
    .heightIs(45*UIRate);
    
    _accounTextF.sd_layout
    .leftSpaceToView(self.view,20*UIRate)
    .centerYEqualToView(accountLabel)
    .rightSpaceToView(self.view,20*UIRate)
    .heightIs(45*UIRate);
    
    _obtainBtn.sd_layout
    .topSpaceToView(_accounTextF,20*UIRate)
    .rightSpaceToView(self.view,15*UIRate)
    .widthIs(110*UIRate)
    .heightIs(45*UIRate);
    
    codeLabel.sd_layout
    .leftSpaceToView(self.view,15*UIRate)
    .centerYEqualToView(_obtainBtn)
    .rightSpaceToView(_obtainBtn,15*UIRate)
    .heightIs(45*UIRate);
    
    _validationTextF.sd_layout
    .leftEqualToView(codeLabel).offset(5*UIRate)
    .centerYEqualToView(codeLabel)
    .widthRatioToView(codeLabel,0.9)
    .heightIs(45*UIRate);
    
    _confirmBtn.sd_layout
    .leftSpaceToView(self.view,15*UIRate)
    .topSpaceToView(_validationTextF,20*UIRate)
    .rightSpaceToView(self.view,15*UIRate)
    .heightIs(45*UIRate);
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
    
    } successBackfailError:^(id responseObject) {
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];

}
      //下一步
-(void)confirmBtnAction{
    
    NSMutableDictionary *parms = [[NSMutableDictionary alloc]init];
    [parms setValue:self.accounTextF.text forKey:@"telephone"];
    [parms setValue:self.validationTextF.text forKey:@"telephone_veri"];
    
    [CBConnect getLogInMemberResetPassword:parms success:^(id responseObject) {
        [LCProgressHUD showSuccess:@"密码已发送你的手机"];
        [self.navigationController popViewControllerAnimated:YES];
    } successBackfailError:^(id responseObject) {
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)backButtonAction{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
