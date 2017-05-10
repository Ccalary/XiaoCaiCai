//
//  MyOrderDetailCell2.m
//  才标网
//
//  Created by caohouhong on 17/3/27.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "MyOrderDetailCell2.h"
#import "OrderProductModel.h"

@interface MyOrderDetailCell2()
@property (nonatomic, strong) UILabel *topOrderId, *topTitleLabel, *statusLabel ,*moneyLabel;
@property (nonatomic, strong) UIImageView *proImageView;
@end

@implementation MyOrderDetailCell2

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
    _moneyLabel.font = SYSTEM_FONT_(15*UIRate);
    _moneyLabel.textColor = COLOR_Orange;
    _moneyLabel.text = @"合计：¥0.00";
    [self.contentView addSubview:_moneyLabel];
    
    _proImageView = [[UIImageView alloc] init];
    _proImageView.image = [UIImage imageNamed:@"uc_order_default_70x75"];
    [self.contentView addSubview:_proImageView];
    
    
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
    .centerYEqualToView(self.contentView).offset(20*UIRate)
    .widthIs(70*UIRate)
    .heightIs(75*UIRate);
}

- (void)setModel:(OrderModel *)model
{
    _model = model;
    
    _topOrderId.text = [NSString stringWithFormat:@"订单号ID： %@",model.order_number?:@""];

    if (model.products.count){
         OrderProductModel *proModel = model.products.firstObject;
        _topTitleLabel.text = proModel.name?:@"";
        _moneyLabel.text = [NSString stringWithFormat:@"合计：%@",proModel.total];
        [_proImageView sd_setImageWithURL:[NSURL URLWithString:proModel.thumb] placeholderImage:[UIImage imageNamed:@"uc_order_default_70x75"]];
    }
    
    //支付状体
    _statusLabel.text = model.order_status;
    
}

@end
