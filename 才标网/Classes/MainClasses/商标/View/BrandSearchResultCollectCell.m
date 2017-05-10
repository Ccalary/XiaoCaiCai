//
//  BrandSearchResultCollectCell.m
//  才标网
//
//  Created by caohouhong on 17/3/24.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "BrandSearchResultCollectCell.h"

@interface BrandSearchResultCollectCell()

@property (nonatomic, strong) UIImageView *logoImageView;
@property (nonatomic, strong) UIButton *favButton;
@property (nonatomic, strong) UILabel *titleLabel,*statusLabel,*favNumLabel;
@end


@implementation BrandSearchResultCollectCell

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
    
    _logoImageView = [[UIImageView alloc] init];
  
    _logoImageView.image = [UIImage imageNamed:@"brand_s_default_110x75"];
    [self.contentView addSubview:_logoImageView];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = SYSTEM_FONT_(15*UIRate);
    _titleLabel.textColor = COLOR_darkGray;
    [self.contentView addSubview:_titleLabel];

    _statusLabel = [[UILabel alloc] init];
    _statusLabel.text = @"商标已注册";
    _statusLabel.font = SYSTEM_FONT_(15*UIRate);
    _statusLabel.textColor = COLOR_Gray;
    [self.contentView addSubview:_statusLabel];
    
    //国际号
    _favNumLabel = [[UILabel alloc] init];
    _favNumLabel.font = SYSTEM_FONT_(15*UIRate);
    _favNumLabel.textColor = COLOR_Gray;
    _favNumLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_favNumLabel];

    _favButton = [[UIButton alloc] init];
    [_favButton setImage:[UIImage imageNamed:@"brand_s_fav_n_14x12"] forState:UIControlStateNormal];
    [_favButton setImage:[UIImage imageNamed:@"brand_s_fav_s_14x12"] forState:UIControlStateSelected];
    [_favButton addTarget:self action:@selector(favButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_favButton];
    
    UIView *dividerLine1 = [[UIView alloc] init];
    dividerLine1.backgroundColor = COLOR_BackgroundColor;
    [self.contentView addSubview:dividerLine1];
    
    UIView *dividerLine2 = [[UIView alloc] init];
    dividerLine2.backgroundColor = COLOR_BackgroundColor;
    [self.contentView addSubview:dividerLine2];
    
    UIView *dividerLine3 = [[UIView alloc] init];
    dividerLine3.backgroundColor = COLOR_BackgroundColor;
    [self.contentView addSubview:dividerLine3];
    
    _dividerLine4 = [[UIView alloc] init];
    _dividerLine4.backgroundColor = COLOR_BackgroundColor;
    [self.contentView addSubview:_dividerLine4];
    
    _logoImageView.sd_layout
    .centerXEqualToView(self.contentView)
    .topSpaceToView(self.contentView,20*UIRate)
    .widthIs(110*UIRate)
    .heightIs(75*UIRate);
    
    dividerLine1.sd_layout
    .topEqualToView(self.contentView)
    .leftEqualToView(self.contentView)
    .widthRatioToView(self.contentView,1)
    .heightIs(1);
    
    dividerLine2.sd_layout
    .topSpaceToView(self.contentView,120*UIRate)
    .leftEqualToView(self.contentView)
    .widthRatioToView(self.contentView,1)
    .heightIs(1);
    
    dividerLine3.sd_layout
    .bottomEqualToView(self.contentView)
    .leftEqualToView(self.contentView)
    .widthRatioToView(self.contentView,1)
    .heightIs(1);
    
    _dividerLine4.sd_layout
    .topEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .widthIs(1)
    .heightRatioToView(self.contentView,1);
    
    _titleLabel.sd_layout
    .leftSpaceToView(self.contentView,10*UIRate)
    .topSpaceToView(self.contentView,125*UIRate)
    .widthRatioToView(self.contentView,0.8)
    .heightIs(20*UIRate);

    _statusLabel.sd_layout
    .leftSpaceToView(self.contentView,10*UIRate)
    .topSpaceToView(_titleLabel,0)
    .rightSpaceToView(self.contentView,45*UIRate)
    .heightIs(30*UIRate);
    
    _favButton.sd_layout
    .rightSpaceToView(self.contentView,0*UIRate)
    .centerYEqualToView(_statusLabel)
    .widthIs(30*UIRate)
    .heightIs(30*UIRate);
    
    _favNumLabel.sd_layout
    .centerYEqualToView(_titleLabel)
    .centerXEqualToView(_favButton)
    .widthIs(50*UIRate)
    .heightIs(20*UIRate);
    
   
}
-(void)setModel:(BrandSearchModel *)model{
    
    _model = model;
    
    //brand_s_default_110x75  此处是暂时代替的默认图片
    [_logoImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.image]] placeholderImage:[UIImage imageNamed:@"brand_s_default_110x75"]];
    _titleLabel.text = model.tmname;
    _statusLabel.text = model.tmlaw;
    
    _favNumLabel.text = model.intcls;
    
    if ([model.follow isEqualToString:@"false"]) {
        _favButton.selected = NO;
    }else{
        _favButton.selected = YES;
    }
}
//喜欢
- (void)favButtonAction{
    
    if (_delegate && [_delegate respondsToSelector:@selector(onFavourButtonClick:)]){
        [_delegate onFavourButtonClick:self];
    }
}

@end
