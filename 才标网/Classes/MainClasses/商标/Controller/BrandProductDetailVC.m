//
//  BrandProductDetailVC.m
//  才标网
//
//  Created by caohouhong on 17/3/24.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "BrandProductDetailVC.h"
#import "BrandBuyProductVC.h"
#import "CBConnect.h"
#import "ProductModel.h"
#import <KVOController/KVOController.h>
#import "ServiceVC.h"
@interface BrandProductDetailVC ()<UIScrollViewDelegate,UIWebViewDelegate>

@property (nonatomic, strong) UIScrollView *mScrollView;
@property (nonatomic, strong) UIWebView *mWebView;

@property (nonatomic, strong) UIImageView *brandImageView;
@property (nonatomic, strong) UILabel *nameLabel, *priceLabel;
@property (nonatomic, strong) ProductModel *model;

@property (nonatomic, strong) FBKVOController *kvoController;
@end

@implementation BrandProductDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"商品详情";
    [self drawView];
    [self requestData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)drawView{
    
    _mScrollView = [[UIScrollView alloc] init];
    _mScrollView.delegate = self;
    _mScrollView.contentSize = CGSizeMake(ScreenWidth, ScreenHeight - 50*UIRate + 1);
    [self.view addSubview:_mScrollView];
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 325*UIRate)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.mScrollView addSubview:topView];
    
    _brandImageView = [[UIImageView alloc] init];
    [topView addSubview:_brandImageView];
    
    UIView *dividerLine1 = [[UIView alloc] init];
    dividerLine1.backgroundColor = COLOR_BackgroundColor;
    [topView addSubview:dividerLine1];
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.text = @"商标注册送外观";
    _nameLabel.font = SYSTEM_FONT_(15*UIRate);
    _nameLabel.textColor = COLOR_Black;
    [topView addSubview:_nameLabel];
    
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.text = @"¥0.00";
    _priceLabel.font = SYSTEM_FONT_(15*UIRate);
    _priceLabel.textColor = COLOR_OrangeRed;
    [topView addSubview:_priceLabel];
    
    UIView *desHoldView = [[UIView alloc] initWithFrame:CGRectMake(0, 345*UIRate, ScreenWidth, 45*UIRate)];
    desHoldView.backgroundColor = [UIColor whiteColor];
    [self.mScrollView addSubview:desHoldView];
    
    UIView *barView = [[UIView alloc] init];
    barView.backgroundColor = COLOR_OrangeRed;
    [desHoldView addSubview:barView];

    UILabel *desLabel = [[UILabel alloc] init];
    desLabel.text = @"商品描述";
    desLabel.font = SYSTEM_FONT_(14*UIRate);
    desLabel.textColor = COLOR_Black;
    [desHoldView addSubview:desLabel];
    
    UIView *dividerLine = [[UIView alloc] init];
    dividerLine.backgroundColor = COLOR_BackgroundColor;
    [desHoldView addSubview:dividerLine];
    
    _mWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 390*UIRate, ScreenWidth, ScreenHeight - 390*UIRate - 50*UIRate)];
    _mWebView.delegate = self;
    _mWebView.scalesPageToFit = YES;
    _mWebView.backgroundColor = [UIColor clearColor];
    _mWebView.opaque = NO;
    _mWebView.backgroundColor = [UIColor whiteColor];
    _mWebView.userInteractionEnabled = NO;
    [_mScrollView addSubview:_mWebView];
    
    UIButton *buyBtn = [[UIButton alloc] init];
    [buyBtn setTitle:@"立即购买" forState:UIControlStateNormal];
    [buyBtn setBackgroundColor:COLOR_ButtonBackGround_Orange];
    buyBtn.titleLabel.font = SYSTEM_FONT_(18*UIRate);
    [buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buyBtn addTarget:self action:@selector(buyBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buyBtn];
    
    UIButton *serviceBtn = [[UIButton alloc]initWithFrame:CGRectZero];
    [serviceBtn addTarget:self action:@selector(serviceBtn) forControlEvents:UIControlEventTouchUpInside];
    [serviceBtn setImage:[UIImage imageNamed:@"home_kefu"] forState:UIControlStateNormal];
    [self.view addSubview:serviceBtn];
    
    serviceBtn.sd_layout
    .rightSpaceToView(self.view,0*UIRate)
    .bottomSpaceToView(self.view,85*UIRate)
    .widthIs(80*UIRate)
    .heightIs(80*UIRate);
    
    _mScrollView.sd_layout
    .leftEqualToView(self.view)
    .topEqualToView(self.view)
    .rightEqualToView(self.view)
    .bottomSpaceToView(self.view,50*UIRate);
    
    _brandImageView.sd_layout
    .centerXEqualToView(topView)
    .topSpaceToView(topView,20*UIRate)
    .widthIs(230*UIRate)
    .heightIs(205*UIRate);
    
    dividerLine1.sd_layout
    .leftEqualToView(topView)
    .topSpaceToView(topView,245*UIRate)
    .widthRatioToView(topView,1)
    .heightIs(1);
    
    _nameLabel.sd_layout
    .leftSpaceToView(topView, 10*UIRate)
    .topSpaceToView(dividerLine1,10*UIRate)
    .widthIs(ScreenWidth - 20*UIRate)
    .heightIs(20*UIRate);
    
    _priceLabel.sd_layout
    .leftEqualToView(_nameLabel)
    .bottomSpaceToView(topView,10*UIRate)
    .widthIs(ScreenWidth - 30*UIRate)
    .heightIs(20*UIRate);
    
    desLabel.sd_layout
    .leftSpaceToView(desHoldView, 20*UIRate)
    .topSpaceToView(desHoldView,10*UIRate)
    .widthIs(ScreenWidth - 30*UIRate)
    .heightIs(25*UIRate);
    
    barView.sd_layout
    .rightSpaceToView(desLabel, 3*UIRate)
    .centerYEqualToView(desLabel)
    .widthIs(2)
    .heightIs(15*UIRate);
    
    dividerLine.sd_layout
    .leftSpaceToView(desHoldView,0)
    .bottomEqualToView(desHoldView)
    .widthIs(ScreenWidth)
    .heightIs(1);
    
    buyBtn.sd_layout
    .centerXEqualToView(self.view)
    .bottomEqualToView(self.view)
    .widthIs(ScreenWidth)
    .heightIs(50*UIRate);
    
    /***webView高度自适应***/
    __weak typeof (self) weakSelf = self;
    //KVO
    self.kvoController = [FBKVOController controllerWithObserver:self];
    [self.kvoController observe:_mWebView.scrollView keyPath:@"contentOffset" options:NSKeyValueObservingOptionNew block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
        
        //获取尺寸
        CGSize fitSize = [_mWebView sizeThatFits:CGSizeZero];
        
        weakSelf.mScrollView.contentSize = CGSizeMake(ScreenWidth, fitSize.height + 390*UIRate);
        
        CGRect rect = weakSelf.mWebView.frame;
        rect.size.height = fitSize.height;
        weakSelf.mWebView.frame = rect;
    }];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
