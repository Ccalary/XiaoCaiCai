//
//  WalletTableViewCell.m
//  才标网
//
//  Created by caohouhong on 17/3/14.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "WalletTableViewCell.h"
@interface WalletTableViewCell()
@property (nonatomic, strong) UILabel *topTitleLabel, *leftBotTimeLabel, *rightTopLabel, *rightBotLabel;
@end

@implementation WalletTableViewCell

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
//    _topTitleLabel.text = @"提现";
    [self.contentView addSubview:_topTitleLabel];
    
    _leftBotTimeLabel = [[UILabel alloc] init];
    _leftBotTimeLabel.font = SYSTEM_FONT_(13*UIRate);
    _leftBotTimeLabel.textColor = COLOR_LightGray;
    _leftBotTimeLabel.text = @"2017-02-04 15:15";
    [self.contentView addSubview:_leftBotTimeLabel];
    
    _rightTopLabel = [[UILabel alloc] init];
    _rightTopLabel.font = SYSTEM_FONT_(15*UIRate);
    _rightTopLabel.textAlignment = NSTextAlignmentRight;
    _rightTopLabel.textColor = COLOR_Green;
    _rightTopLabel.text = @"- ¥20.00";
    [self.contentView addSubview:_rightTopLabel];
    
    _rightBotLabel = [[UILabel alloc] init];
    _rightBotLabel.font = SYSTEM_FONT_(13*UIRate);
    _rightBotLabel.textAlignment = NSTextAlignmentRight;
    _rightBotLabel.textColor = COLOR_Gray;
    _rightBotLabel.text = @"余额 ¥30.00";
    [self.contentView addSubview:_rightBotLabel];
    
    _topTitleLabel.sd_layout
    .leftSpaceToView(self.contentView, 15*UIRate)
    .topSpaceToView(self.contentView,15)
    .widthIs(60*UIRate)
    .heightIs(15*UIRate);
    [_topTitleLabel setSingleLineAutoResizeWithMaxWidth: ScreenWidth - 100*UIRate];
    
    _leftBotTimeLabel.sd_layout
    .leftEqualToView(_topTitleLabel)
    .topSpaceToView(_topTitleLabel,6*UIRate)
    .widthIs(150*UIRate)
    .heightIs(15*UIRate);
    
    _rightTopLabel.sd_layout
    .rightEqualToView(self.contentView).offset(-15*UIRate)
    .centerYEqualToView(_topTitleLabel)
    .widthIs(150*UIRate)
    .heightIs(15*UIRate);
    
    _rightBotLabel.sd_layout
    .rightEqualToView(self.contentView).offset(-15*UIRate)
    .centerYEqualToView(_leftBotTimeLabel)
    .widthIs(150*UIRate)
    .heightIs(15*UIRate);
    //宽度自适应
    //    [_rightTimeLabel setSingleLineAutoResizeWithMaxWidth: 150];

}


//帐户列表
- (void)setAccountModel:(AccountModel *)accountModel
{
    _accountModel = accountModel;
    
    _topTitleLabel.text = accountModel.reason;
    _leftBotTimeLabel.text = [NSDate dateWithTimeStamp:accountModel.createdTime  dateFormat:@""];
    
    
    NSString *flowStr = [NSString stringWithFormat:@"%.2f",accountModel.flowAmountYuan];
    if ([flowStr containsString:@"-"]){
        _rightTopLabel.textColor = COLOR_Green;
        flowStr = [flowStr stringByReplacingOccurrencesOfString:@"-" withString:@"- ¥"];
    }else {
        _rightTopLabel.textColor = [UIColor redColor];
        flowStr = [NSString stringWithFormat:@"+ ¥%@",flowStr];
    }
    _rightTopLabel.text = flowStr;
    _rightBotLabel.text = [NSString stringWithFormat:@"余额 ¥%.2f",accountModel.accountBalanceYuan];
}

@end
