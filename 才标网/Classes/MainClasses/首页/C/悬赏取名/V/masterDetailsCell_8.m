//
//  masterDetailsCell_8.m
//  才标网
//
//  Created by baichun on 17/3/14.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "masterDetailsCell_8.h"
@interface masterDetailsCell_8 ()


@end

@implementation masterDetailsCell_8
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self drawView];
    }
    
    return self;
}

+ (masterDetailsCell_8 *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"masterDetailsCell_8";
    masterDetailsCell_8 *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[masterDetailsCell_8 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

-(void)drawView{
    
    _iconImageView = [[UIImageView alloc] init];
    _iconImageView.image = [UIImage imageNamed:@"dashi_touxiang"];
    [self.contentView addSubview:_iconImageView];

    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:14];
    _titleLabel.textColor = COLOR_Black;
    [self.contentView addSubview:_titleLabel];
    
    _tagView = [[TTGroupTagView alloc] initWithFrame:CGRectMake(90*UIRate, 45*UIRate, ScreenWidth - 100*UIRate , 40*UIRate)];
    _tagView.translatesAutoresizingMaskIntoConstraints = YES;
    _tagView.tagHeight = 20*UIRate;
    _tagView.borderColor = COLOR_OrangeRed;
    _tagView.textColor = COLOR_OrangeRed;
    _tagView.selBorderColor = COLOR_OrangeRed;
    [self.contentView addSubview:_tagView];
    
    self.label = [[UILabel alloc]initWithFrame:CGRectMake(100*UIRate, 45*UIRate, ScreenWidth - 100*UIRate , 40*UIRate)];
    _label.font = [UIFont systemFontOfSize:15*UIRate];
    [self.contentView addSubview:_label];
    
    
    UIView *dividerLine1 = [[UIView alloc] init];
    dividerLine1.backgroundColor = COLOR_BackgroundColor;
    [self.contentView addSubview:dividerLine1];
    
    _iconImageView.sd_layout
    .leftSpaceToView(self.contentView,15*UIRate)
    .topSpaceToView(self.contentView,10*UIRate)
    .heightIs(70*UIRate)
    .widthIs(70*UIRate);
    _iconImageView.sd_cornerRadiusFromWidthRatio = @(0.5);
    
    _titleLabel.sd_layout
    .leftSpaceToView(_iconImageView,10*UIRate)
    .topEqualToView(_iconImageView).offset(10*UIRate)
    .heightIs(15*UIRate)
    .widthIs(100*UIRate);
    
}

//请他取名model
- (void)setModel:(ModelMember *)model
{
    _model = model;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.portrait]  placeholderImage:[UIImage imageNamed:@"dashi_touxiang"]];
    
    self.titleLabel.text = model.memberName;
    
    NSString *specialStr = model.memberExtend.teDian;
    NSArray *array = [specialStr componentsSeparatedByString:@"#"];
    if (array.count > 0){
        [_tagView addTags:array withCornerScale:0.2];
    }
}
//
- (void)setModel1:(TaskModel *)model1{
    _model1 = model1;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model1.dashiPortrait]  placeholderImage:[UIImage imageNamed:@"dashi_touxiang"]];
    
    self.titleLabel.text = model1.dashiName;
    NSString *specialStr = model1.teDian;
    NSArray *array = [specialStr componentsSeparatedByString:@"#"];
    if (array.count > 0){
        [_tagView addTags:array withCornerScale:0.2];
    }else{
        
    }

    
}
@end
