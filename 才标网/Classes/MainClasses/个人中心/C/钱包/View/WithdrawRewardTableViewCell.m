//
//  WithdrawRewardTableViewCell.m
//  才标网
//
//  Created by caohouhong on 17/3/14.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "WithdrawRewardTableViewCell.h"
@interface WithdrawRewardTableViewCell()
@property (nonatomic, strong) UILabel *topTitleLabel, *leftBotTimeLabel, *rightStatusLabel, *leftNumLabel, *leftReasonLabel;
@end

@implementation WithdrawRewardTableViewCell


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
    
    _topTitleLabel = [[UILabel alloc] init];
    _topTitleLabel.font = SYSTEM_FONT_(15*UIRate);
    _topTitleLabel.textColor = COLOR_darkGray;
    [self.contentView addSubview:_topTitleLabel];
    
    _leftBotTimeLabel = [[UILabel alloc] init];
    _leftBotTimeLabel.font = SYSTEM_FONT_(13*UIRate);
    _leftBotTimeLabel.textColor = COLOR_LightGray;
    [self.contentView addSubview:_leftBotTimeLabel];
    
    _rightStatusLabel = [[UILabel alloc] init];
    _rightStatusLabel.font = SYSTEM_FONT_(15*UIRate);
    _rightStatusLabel.textAlignment = NSTextAlignmentRight;
    _rightStatusLabel.textColor = COLOR_Green;
    [self.contentView addSubview:_rightStatusLabel];
    
    _leftNumLabel = [[UILabel alloc] init];
    _leftNumLabel.font = SYSTEM_FONT_(13*UIRate);
    _leftNumLabel.textColor = COLOR_Gray;
    [self.contentView addSubview:_leftNumLabel];
    
    _leftReasonLabel = [[UILabel alloc] init];
    _leftReasonLabel.font = SYSTEM_FONT_(13*UIRate);
    _leftReasonLabel.textColor = HEXCOLOR(0xff871d);
    _leftReasonLabel.backgroundColor = HEXCOLOR(0xfff0dc);
    [self.contentView addSubview:_leftReasonLabel];
    
    
    _topTitleLabel.sd_layout
    .leftSpaceToView(self.contentView, 15*UIRate)
    .topSpaceToView(self.contentView,10*UIRate)
    .widthIs(60*UIRate)
    .heightIs(20*UIRate);
    [_topTitleLabel setSingleLineAutoResizeWithMaxWidth: ScreenWidth - 100*UIRate];
    
    _leftNumLabel.sd_layout
    .leftEqualToView(_topTitleLabel)
    .topSpaceToView(_topTitleLabel,0)
    .widthIs(ScreenWidth - 100*UIRate)
    .autoHeightRatio(0);//高度自适应
    
    _leftBotTimeLabel.sd_layout
    .leftEqualToView(_topTitleLabel)
    .topSpaceToView(_leftNumLabel,3*UIRate)
    .widthIs(150*UIRate)
    .heightIs(15*UIRate);
    
    _leftReasonLabel.sd_layout
    .leftEqualToView(_topTitleLabel)
    .topSpaceToView(_leftBotTimeLabel,5*UIRate)
    .widthIs(ScreenWidth - 30*UIRate)
    .heightIs(20*UIRate);
    
    _rightStatusLabel.sd_layout
    .rightSpaceToView(self.contentView, 15*UIRate)
    .topSpaceToView(_topTitleLabel,-10*UIRate)
    .widthIs(70*UIRate)
    .heightIs(15*UIRate);

}

- (void)setWithdrawModel:(WithdrawApplyModel *)withdrawModel
{
    _withdrawModel = withdrawModel;
    
    _topTitleLabel.text = [NSString stringWithFormat:@"[提现]%.2f元-支付宝%@",withdrawModel.applyAmountYuan,withdrawModel.alipayAccount];
    _leftBotTimeLabel.text = [NSDate dateWithTimeStamp:withdrawModel.createdTime dateFormat:@""];
    
    _leftReasonLabel.hidden = YES;
   
    //状体码 1-处理中 2-成功 9-失败
    if (withdrawModel.state == 1){
        _rightStatusLabel.textColor = COLOR_Orange;
        _rightStatusLabel.text = @"处理中";
    }else if (withdrawModel.state == 2){
        _rightStatusLabel.textColor = COLOR_Green;
        _rightStatusLabel.text = @"提现成功";
         _leftNumLabel.text = [NSString stringWithFormat:@"流水号:%@",withdrawModel.applyCode];
    }else {
        _rightStatusLabel.textColor = HEXCOLOR(0xe63f3f);
        _rightStatusLabel.text = @"提现失败";
        _leftReasonLabel.text = [NSString stringWithFormat:@"原因：%@",withdrawModel.remark];
        _leftReasonLabel.hidden = NO;
    }
    
}

@end
