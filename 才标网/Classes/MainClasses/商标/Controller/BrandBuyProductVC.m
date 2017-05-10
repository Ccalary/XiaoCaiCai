//
//  BrandBuyProductVC.m
//  才标网
//
//  Created by caohouhong on 17/3/24.
//  Copyright © 2017年 李强. All rights reserved.
//  商品详情

#import "BrandBuyProductVC.h"
#import "CBConnect.h"
#import "UserHelper.h"
#import "LoginViewController.h"
#import "BrandPayPopView.h"
#import "CNPPopupController.h"
#import "ServiceVC.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"
#import "ToolsHelper.h"
@interface BrandBuyProductVC ()

@property (nonatomic, strong) CNPPopupController *popupController;
@property (nonatomic, strong) BrandPayPopView *popView;

@property (nonatomic, strong) UIImageView *proImageView;
@property (nonatomic, strong) UILabel *moneyLabel, *statusLabel, *numLabel;
@property (nonatomic, assign) int buyNum;
@property (nonatomic, assign) int minNum;
@property (nonatomic, strong) NSString *payWay; //付款方式

@property (nonatomic, strong) UIButton *weChatBtn;
@property (nonatomic, strong) UIButton *payBtn;

@property (nonatomic, strong) UITextField *addressField;
@end

