//
//  MyOrderDetailCell3.m
//  才标网
//
//  Created by caohouhong on 17/3/27.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "MyOrderDetailCell3.h"
@interface MyOrderDetailCell3()
@property (nonatomic, strong) UILabel *statusLabel, *dateLabel;
@end

@implementation MyOrderDetailCell3

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
    
    _statusLabel = [[UILabel alloc] init];
    _statusLabel.font = SYSTEM_FONT_(15*UIRate);
    _statusLabel.textColor = COLOR_LineViewColor;
    _statusLabel.text = @"【未支付】";
    [self.contentView addSubview:_statusLabel];
    
    _dateLabel = [[UILabel alloc] init];
    _dateLabel.font = SYSTEM_FONT_(15*UIRate);
    _dateLabel.textColor = COLOR_LineViewColor;
    [self.contentView addSubview:_dateLabel];
    
    UIView *dividerLine1 = [[UIView alloc] init];
    dividerLine1.backgroundColor = COLOR_BackgroundColor;
    [self.contentView addSubview:dividerLine1];
    
    UIView *roundView = [[UIView alloc] init];
    roundView.backgroundColor = COLOR_LightGray;
    [self.contentView addSubview:roundView];
    
    _statusLabel.sd_layout
    .leftSpaceToView(self.contentView, 50*UIRate)
    .topSpaceToView(self.contentView,10*UIRate)
    .widthIs(ScreenWidth - 100*UIRate)
    .heightIs(15*UIRate);
    
    _dateLabel.sd_layout
    .leftEqualToView(_statusLabel)
    .topSpaceToView(_statusLabel,8*UIRate)
    .widthIs(ScreenWidth - 100*UIRate)
    .heightIs(15*UIRate);
    
    dividerLine1.sd_layout
    .topSpaceToView(self.contentView, 0)
    .leftSpaceToView(self.contentView, 30*UIRate)
    .widthIs(1)
    .heightRatioToView(self.contentView, 1);
    
    roundView.sd_layout
    .centerXEqualToView(dividerLine1)
    .centerYEqualToView(_statusLabel)
    .widthIs(10*UIRate)
    .heightIs(10*UIRate);
    
    roundView.sd_cornerRadiusFromWidthRatio = @(0.5);
}

- (void)setHisModel:(OrderStateHistoryModel *)hisModel
{
    _hisModel = hisModel;
    
    _statusLabel.text = [NSString stringWithFormat:@"【%@】",hisModel.status?:@""];
    
    _dateLabel.text = [NSString stringWithFormat:@"%@",hisModel.date_added];
}


@end
