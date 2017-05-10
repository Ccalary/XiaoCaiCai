//
//  MyOrderVC.m
//  才标网
//
//  Created by caohouhong on 17/3/27.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "MyOrderVC.h"
#import "CorePagesView.h"
#import "MyOrderScrollView.h"
#import "MyOrderListView.h"
#import "MyOrderDetailVC.h"
#import "UserHelper.h"
#import "BrandPayPopView.h"
#import "CNPPopupController.h"
#import "CBConnect.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"
#import "ToolsHelper.h"
@interface MyOrderVC ()<UIScrollViewDelegate>
@property (nonatomic, strong) CNPPopupController *popupController;
@property (nonatomic, strong) BrandPayPopView *popView;

@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) NSString *payWay; //付款方式
@property (nonatomic, strong) NSString *order_id;
@end

@implementation MyOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的订单";
    self.navigationController.navigationBar.translucent = YES;
    [self drawView];
    [self initTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)drawView{
    
    UIImageView *topImageView = [[UIImageView alloc] init];
    topImageView.image = [UIImage imageNamed:@"uc_order_top_bg_375x170"];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = SYSTEM_FONT_(18*UIRate);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"我的订单";
    
    UIButton *backButton = [[UIButton alloc] init];
    [backButton setImage:[UIImage imageNamed:@"nav_back_white_12x22"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *iconImageView = [[UIImageView alloc] init];
    iconImageView.image = [UIImage imageNamed:@"uc_icon_bg_65x65"];
    
    _headImageView = [[UIImageView alloc] init];
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:[UserHelper getMemberHeaderPhoto]] placeholderImage:[UIImage imageNamed:@"uc_default_header_60x60"]];
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.textColor = [UIColor whiteColor];
    _nameLabel.font = SYSTEM_FONT_(15*UIRate);
    _nameLabel.text = [NSString stringWithFormat:@"昵称：%@",[UserHelper getMemberName]];

    
    [self.view sd_addSubviews:@[topImageView, titleLabel, backButton, iconImageView, _headImageView, _nameLabel]];
    
    topImageView.sd_layout
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .topEqualToView(self.view)
    .heightIs(170*UIRate);
    
    titleLabel.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(self.view, 30*UIRate)
    .widthIs(100*UIRate)
    .heightIs(20*UIRate);
    
    backButton.sd_layout
    .leftSpaceToView(self.view,10*UIRate)
    .centerYEqualToView(titleLabel)
    .widthIs(30*UIRate)
    .heightIs(35*UIRate);
    
    iconImageView.sd_layout
    .leftSpaceToView(self.view,10*UIRate)
    .bottomEqualToView(topImageView).offset(-25*UIRate)
    .widthIs(65*UIRate)
    .heightIs(65*UIRate);
    iconImageView.sd_cornerRadiusFromHeightRatio = @(0.5);
    
    _headImageView.sd_layout
    .centerXEqualToView(iconImageView)
    .centerYEqualToView(iconImageView)
    .widthIs(60*UIRate)
    .heightIs(60*UIRate);
    _headImageView.sd_cornerRadiusFromHeightRatio = @(0.5);
    
    _nameLabel.sd_layout
    .leftSpaceToView(iconImageView,10*UIRate)
    .centerYEqualToView(_headImageView)
    .widthIs(ScreenWidth - 100*UIRate)
    .heightIs(20*UIRate);
}

- (BrandPayPopView *)popView{
    if (!_popView){
        _popView = [[BrandPayPopView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth - 50*UIRate, 150*UIRate)];
        __weak typeof (self) weakSelf = self;
        _popView.closeBlock = ^(){
            [weakSelf.popupController dismissPopupControllerAnimated:YES];
        };
        
        _popView.wayBlock = ^(int row){
            weakSelf.payWay = (row == 0) ? @"alipay" : @"weixin";
            [weakSelf.popupController dismissPopupControllerAnimated:YES];
            [weakSelf goPay];
        };
    }
    return _popView;
}


- (void)initTableView{

    MyOrderListView *serveTableView = [[MyOrderListView alloc] initWithFrame:CGRectMake(0, 170*UIRate, ScreenWidth, ScreenHeight2 - 170*UIRate)];
    [self.view addSubview:serveTableView];
    __weak typeof (self) weakSelf = self;
    serveTableView.block = ^(int tag, NSString *orderId){
        weakSelf.order_id = orderId;
        switch (tag) {
            case  10000://查看
            {
                MyOrderDetailVC *vc = [[MyOrderDetailVC alloc] init];
                vc.orderId = orderId;
                vc.orderId = weakSelf.order_id;
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 10001://付款
                self.popupController = [[CNPPopupController alloc] initWithContents:@[self.popView]];
                [self.popupController presentPopupControllerAnimated:YES];
                break;
            default:
                break;
        }
    };
}

//返回
- (void)backButtonAction{
    [self.navigationController popViewControllerAnimated:YES];
}
// 支付
-(void)goPay{
    
    [LCProgressHUD showLoading:@"请求支付"];
    //获取本机IP
    NSString *addressStr = [ToolsHelper getIPAddress];
    NSMutableDictionary *params = [CBConnect getBaseRequestParams];
    [params setValue:_order_id forKey:@"order_id"]; //产品id
    [params setValue:_payWay forKey:@"payment_code"];
    [params setValue:addressStr forKey:@"ip"];
    [CBConnect getUserOrderViewToPay:params success:^(id responseObject) {
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
