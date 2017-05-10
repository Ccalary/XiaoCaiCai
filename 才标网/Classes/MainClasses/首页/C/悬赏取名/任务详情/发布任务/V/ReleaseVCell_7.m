//
//  ReleaseVCell_7.m
//  才标网
//
//  Created by baichun on 17/3/17.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "ReleaseVCell_7.h"

@implementation ReleaseVCell_7
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self drawView];
    }
    
    return self;
}

+ (ReleaseVCell_7 *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"ReleaseVCell_7";
    ReleaseVCell_7 *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[ReleaseVCell_7 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

-(void)drawView{
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"截稿周期";
    titleLabel.font = [UIFont systemFontOfSize:15*UIRate];
    titleLabel.textColor = COLOR_Black;
    [self.contentView addSubview:titleLabel];
    
    UILabel *titleLabel1 = [[UILabel alloc]init];
    titleLabel1.text = @"悬赏金额";
    titleLabel1.font = [UIFont systemFontOfSize:15*UIRate];
    titleLabel1.textColor = COLOR_Black;
    [self.contentView addSubview:titleLabel1];
    
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = COLOR_BackgroundColor;
    [self.contentView addSubview:lineView];
    
    UIView *lineView1 = [[UIView alloc]init];
    lineView1.backgroundColor = COLOR_BackgroundColor;
    [self.contentView addSubview:lineView1];
    
    _timeBtn = [[UIButton alloc]init];
    [_timeBtn setTitle:@"--天" forState:UIControlStateNormal];
    [_timeBtn setTitleColor:COLOR_OrangeRed forState:UIControlStateNormal];
    _timeBtn.titleLabel.font = [UIFont systemFontOfSize:13*UIRate];
    [_timeBtn setImage:[UIImage imageNamed:@"icon_xiala2"] forState:UIControlStateNormal];
    [_timeBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [_timeBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight
                                      imageTitleSpace:15];
    _timeBtn.tag = 1025;
     [_timeBtn addTarget:self action:@selector(timeBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_timeBtn];
    
    _moneyBtn = [[UIButton alloc]init];
    [_moneyBtn setTitle:@"--元" forState:UIControlStateNormal];
    [_moneyBtn setTitleColor:COLOR_OrangeRed forState:UIControlStateNormal];
    _moneyBtn.tag = 1026;
    [_moneyBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [_moneyBtn setImage:[UIImage imageNamed:@"icon_xiala2"] forState:UIControlStateNormal];
    _moneyBtn.titleLabel.font = [UIFont systemFontOfSize:13*UIRate];
    [_moneyBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight
                             imageTitleSpace:15];
    [_moneyBtn addTarget:self action:@selector(moneyBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_moneyBtn];
    
    UILabel *promptLabel = [[UILabel alloc]init];
    promptLabel.font = [UIFont systemFontOfSize:12*UIRate];
    promptLabel.textColor = COLOR_Green;
    promptLabel.text = @"提示：如无人投稿，赏金将退款，如果有人投稿但您未采纳稿件，赏金将被所有投稿人平分。";
    promptLabel.numberOfLines = 0;
    [self.contentView addSubview:promptLabel];
    
    UILabel *wayLabel = [[UILabel alloc]init];
    wayLabel.text = @"付款方式";
    wayLabel.textColor = COLOR_LightGray;
    wayLabel.font = [UIFont systemFontOfSize:12*UIRate];
    [self.contentView addSubview:wayLabel];
    

    self.wxBtn = [[UIButton alloc]init];
    [_wxBtn setImage:[UIImage imageNamed:@"btn_weixin_s"] forState:UIControlStateNormal];
    _wxBtn.selected = YES;
    _wxBtn.tag = 8888;
    [_wxBtn addTarget:self action:@selector(weixinbtn) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_wxBtn];
    
    self.payBtn = [[UIButton alloc]init];
    [_payBtn setImage:[UIImage imageNamed:@"btn_zhifubao_n"] forState:UIControlStateNormal];
    _payBtn.selected = NO;
    [_payBtn addTarget:self action:@selector(queryse) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_payBtn];
    UILabel *wxLabel = [[UILabel alloc]init];
    wxLabel.font = [UIFont systemFontOfSize:12*UIRate];
    wxLabel.text = @"微信";
    wxLabel.textAlignment = NSTextAlignmentCenter;

    [_wxBtn addSubview:wxLabel];
    
    UILabel *payLabel = [[UILabel alloc]init];
    payLabel.font = [UIFont systemFontOfSize:12*UIRate];
    payLabel.text = @"支付宝";
    payLabel.textAlignment = NSTextAlignmentCenter;
    [_payBtn addSubview:payLabel];

    
    
    titleLabel.sd_layout
    .leftSpaceToView(self.contentView,15*UIRate)
    .topSpaceToView(self.contentView,5*UIRate)
    .widthIs(100*UIRate)
    .heightIs(20*UIRate);
    
    _timeBtn.sd_layout
    .rightSpaceToView(self.contentView,22*UIRate)
    .topSpaceToView(self.contentView,5*UIRate)
    .widthIs(150*UIRate)
    .heightIs(20*UIRate);
    
    lineView.sd_layout
    .leftSpaceToView(self.contentView,0)
    .rightSpaceToView(self.contentView,0)
    .heightIs(1)
    .topSpaceToView(_timeBtn,5*UIRate);
    
    titleLabel1.sd_layout
    .leftSpaceToView(self.contentView,15*UIRate)
    .rightEqualToView(titleLabel)
    .topSpaceToView(lineView,5*UIRate)
    .heightIs(20*UIRate);
    
    _moneyBtn.sd_layout
    .rightSpaceToView(self.contentView,22*UIRate)
    .topSpaceToView(lineView,5*UIRate)
    .widthIs(150*UIRate)
    .heightIs(20*UIRate);
    
    
    lineView1.sd_layout
    .leftSpaceToView(self.contentView,0)
    .rightSpaceToView(self.contentView,0)
    .heightIs(1)
    .topSpaceToView(_moneyBtn,5*UIRate);
    
    promptLabel.sd_layout
    .leftSpaceToView(self.contentView,15*UIRate)
    .rightSpaceToView(self.contentView,15*UIRate)
    .topSpaceToView(lineView1,2*UIRate)
    .heightIs(40*UIRate);
    
    wayLabel.sd_layout
    .leftSpaceToView(self.contentView,15*UIRate)
    .rightSpaceToView(self.contentView,0)
    .topSpaceToView(promptLabel,5*UIRate)
    .heightIs(20*UIRate);
    
    
    _wxBtn.sd_layout
    .leftSpaceToView(self.contentView,71*UIRate)
    .topSpaceToView(wayLabel,20*UIRate)
    .widthIs(80*UIRate)
    .heightIs(80*UIRate);
    
    
    _payBtn.sd_layout
    .rightSpaceToView(self.contentView,71*UIRate)
    .topSpaceToView(wayLabel,20*UIRate)
    .widthIs(80*UIRate)
    .heightIs(80*UIRate);
    
    
    payLabel.sd_layout
    .centerXEqualToView(_payBtn)
    .bottomSpaceToView(_payBtn,15*UIRate)
    .widthIs(60*UIRate)
    .heightIs(15*UIRate);

    
    wxLabel.sd_layout
    .centerXEqualToView(_wxBtn)
    .bottomSpaceToView(_wxBtn,15*UIRate)
    .widthIs(60*UIRate)
    .heightIs(15*UIRate);
}

-(void)timeBtn:(UIButton *)btn{
    
    self.block0(self.timeBtn);
    
}

-(void)moneyBtn:(UIButton *)btn{
    
    self.block1(self.moneyBtn);

    
}
-(void)weixinbtn{
    
    self.wxBtn.selected = YES;
    self.payBtn.selected = NO;
    [_payBtn setImage:[UIImage imageNamed:@"btn_zhifubao_n"] forState:UIControlStateNormal];
    [_wxBtn setImage:[UIImage imageNamed:@"btn_weixin_s"] forState:UIControlStateNormal];
    DLog(@"!");
}

-(void)queryse{
    DLog(@"2");
    self.payBtn.selected = YES;
    self.wxBtn.selected = NO;
    [_payBtn setImage:[UIImage imageNamed:@"btn_zhifubao_s"] forState:UIControlStateNormal];
    [_wxBtn setImage:[UIImage imageNamed:@"btn_weixin_n"] forState:UIControlStateNormal];
}






- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