@implementation BrandBuyProductVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"商品详情";
    
    _minNum = [self.model.minimum intValue];
    _buyNum = (_minNum > 0) ?: 1;
    //默认为微信
    _payWay = @"weixin";
    [self drawView];
    [self refreshUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (void)drawView{
    
    UIView *imageHoldView = [[UIView alloc] init];
    imageHoldView.layer.borderWidth = 1;
    imageHoldView.layer.borderColor = COLOR_BackgroundColor.CGColor;
    [self.view addSubview:imageHoldView];
    
    _proImageView = [[UIImageView alloc] init];
    [self.view addSubview:_proImageView];
    
    _moneyLabel = [[UILabel alloc] init];
    _moneyLabel.font = SYSTEM_FONT_(15*UIRate);
    _moneyLabel.textColor = COLOR_OrangeRed;
    [self.view addSubview:_moneyLabel];
    
    _statusLabel = [[UILabel alloc] init];
    _statusLabel.font = SYSTEM_FONT_(15*UIRate);
    _statusLabel.textColor = COLOR_Black;
    [self.view addSubview:_statusLabel];
    
    UIView *dividerView = [[UIView alloc] init];
    dividerView.backgroundColor = COLOR_BackgroundColor;
    [self.view addSubview:dividerView];
    
    imageHoldView.sd_layout
    .leftSpaceToView(self.view,10*UIRate)
    .topSpaceToView(self.view,10*UIRate)
    .widthIs(140*UIRate)
    .heightIs(155*UIRate);
    
    _proImageView.sd_layout
    .centerXEqualToView(imageHoldView)
    .centerYEqualToView(imageHoldView)
    .widthIs(130*UIRate)
    .heightIs(145*UIRate);
    
    _moneyLabel.sd_layout
    .topSpaceToView(self.view,20*UIRate)
    .leftSpaceToView(imageHoldView,10*UIRate)
    .widthIs(ScreenWidth - 160*UIRate)
    .heightIs(15*UIRate);
    
    _statusLabel.sd_layout
    .topSpaceToView(_moneyLabel,10*UIRate)
    .leftEqualToView(_moneyLabel)
    .widthIs(ScreenWidth - 160*UIRate)
    .heightIs(15*UIRate);
    
    dividerView.sd_layout
    .leftEqualToView(self.view)
    .topSpaceToView(self.view,175*UIRate)
    .widthRatioToView(self.view,1)
    .heightIs(20*UIRate);
    
    /***************第二部分***************/
    UILabel *buyNumLabel = [[UILabel alloc] init];
    buyNumLabel.text = @"购买数量：";
    buyNumLabel.font = SYSTEM_FONT_(15*UIRate);
    buyNumLabel.textColor = COLOR_Black;
    
    UIView *dividerLine2 = [[UIView alloc] init];
    dividerLine2.backgroundColor = COLOR_BackgroundColor;
    
    UILabel *addressLabel = [[UILabel alloc] init];
    addressLabel.text = @"支付地址：";
    addressLabel.font = SYSTEM_FONT_(15*UIRate);
    addressLabel.textColor = COLOR_Black;

    _addressField = [[UITextField alloc] init];
    _addressField.placeholder = @"请输入支付地址";
    _addressField.font = SYSTEM_FONT_(15*UIRate);
    _addressField.textAlignment = NSTextAlignmentRight;
    _addressField.textColor = COLOR_Black;
    
    UIView *dividerLine3 = [[UIView alloc] init];
    dividerLine3.backgroundColor = COLOR_BackgroundColor;
    
    UIView *addMinusView = [[UIView alloc] init];
    addMinusView.layer.borderWidth = 1;
    addMinusView.layer.borderColor = COLOR_BackgroundColor.CGColor;
    
    UILabel *minusLabel = [[UILabel alloc] init];
    minusLabel.text = @"-";
    minusLabel.textAlignment = NSTextAlignmentCenter;
    minusLabel.font = SYSTEM_FONT_(18*UIRate);
    minusLabel.textColor = COLOR_LineViewColor;

    UILabel *addLabel = [[UILabel alloc] init];
    addLabel.text = @"+";
    addLabel.textAlignment = NSTextAlignmentCenter;
    addLabel.font = SYSTEM_FONT_(18*UIRate);
    addLabel.textColor = COLOR_LineViewColor;
    
    _numLabel = [[UILabel alloc] init];
    _numLabel.font = SYSTEM_FONT_(15*UIRate);
    _numLabel.textAlignment = NSTextAlignmentCenter;
    _numLabel.textColor = COLOR_Gray;
    
    UIView *verDividerLine1 = [[UIView alloc] init];
    verDividerLine1.backgroundColor = COLOR_BackgroundColor;
   
    UIView *verDividerLine2 = [[UIView alloc] init];
    verDividerLine2.backgroundColor = COLOR_BackgroundColor;
    
    UIButton *addButton = [[UIButton alloc] init];
    [addButton addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *minusButton = [[UIButton alloc] init];
    [minusButton addTarget:self action:@selector(minusAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view sd_addSubviews:@[buyNumLabel,dividerLine2,addMinusView,minusLabel,addLabel,_numLabel,verDividerLine1,verDividerLine2,addButton,minusButton,addressLabel,_addressField,dividerLine3]];
    
    buyNumLabel.sd_layout
    .leftSpaceToView(self.view,10*UIRate)
    .topSpaceToView(dividerView,0)
    .widthRatioToView(self.view,0.5)
    .heightIs(45*UIRate);
    
    dividerLine2.sd_layout
    .leftEqualToView(self.view)
    .topSpaceToView(dividerView,45*UIRate)
    .widthRatioToView(self.view,1)
    .heightIs(1);
    
    addMinusView.sd_layout
    .rightSpaceToView(self.view,10*UIRate)
    .centerYEqualToView(buyNumLabel)
    .widthIs(85*UIRate)
    .heightIs(25*UIRate);
    
    minusLabel.sd_layout
    .leftEqualToView(addMinusView)
    .centerYEqualToView(addMinusView)
    .widthIs(25*UIRate)
    .heightRatioToView(addMinusView,1);
    
    addLabel.sd_layout
    .rightEqualToView(addMinusView)
    .centerYEqualToView(addMinusView)
    .widthIs(25*UIRate)
    .heightRatioToView(addMinusView,1);

    _numLabel.sd_layout
    .centerXEqualToView(addMinusView)
    .centerYEqualToView(addMinusView)
    .widthIs(35*UIRate)
    .heightRatioToView(addMinusView,1);
    
    verDividerLine1.sd_layout
    .leftEqualToView(_numLabel)
    .centerYEqualToView(addMinusView)
    .widthIs(1)
    .heightRatioToView(addMinusView,1);
    
    verDividerLine2.sd_layout
    .rightEqualToView(_numLabel)
    .centerYEqualToView(addMinusView)
    .widthIs(1)
    .heightRatioToView(addMinusView,1);
    
    minusButton.sd_layout
    .rightEqualToView(minusLabel)
    .centerYEqualToView(minusLabel)
    .widthIs(35*UIRate)
    .heightIs(35*UIRate);
    
    addButton.sd_layout
    .leftEqualToView(addLabel)
    .centerYEqualToView(addLabel)
    .widthIs(35*UIRate)
    .heightIs(35*UIRate);
    
    addressLabel.sd_layout
    .leftEqualToView(buyNumLabel)
    .topSpaceToView(dividerLine2,0)
    .widthIs(80*UIRate)
    .heightIs(45*UIRate);
    
    _addressField.sd_layout
    .rightSpaceToView(self.view,10*UIRate)
    .centerYEqualToView(addressLabel)
    .widthIs(ScreenWidth - 120*UIRate)
    .heightIs(45*UIRate);
    
    dividerLine3.sd_layout
    .leftEqualToView(self.view)
    .topSpaceToView(addressLabel,0)
    .widthRatioToView(self.view,1)
    .heightIs(1);
    /************客服和购买***********/
    
    _weChatBtn = [[UIButton alloc]init];
    _weChatBtn.tag = 10002;
    [_weChatBtn setImage:[UIImage imageNamed:@"btn_weixin_n"] forState:UIControlStateNormal];
    [_weChatBtn setImage:[UIImage imageNamed:@"btn_weixin_s"] forState:UIControlStateSelected];
    _weChatBtn.selected = YES;
    [_weChatBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_weChatBtn];
    
    
    _payBtn = [[UIButton alloc]init];
    _payBtn.tag = 10001;
    [_payBtn setImage:[UIImage imageNamed:@"btn_zhifubao_n"]forState:UIControlStateNormal];
    [_payBtn setImage:[UIImage imageNamed:@"btn_zhifubao_s"]forState:UIControlStateSelected];
    [_payBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_payBtn];
    
    UILabel *wxLabel = [[UILabel alloc]init];
    wxLabel.font = [UIFont systemFontOfSize:15*UIRate];
    wxLabel.text = @"微信";
    wxLabel.textAlignment = NSTextAlignmentCenter;
    wxLabel.textColor = COLOR_Gray;
    [_weChatBtn addSubview:wxLabel];
    
    UILabel *payLabel = [[UILabel alloc]init];
    payLabel.font = [UIFont systemFontOfSize:15*UIRate];
    payLabel.text = @"支付宝";
    payLabel.textColor = COLOR_Gray;
    payLabel.textAlignment = NSTextAlignmentCenter;
    [_payBtn addSubview:payLabel];

    UIButton *buyBtn = [[UIButton alloc] init];
    [buyBtn setTitle:@"立即购买" forState:UIControlStateNormal];
    [buyBtn setBackgroundColor:COLOR_ButtonBackGround_Orange];
    buyBtn.titleLabel.font = SYSTEM_FONT_(18*UIRate);
    [buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buyBtn addTarget:self action:@selector(buyBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buyBtn];
    
    UIButton *serviceBtn = [[UIButton alloc]initWithFrame:CGRectZero];
    [serviceBtn addTarget:self action:@selector(serviceBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [serviceBtn setImage:[UIImage imageNamed:@"home_kefu"] forState:UIControlStateNormal];
    [self.view addSubview:serviceBtn];
    
    
    
    
    buyBtn.sd_layout
    .centerXEqualToView(self.view)
    .bottomSpaceToView(self.view, 10*UIRate)
    .widthIs(ScreenWidth - 70*UIRate)
    .heightIs(50*UIRate);
    [buyBtn setSd_cornerRadiusFromHeightRatio:@(0.1)];
    
    serviceBtn.sd_layout
    .rightSpaceToView(self.view,0*UIRate)
    .bottomSpaceToView(self.view,100*UIRate)
    .widthIs(80*UIRate)
    .heightIs(80*UIRate);

    
    _weChatBtn.sd_layout
    .centerXEqualToView(self.view).offset(-85*UIRate)
    .bottomSpaceToView(buyBtn,60*UIRate)
    .widthIs(65*UIRate)
    .heightIs(65*UIRate);
    
    wxLabel.sd_layout
    .centerXEqualToView(_weChatBtn)
    .bottomSpaceToView(_weChatBtn,5*UIRate)
    .widthRatioToView(_weChatBtn,1)
    .heightIs(15*UIRate);
    
    _payBtn.sd_layout
    .centerXEqualToView(self.view).offset(85*UIRate)
    .topEqualToView(_weChatBtn)
    .widthIs(65*UIRate)
    .heightIs(65*UIRate);
    
    payLabel.sd_layout
    .centerXEqualToView(_payBtn)
    .bottomSpaceToView(_payBtn,5*UIRate)
    .widthRatioToView(_payBtn,1)
    .heightIs(15*UIRate);

}
- (void)btnAction:(UIButton *)button{
    switch (button.tag) {
        case 10002://微信
            _weChatBtn.selected = YES;
            _payBtn.selected =  !_weChatBtn.selected;
            _payWay = @"weixin";
            break;
        case 10001://支付宝
            _payBtn.selected = YES;
            _weChatBtn.selected = !_payBtn.selected;
            _payWay = @"alipay";
            break;
        default:
            break;
    }
}

//界面数据填充
- (void)refreshUI{
    
    [_proImageView sd_setImageWithURL:[NSURL URLWithString:self.model.thumb] placeholderImage:[UIImage imageNamed:@"brand_s_default_110x75"]];
    
    _statusLabel.text = [NSString stringWithFormat:@"库存现状：%@",self.model.stock?:@"未知"];
    
    /*
     * 备注：price和special 只会一个有值，不会同时存在。
     如果  price有值special为false，商品为正常价格；
     如果  special有值price为false，商品为促销价格；
     * */
    if ([_model.price isEqualToString:@"false"]){
        _moneyLabel.text = [NSString stringWithFormat:@"￥%.2f",[_model.special doubleValue]];
    }else {
        _moneyLabel.text = [NSString stringWithFormat:@"￥%.2f",[_model.price doubleValue]];
    }
    
    _numLabel.text = [NSString stringWithFormat:@"%d",self.buyNum];
}


//增加
- (void)addAction{
    self.buyNum ++;
    
    self.numLabel.text = [NSString stringWithFormat:@"%d",self.buyNum];
}

//减少
- (void)minusAction{
    
    if (self.buyNum > self.minNum){
         self.buyNum --;
    }else {
        
        [LCProgressHUD showMessage:[NSString stringWithFormat:@"至少购买%d件",self.buyNum]];
    }
   
    self.numLabel.text = [NSString stringWithFormat:@"%d",self.buyNum];
}

//客服
- (void)serviceBtnAction{
    ServiceVC *vc = [[ServiceVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

//购买
- (void)buyBtnAction{
    
    if (![UserHelper IsLogin]){
     
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        BaseNavigationController *baseNav = [[BaseNavigationController alloc] initWithRootViewController:loginVC];
        [self presentViewController:baseNav animated:YES completion:nil];
        return;
    }
    
    [LCProgressHUD showLoading:@"请求支付"];
    NSMutableDictionary *params = [CBConnect getBaseRequestParams];
    //获取本机IP
    NSString *addressStr = [ToolsHelper getIPAddress];
    [params setValue:addressStr forKey:@"ip"];
    [params setValue:self.model.product_id forKey:@"product_id"]; //产品id
    [params setValue:@(self.buyNum) forKey:@"product_quantity"];//商品数量，默认1
    [params setValue:_payWay forKey:@"payment_code"];
    if (_addressField.text.length){
        [params setValue:_addressField.text forKey:@"payment_address"];
    }
    [CBConnect getBrandOrderAddOrder:params success:^(id responseObject) {
        if ([_payWay isEqualToString:@"weixin"]) {
            // 微信支付
            PayReq *request = [[PayReq alloc]init];
            request.partnerId = responseObject[@"partnerid"];//商户号
            request.prepayId = responseObject[@"prepayid"];//预支付交易会话ID
            request.nonceStr = responseObject[@"noncestr"];//随机字符串
            NSMutableString *timeStr = responseObject[@"timestamp"];
            request.timeStamp = timeStr.intValue;//时间戳
            request.package = @"Sign=WXPay";//扩展字段
            request.sign = responseObject[@"sign"];//签名
            [WXApi sendReq:request];
            
        }else if([_payWay isEqualToString:@"alipay"]){
            // 支付宝支付
            //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
            NSString *appScheme = ALIPAY_APP_URLSCHEME;
            [[AlipaySDK defaultService]payOrder:responseObject fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                
            }];
            
        }
    } successBackfailError:^(id responseObject) {
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
    
}

@end
