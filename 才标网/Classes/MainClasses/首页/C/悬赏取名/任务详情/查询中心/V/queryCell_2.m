//
//  queryCell_2.m
//  才标网
//
//  Created by baichun on 17/3/14.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "queryCell_2.h"

@implementation queryCell_2
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self drawView];
    }
    
    return self;
}

+ (queryCell_2 *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"queryCell_2";
    queryCell_2 *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[queryCell_2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

-(void)drawView{
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont systemFontOfSize:14*UIRate];
    titleLabel.text = @"商标名称";
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:titleLabel];

    self.textField = [[UITextField alloc]init];
    _textField.placeholder = @"请输入商标名称";
    _textField.tag = 1314;
    _textField.font = [UIFont systemFontOfSize:14*UIRate];
    [self.contentView addSubview:_textField];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = COLOR_BackgroundColor;
    [self.contentView addSubview:lineView];
    
    UILabel *fuchaLabel = [[UILabel alloc] init];
    fuchaLabel.font = [UIFont systemFontOfSize:14*UIRate];
    fuchaLabel.textColor = COLOR_Black;
    fuchaLabel.text = @"复查费用";
    [self.contentView addSubview:fuchaLabel];

    _priceLable = [[UILabel alloc] init];
    _priceLable.font = [UIFont systemFontOfSize:14*UIRate];
    _priceLable.textColor = HEXCOLOR(0xff6600);
    _priceLable.text = @"￥0.00";
    _priceLable.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_priceLable];

    UIView *lineView1 = [[UIView alloc]init];
    lineView1.backgroundColor = COLOR_BackgroundColor;
    [self.contentView addSubview:lineView1];
    
    UILabel *fukuanLabel = [[UILabel alloc] init];
    fukuanLabel.font = [UIFont systemFontOfSize:14*UIRate];
    fukuanLabel.textColor = COLOR_Black;
    fukuanLabel.text = @"付款方式";
    [self.contentView addSubview:fukuanLabel];
    
    self.weChatBtn = [[UIButton alloc]init];
    
    [_weChatBtn addTarget:self action:@selector(weChatBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_weChatBtn setImage:[UIImage imageNamed:@"btn_weixin_s"] forState:UIControlStateSelected];
    [_weChatBtn setImage:[UIImage imageNamed:@"btn_weixin_n"] forState:UIControlStateNormal];
    _weChatBtn.tag = 2222;
    _weChatBtn.selected = YES;
    _weChatBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:_weChatBtn];
    
    
    self.payBtn = [[UIButton alloc]init];
    
    [_payBtn addTarget:self action:@selector(payBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_payBtn setImage:[UIImage imageNamed:@"btn_zhifubao_n"] forState:UIControlStateNormal];
    [_payBtn setImage:[UIImage imageNamed:@"btn_zhifubao_s"] forState:UIControlStateSelected];
    _payBtn.tag = 2223;
    _payBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:_payBtn];
    
    UILabel *wxLabel = [[UILabel alloc]init];
    wxLabel.font = [UIFont systemFontOfSize:15*UIRate];
    wxLabel.text = @"微信";
    wxLabel.textAlignment = NSTextAlignmentCenter;
    
    [_weChatBtn addSubview:wxLabel];
    
    UILabel *payLabel = [[UILabel alloc]init];
    payLabel.font = [UIFont systemFontOfSize:15*UIRate];
    payLabel.text = @"支付宝";
    payLabel.textAlignment = NSTextAlignmentCenter;
    [_payBtn addSubview:payLabel];

    UIView *lineView2 = [[UIView alloc]init];
    lineView2.backgroundColor = COLOR_BackgroundColor;
    [self.contentView addSubview:lineView2];
    
    UIButton *submitBtn = [[UIButton alloc]init];
    [submitBtn setTitle:@"提交复查" forState:UIControlStateNormal];
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:16*UIRate];
    submitBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    submitBtn.backgroundColor = HEXCOLOR(0xff5c0b);
    submitBtn.layer.cornerRadius = 4.0;
    submitBtn.clipsToBounds = YES;
    [submitBtn addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.contentView addSubview:submitBtn];
    
    titleLabel.sd_layout
    .leftSpaceToView(self.contentView,5*UIRate)
    .widthIs(80*UIRate)
    .topSpaceToView(self.contentView,5*UIRate)
    .heightIs(30*UIRate);
    
    _textField.sd_layout
    .leftSpaceToView(titleLabel,5*UIRate)
    .rightSpaceToView(self.contentView,5*UIRate)
    .topSpaceToView(self.contentView,5*UIRate)
    .heightIs(30*UIRate);
    
    lineView.sd_layout
    .leftSpaceToView(self.contentView,5*UIRate)
    .rightSpaceToView(self.contentView,0)
    .topSpaceToView(titleLabel,5*UIRate)
    .heightIs(1);
    
    fuchaLabel.sd_layout
    .leftSpaceToView(self.contentView,5*UIRate)
    .topSpaceToView(lineView,5*UIRate)
    .widthIs(60*UIRate)
    .heightIs(30*UIRate);
    
    _priceLable.sd_layout
    .rightSpaceToView(self.contentView,5*UIRate)
    .topSpaceToView(lineView,5*UIRate)
    .widthIs(60*UIRate)
    .heightIs(30*UIRate);
    
    lineView1.sd_layout
    .leftSpaceToView(self.contentView,5*UIRate)
    .rightSpaceToView(self.contentView,0)
    .topSpaceToView(_priceLable,5*UIRate)
    .heightIs(1);
    
    fukuanLabel.sd_layout
    .leftSpaceToView(self.contentView,5*UIRate)
    .topSpaceToView(lineView1,5*UIRate)
    .widthIs(60*UIRate)
    .heightIs(30*UIRate);
    
    _weChatBtn.sd_layout
    .leftSpaceToView(self.contentView,71*UIRate)
    .topSpaceToView(fukuanLabel,20*UIRate)
    .widthIs(75*UIRate)
    .heightIs(75*UIRate);
    
    _payBtn.sd_layout
    .rightSpaceToView(self.contentView,71*UIRate)
    .topSpaceToView(fukuanLabel,20*UIRate)
    .widthIs(75*UIRate)
    .heightIs(75*UIRate);
    
    lineView2.sd_layout
    .leftSpaceToView(self.contentView,0)
    .rightSpaceToView(self.contentView,0)
    .topSpaceToView(_payBtn,5*UIRate)
    .heightIs(1);
    
    submitBtn.sd_layout
    .leftSpaceToView(self.contentView,20*UIRate)
    .rightSpaceToView(self.contentView,20*UIRate)
    .topSpaceToView(lineView2,15*UIRate)
    .heightIs(40*UIRate);
    
    payLabel.sd_layout
    .centerXEqualToView(_payBtn)
    .bottomSpaceToView(_payBtn,15*UIRate)
    .widthIs(50*UIRate)
    .heightIs(15*UIRate);
    
    wxLabel.sd_layout
    .centerXEqualToView(_weChatBtn)
    .bottomSpaceToView(_weChatBtn,15*UIRate)
    .widthIs(50*UIRate)
    .heightIs(15*UIRate);
}

-(void)weChatBtn:(UIButton *)btn{
    self.weChatBtn.selected = !self.weChatBtn.selected;
    self.payBtn.selected = !self.payBtn.selected;
}

-(void)payBtn:(UIButton *)btn{
    self.payBtn.selected = !self.payBtn.selected;
    self.weChatBtn.selected = !self.weChatBtn.selected;
    
}
-(void)submit{
    if (self.block0){
        self.block0();//商标起名
    }
}

@end