//    NSString *injectionJSString = @"var script = document.createElement('meta');"
//    "script.name = 'viewport';"
//    "script.content=\"width=device-width, initial-scale=1.0,maximum-scale=1.0, minimum-scale=1.0, user-scalable=no\";"
//    "document.getElementsByTagName('head')[0].appendChild(script);";
//    [webView stringByEvaluatingJavaScriptFromString:injectionJSString];
}


//立即购买
- (void)buyBtnAction{
    
    BrandBuyProductVC *vc = [[BrandBuyProductVC alloc] init];
    vc.model = self.model;
    [self.navigationController pushViewController:vc animated:YES];
}

//客服
- (void)serviceBtn{
    ServiceVC *vc = [[ServiceVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - ===================网络====================
-(void)requestData{
    
    [LCProgressHUD showLoading:@"加载中..."];
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setValue:self.product_id forKey:@"product_id"];
    [CBConnect getProutDetail:params success:^(id responseObject) {
        self.model = [ProductModel mj_objectWithKeyValues:responseObject];
        [self refreshUI];
    } successBackfailError:^(id responseObject) {
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}

- (void)refreshUI{
    
    [_brandImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_model.thumb]] placeholderImage:[UIImage imageNamed:@"brand_s_default_110x75"]];
    _nameLabel.text = _model.name;
    
    /*
     * 备注：price和special 只会一个有值，不会同时存在。
     如果  price有值special为false，商品为正常价格；
     如果  special有值price为false，商品为促销价格；
     * */
    if ([_model.price isEqualToString:@"false"]){
        _priceLabel.text = [NSString stringWithFormat:@"￥%.2f",[_model.special doubleValue]];
    }else {
        _priceLabel.text = [NSString stringWithFormat:@"￥%.2f",[_model.price doubleValue]];
    }
    
    [_mWebView loadHTMLString:_model.descri baseURL:nil];
}
@end
