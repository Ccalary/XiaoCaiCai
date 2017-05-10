//
//  MainCollectionViewCell.m
//  才标网
//
//  Created by caohouhong on 17/3/28.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "MainCollectionViewCell.h"
@interface MainCollectionViewCell()
@property (nonatomic, strong) UIImageView *headerImageView;
@property (nonatomic, strong) UILabel *nameLabel, *desLabel;
@property (nonatomic, strong) UIButton *numButton;
@end

@implementation MainCollectionViewCell

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
    
    UIImageView *bgImageView = [[UIImageView alloc] init];
    bgImageView.image = [UIImage imageNamed:@"home_bg_white_250x297"];
    [self.contentView addSubview:bgImageView];
    
    _headerImageView = [[UIImageView alloc] init];
    _headerImageView.image = [UIImage imageNamed:@"home_master_default_165x145"];//110x80
    _headerImageView.layer.cornerRadius = 4.0;
    _headerImageView.clipsToBounds = YES;
    
    _nameLabel = [self creatLabelWithText:@"名字"];
    
    _desLabel = [self creatLabelWithText:@""];
    _desLabel.textColor = COLOR_darkGray;
    _desLabel.numberOfLines = 4;
    
    _numButton = [[UIButton alloc] init];
    _numButton.titleLabel.font = SYSTEM_FONT_(13*UIRate);
    [_numButton setImage:[UIImage imageNamed:@"home_yellow_dot_10x10"] forState:UIControlStateNormal];
    _numButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [_numButton setTitleColor:COLOR_Gray forState:UIControlStateNormal];
    [_numButton setTitle:@"成功起名0例" forState:UIControlStateNormal];
    
    [self.contentView sd_addSubviews:@[_headerImageView, _nameLabel, _desLabel, _numButton]];

    bgImageView.sd_layout
    .leftEqualToView(self.contentView)
    .topEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .bottomEqualToView(self.contentView);
    
    _headerImageView.sd_layout
    .centerXEqualToView(self.contentView)
    .topEqualToView(self.contentView).offset(10*UIRate)
    .widthIs(203*UIRate)
    .heightIs(200*UIRate);
    
    _nameLabel.sd_layout
    .leftEqualToView(_headerImageView).offset(5*UIRate)
    .topSpaceToView(_headerImageView,10*UIRate)
    .widthIs(150*UIRate)
    .heightIs(15*UIRate);
    
    _desLabel.sd_layout
    .leftEqualToView(_nameLabel)
    .topSpaceToView(_nameLabel,5*UIRate)
    .rightEqualToView(_headerImageView).offset(-5*UIRate)
    .heightIs(35*UIRate);
    
    _numButton.sd_layout
    .rightEqualToView(_desLabel).offset(-5*UIRate)
    .topSpaceToView(_desLabel,5*UIRate)
    .widthIs(180*UIRate)
    .heightIs(15*UIRate);
    [_numButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:2*UIRate];
}

- (UILabel *)creatLabelWithText:(NSString *)text {
    UILabel *textlabel = [[UILabel alloc] init];
    textlabel.text = text;
    textlabel.font = SYSTEM_FONT_(13*UIRate);
    textlabel.textColor = COLOR_Black;
    return textlabel;
}

- (void)setModel:(ModelMember *)model
{
    _model = model;
    
    //头像
    [_headerImageView sd_setImageWithURL:[NSURL URLWithString:model.portrait] placeholderImage:[UIImage imageNamed:@"home_master_default_165x145"]];
    //姓名
    _nameLabel.text = model.memberName?:@"";
    
    _desLabel.text = model.memberExtend.introduce?:@"暂无";
    
    [_numButton setTitle:[NSString stringWithFormat:@"成功起名%i例", model.memberExtend.daShiTaskNum2] forState:UIControlStateNormal];
}

@end
