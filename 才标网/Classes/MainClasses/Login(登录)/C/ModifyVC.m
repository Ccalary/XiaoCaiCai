//
//  ModifyVC.m
//  才标网
//
//  Created by baichun on 17/3/17.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "ModifyVC.h"

@interface ModifyVC ()
@property (nonatomic,strong) UITextField *password;
@property (nonatomic,strong) UITextField *password1;
@property (nonatomic,strong) UIButton *confirmBtn;
@end

@implementation ModifyVC
    
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"重新输入密码";
    self.view.backgroundColor = [UIColor whiteColor];
    [self drawView];

}
-(void)drawView{
    UILabel *newPassword = [[UILabel alloc]init];
    newPassword.text = @"    新密码";
    newPassword.font = [UIFont systemFontOfSize:14];
    newPassword.layer.masksToBounds = YES;
    newPassword.layer.borderWidth = 1;
    newPassword.textColor = COLOR_Gray;
    newPassword.layer.borderColor = COLOR_LightGray.CGColor;
    [self.view addSubview:newPassword];
    
    self.password = [[UITextField alloc]init];
    _password.placeholder = @"请输入新密码";
    _password.secureTextEntry = YES;
    _password.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:_password];
    
    UILabel *newPassword1 = [[UILabel alloc]init];
    newPassword1.text = @"    重复密码";
    newPassword1.font = [UIFont systemFontOfSize:14];
    newPassword1.layer.masksToBounds = YES;
    newPassword1.layer.borderWidth = 1;
    newPassword1.textColor = COLOR_Gray;
    newPassword1.layer.borderColor = COLOR_LightGray.CGColor;
    [self.view addSubview:newPassword1];

    self.password1 = [[UITextField alloc]init];
    _password1.placeholder = @"请再次输入一遍密码";
    _password1.secureTextEntry = YES;
    _password1.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:_password1];
    

    self.confirmBtn = [[UIButton alloc]init];
    [_confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
    [_confirmBtn setTitleColor:COLOR_White forState:UIControlStateNormal];
    _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    _confirmBtn.backgroundColor = COLOR_LOGIN;
    [_confirmBtn addTarget:self action:@selector(confirmBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_confirmBtn];

    newPassword.sd_layout
    .leftSpaceToView(self.view,15*UIRate)
    .topSpaceToView(self.view,84*UIRate)
    .rightSpaceToView(self.view,15*UIRate)
    .heightIs(45*UIRate);
    
    _password.sd_layout
    .leftSpaceToView(self.view,110*UIRate)
    .topSpaceToView(self.view,84*UIRate)
    .rightSpaceToView(self.view,15*UIRate)
    .heightIs(45*UIRate);
    
    newPassword1.sd_layout
    .leftSpaceToView(self.view,15*UIRate)
    .topSpaceToView(newPassword,20*UIRate)
    .rightSpaceToView(self.view,20*UIRate)
    .heightIs(45*UIRate);
    
    _password1.sd_layout
    .leftSpaceToView(self.view,110*UIRate)
    .topSpaceToView(newPassword,20*UIRate)
    .rightSpaceToView(self.view,15*UIRate)
    .heightIs(45*UIRate);
    
    _confirmBtn.sd_layout
    .leftSpaceToView(self.view,15*UIRate)
    .rightSpaceToView(self.view,15*UIRate)
    .topSpaceToView(newPassword1,20*UIRate)
    .heightIs(45*UIRate);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)confirmBtnAction{
    
    if ([_password.text isEqualToString:_password1.text]) {
        //如果两次密码相同
    }else{
        
        [LCProgressHUD showMessage:@"两次密码不一致"];
    }
    
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
