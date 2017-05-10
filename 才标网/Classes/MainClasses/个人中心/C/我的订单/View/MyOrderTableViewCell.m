//
//  MyOrderTableViewCell.m
//  才标网
//
//  Created by caohouhong on 17/3/27.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "MyOrderTableViewCell.h"
#import "OrderProductModel.h"

@interface MyOrderTableViewCell()
@property (nonatomic, strong) UILabel *topOrderId, *topTitleLabel, *statusLabel ,*moneyLabel, *rightTimeLabel, *leftNumLabel;
@property (nonatomic, strong) UIImageView *proImageView;

@property (nonatomic, strong) UIButton *seeButton, *payButton;

@end

@implementation MyOrderTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self drawView];
    }
    
    return self;
}

- (void)drawView{
    
    _topOrderId = [[UILabel alloc] init];
    _topOrderId.font = SYSTEM_FONT_(14*UIRate);
    _topOrderId.textColor = COLOR_LightGray;
    _topOrderId.text = @"订单号ID: ";
    [self.contentView addSubview:_topOrderId];
    
    _statusLabel = [[UILabel alloc] init];
    _statusLabel.font = SYSTEM_FONT_(14*UIRate);
    _statusLabel.textColor = COLOR_LightGray;
    _statusLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_statusLabel];
    
    UIView *dividerLine1 = [[UIView alloc] init];
    dividerLine1.backgroundColor = COLOR_BackgroundColor;
    [self.contentView addSubview:dividerLine1];
    
    _topTitleLabel = [[UILabel alloc] init];
    _topTitleLabel.font = SYSTEM_FONT_(15*UIRate);
    _topTitleLabel.textColor = COLOR_Black;
    [self.contentView addSubview:_topTitleLabel];
    
    _moneyLabel = [[UILabel alloc] init];
    _moneyLabel.font = SYSTEM_FONT_BOLD_(15*UIRate);
    _moneyLabel.textColor = COLOR_Orange;
    _moneyLabel.text = @"¥0.00";
    [self.contentView addSubview:_moneyLabel];
    
    _proImageView = [[UIImageView alloc] init];
    _proImageView.image = [UIImage imageNamed:@"uc_order_default_70x75"];
    [self.contentView addSubview:_proImageView];

    UIView *dividerLine2 = [[UIView alloc] init];
    dividerLine2.backgroundColor = COLOR_BackgroundColor;
    [self.contentView addSubview:dividerLine2];
    
    _rightTimeLabel = [[UILabel alloc] init];
    _rightTimeLabel.font = SYSTEM_FONT_(14*UIRate);
    _rightTimeLabel.textColor = COLOR_LightGray;
    [self.contentView addSubview:_rightTimeLabel];
    
    _seeButton = [[UIButton alloc] init];
    [_seeButton setTitle:@"查看" forState:UIControlStateNormal];
    _seeButton.titleLabel.font = SYSTEM_FONT_(14*UIRate);
    _seeButton.layer.borderColor = COLOR_Orange.CGColor;
    _seeButton.layer.borderWidth = 1;
    _seeButton.layer.cornerRadius = 3.0;
    _seeButton.tag = MyOrderTableViewCellTypeSee;
    [_seeButton setTitleColor:COLOR_Orange forState:UIControlStateNormal];
    [_seeButton addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_seeButton];
 
    _payButton = [[UIButton alloc] init];
    [_payButton setTitle:@"付款" forState:UIControlStateNormal];
    _payButton.backgroundColor = COLOR_Orange;
    _payButton.layer.cornerRadius = 3.0;
    _payButton.tag = MyOrderTableViewCellTypePay;
    _payButton.titleLabel.font = SYSTEM_FONT_(14*UIRate);
    [_payButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_payButton addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_payButton];
    
    _topOrderId.sd_layout
    .leftSpaceToView(self.contentView, 10*UIRate)
    .topEqualToView(self.contentView)
    .widthIs(ScreenWidth - 100*UIRate)
    .heightIs(40*UIRate);
    
    _statusLabel.sd_layout
    .rightSpaceToView(self.contentView, 10*UIRate)
    .centerYEqualToView(_topOrderId)
    .widthIs(100*UIRate)
    .heightIs(40*UIRate);
    
    dividerLine1.sd_layout
    .topSpaceToView(self.contentView, 40*UIRate)
    .leftEqualToView(_topOrderId)
    .widthIs(ScreenWidth - 15*UIRate)
    .heightIs(1);
    
    _topTitleLabel.sd_layout
    .leftEqualToView(_topOrderId)
    .topSpaceToView(dividerLine1,10*UIRate)
    .widthIs(ScreenWidth - 100*UIRate)
    .heightIs(20*UIRate);
    
    _moneyLabel.sd_layout
    .leftEqualToView(_topOrderId)
    .topSpaceToView(_topTitleLabel,10*UIRate)
    .widthIs(ScreenWidth - 100*UIRate)
    .heightIs(20*UIRate);
    
    _proImageView.sd_layout
    .rightSpaceToView(self.contentView, 40*UIRate)
    .centerYEqualToView(self.contentView)
    .widthIs(70*UIRate)
    .heightIs(75*UIRate);

    dividerLine2.sd_layout
    .topSpaceToView(self.contentView, 140*UIRate)
    .leftEqualToView(_topOrderId)
    .widthIs(ScreenWidth - 15*UIRate)
    .heightIs(1);
    
    _rightTimeLabel.sd_layout
    .leftEqualToView(_topOrderId)
    .bottomEqualToView(self.contentView)
    .widthIs(ScreenWidth - 100*UIRate)
    .heightIs(40*UIRate);
    
    _payButton.sd_layout
    .rightSpaceToView(self.contentView,10*UIRate)
    .centerYEqualToView(_rightTimeLabel)
    .widthIs(45*UIRate)
    .heightIs(25*UIRate);
    
    _seeButton.sd_layout
    .rightSpaceToView(_payButton,15*UIRate)
    .centerYEqualToView(_payButton)
    .widthIs(45*UIRate)
    .heightIs(25*UIRate);
}

- (void)btnAction:(UIButton *)button{
    
    if (self.delegete){
        [self.delegete clickButtonWithTag:button.tag andOrderId:self.model.order_id];
    }
}

-(void)setModel:(OrderModel *)model{
    
    _model = model;
    
    if (model.products.count){//商品只有一个，所以取第一个就可以
        OrderProductModel *proModel = model.products.firstObject;
        
        _topTitleLabel.text = proModel.name?:@"";
        _moneyLabel.text = [NSString stringWithFormat:@"%@",proModel.total];
        
        [_proImageView sd_setImageWithURL:[NSURL URLWithString:proModel.thumb] placeholderImage:[UIImage imageNamed:@"uc_order_default_70x75"]];
    }
    _topOrderId.text = [NSString stringWithFormat:@"订单号ID:%@",model.order_number];
    _rightTimeLabel.text = [NSString stringWithFormat:@"创建日期: %@", model.date_added];
    
    if ([model.status isEqualToString:@"未支付"]){ //付款按钮的显示与隐藏
        _payButton.sd_layout
        .rightSpaceToView(self.contentView,10*UIRate)
        .centerYEqualToView(_rightTimeLabel)
        .widthIs(45*UIRate)
        .heightIs(25*UIRate);
    }else {
        _payButton.sd_layout
        .rightSpaceToView(self.contentView,-5*UIRate)
        .centerYEqualToView(_rightTimeLabel)
        .widthIs(0*UIRate)
        .heightIs(25*UIRate);
    }
    _statusLabel.text = model.status;
}

@end
