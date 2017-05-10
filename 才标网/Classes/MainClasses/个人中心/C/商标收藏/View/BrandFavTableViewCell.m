//
//  BrandFavTableViewCell.m
//  才标网
//
//  Created by caohouhong on 17/3/14.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "BrandFavTableViewCell.h"
#import "ToolsHelper.h"

@interface BrandFavTableViewCell()
@property (nonatomic, strong) UILabel *topTitleLabel, *statusLabel, *rightResultLabel;
@property (nonatomic, strong) UIImageView *brandImageView;
@property (nonatomic, strong) UIButton *favButton;
@end

@implementation BrandFavTableViewCell

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
    
    _brandImageView = [[UIImageView alloc] init];
    _brandImageView.image = [UIImage imageNamed:@"uc_order_default_70x75"];
    [self.contentView addSubview:_brandImageView];
    
    _topTitleLabel = [[UILabel alloc] init];
    _topTitleLabel.font = SYSTEM_FONT_(15*UIRate);
    _topTitleLabel.textColor = COLOR_Black;
    [self.contentView addSubview:_topTitleLabel];
    
    _statusLabel = [[UILabel alloc] init];
    _statusLabel.font = SYSTEM_FONT_(14*UIRate);
    _statusLabel.textColor = COLOR_Gray;
    _statusLabel.text = @"商标已注册";
    [self.contentView addSubview:_statusLabel];
    
    _rightResultLabel = [[UILabel alloc] init];
    _rightResultLabel.font = SYSTEM_FONT_(15*UIRate);
    _rightResultLabel.textAlignment = NSTextAlignmentRight;
    _rightResultLabel.textColor = COLOR_darkGray;
    [self.contentView addSubview:_rightResultLabel];
    
    _favButton = [[UIButton alloc] init];
    [_favButton setTitle:@"关注" forState:UIControlStateNormal];
    [_favButton setTitle:@"取消关注" forState:UIControlStateSelected];
    _favButton.selected = YES;
    _favButton.titleLabel.font = SYSTEM_FONT_(15*UIRate);
    [_favButton setTitleColor:COLOR_Red forState:UIControlStateNormal];
    [_favButton setTitleColor:COLOR_Orange forState:UIControlStateSelected];
    [_favButton addTarget:self action:@selector(favBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_favButton];
    
    _brandImageView.sd_layout
    .leftSpaceToView(self.contentView, 15*UIRate)
    .topSpaceToView(self.contentView,10*UIRate)
    .widthIs(80*UIRate)
    .heightIs(80*UIRate);
    
    _topTitleLabel.sd_layout
    .leftSpaceToView(_brandImageView, 15*UIRate)
    .topSpaceToView(self.contentView,15*UIRate)
    .widthIs(ScreenWidth - 120*UIRate)
    .heightIs(15*UIRate);
    
    _statusLabel.sd_layout
    .leftEqualToView(_topTitleLabel)
    .topSpaceToView(_topTitleLabel,6*UIRate)
    .widthIs(ScreenWidth - 160*UIRate)
    .heightIs(15*UIRate);
    
    _favButton.sd_layout
    .leftEqualToView(_topTitleLabel)
    .bottomEqualToView(_brandImageView)
    .widthIs(70*UIRate)
    .heightIs(15*UIRate);
    
    _rightResultLabel.sd_layout
    .rightEqualToView(self.contentView).offset(-15*UIRate)
    .centerYEqualToView(self.contentView)
    .widthIs(50*UIRate)
    .heightIs(15*UIRate);
    
}

//关注
- (void)favBtnAction:(UIButton *)button{
    
    if (self.block){
        self.block(_model);
    }
}

- (void)setModel:(TrademarkFollowModel *)model
{
    _model = model;
    
    [_brandImageView sd_setImageWithURL:[NSURL URLWithString:model.trademark_image] placeholderImage:[UIImage imageNamed:@"uc_order_default_70x75"]];
    
    NSString *str = [NSString stringWithFormat:@"%@%@",model.trademark_regno?:@"",model.trademark_tmname?:@""];
    
    NSMutableAttributedString *attriStr = [ToolsHelper changeSomeText:model.trademark_regno?:@"" inText:str withColor:COLOR_Blue];
    
    _topTitleLabel.attributedText = attriStr;
    
    _statusLabel.text = model.trademark_tmlaw?:@""; //商标状态
    
    _rightResultLabel.text = model.trademark_intcls?:@""; //行业分类
}

@end
