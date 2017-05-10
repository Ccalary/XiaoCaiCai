//
//  PleaseNameFooterView.m
//  才标网
//
//  Created by caohouhong on 17/3/23.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "PleaseNameFooterView.h"
@interface PleaseNameFooterView ()
@property (nonatomic ,strong) UIButton *payBtn, *weChatBtn;
@end

@implementation PleaseNameFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self){
        self.backgroundColor = [UIColor whiteColor];
        [self drawView];
    }
    return self;
}

- (void)drawView{
    
    UILabel *fukuanLabel = [[UILabel alloc] init];
    fukuanLabel.font = [UIFont systemFontOfSize:15*UIRate];
    fukuanLabel.textColor = COLOR_Black;
    fukuanLabel.text = @"付款方式";
    [self addSubview:fukuanLabel];
    
    _weChatBtn = [[UIButton alloc]init];
    _weChatBtn.tag = 10002;
    [_weChatBtn setImage:[UIImage imageNamed:@"btn_weixin_n"] forState:UIControlStateNormal];
    [_weChatBtn setImage:[UIImage imageNamed:@"btn_weixin_s"] forState:UIControlStateSelected];
    _weChatBtn.selected = YES;
    [_weChatBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_weChatBtn];
    
    
    _payBtn = [[UIButton alloc]init];
    _payBtn.tag = 10001;
    [_payBtn setImage:[UIImage imageNamed:@"btn_zhifubao_n"]forState:UIControlStateNormal];
    [_payBtn setImage:[UIImage imageNamed:@"btn_zhifubao_s"]forState:UIControlStateSelected];
    [_payBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_payBtn];
    
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
    
    UIButton *releaseBtn = [[UIButton alloc]init];
    [releaseBtn setTitle:@"提交" forState:UIControlStateNormal];
    [releaseBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    releaseBtn.backgroundColor = COLOR_OrangeRed;
    [releaseBtn addTarget:self action:@selector(releaseBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:releaseBtn];
    
    
    fukuanLabel.sd_layout
    .leftSpaceToView(self,15*UIRate)
    .topSpaceToView(self,10*UIRate)
    .widthIs(100*UIRate)
    .heightIs(20*UIRate);
    
    _weChatBtn.sd_layout
    .centerXEqualToView(self).offset(-85*UIRate)
    .topSpaceToView(fukuanLabel,12*UIRate)
    .widthIs(65*UIRate)
    .heightIs(65*UIRate);
    
    wxLabel.sd_layout
    .centerXEqualToView(_weChatBtn)
    .bottomSpaceToView(_weChatBtn,5*UIRate)
    .widthRatioToView(_weChatBtn,1)
    .heightIs(15*UIRate);
    
    _payBtn.sd_layout
    .centerXEqualToView(self).offset(85*UIRate)
    .topEqualToView(_weChatBtn)
    .widthIs(65*UIRate)
    .heightIs(65*UIRate);
    
    payLabel.sd_layout
    .centerXEqualToView(_payBtn)
    .bottomSpaceToView(_payBtn,5*UIRate)
    .widthRatioToView(_payBtn,1)
    .heightIs(15*UIRate);
    
    releaseBtn.sd_layout
    .leftSpaceToView(self,40*UIRate)
    .rightSpaceToView(self,40*UIRate)
    .bottomSpaceToView(self,10*UIRate)
    .heightIs(40*UIRate);
    [releaseBtn setSd_cornerRadiusFromHeightRatio:@(0.1)];

}

- (void)btnAction:(UIButton *)button{
    switch (button.tag) {
        case 10002://微信
            _weChatBtn.selected = YES;
            _payBtn.selected =  !_weChatBtn.selected;
            break;
        case 10001://支付宝
            _payBtn.selected = YES;
            _weChatBtn.selected = !_payBtn.selected;
            break;
        default:
            break;
    }
    
    if (self.block){
        self.block((int)button.tag - 10000);
    }
    
}

- (void)releaseBtnAction{
    if (self.delegate){
        [self.delegate commitBtnClick];
    }
}


@end
