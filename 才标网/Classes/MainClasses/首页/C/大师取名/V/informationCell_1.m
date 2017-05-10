//
//  informationCell_1.m
//  才标网
//
//  Created by baichun on 17/3/18.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "informationCell_1.h"
@interface informationCell_1 ()
@property(nonatomic,strong)UIImageView *iconImageView;
@property(nonatomic,strong)UIImageView *backgroundImageView;

@property(nonatomic,strong)UILabel *titleLabel;
@end

@implementation informationCell_1
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        
        [self drawView];
    }
    
    return self;
}

+ (informationCell_1 *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"informationCell_1";
    informationCell_1 *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    cell.backgroundColor = COLOR_BackgroundColor;
    if (cell == nil)
    {
        cell = [[informationCell_1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)drawView
{
    self.backgroundImageView = [[UIImageView alloc]init];
    self.backgroundImageView.image = [UIImage imageNamed:@"dashi_bgdsxq"];
    [self.contentView addSubview:self.backgroundImageView];
    
    self.iconImageView = [[UIImageView alloc] init];
    self.iconImageView.image = [UIImage imageNamed:@"dashi_touxiang"];
    [self.backgroundImageView addSubview:self.iconImageView];
    
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont systemFontOfSize:15*UIRate];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.backgroundImageView addSubview:self.titleLabel];
    
    self.backgroundImageView.sd_layout
    .leftSpaceToView(self.contentView,0)
    .rightSpaceToView(self.contentView,0)
    .topSpaceToView(self.contentView,0)
    .bottomSpaceToView(self.contentView,0);
    
    self.iconImageView.sd_layout
    .centerXEqualToView(self.backgroundImageView)
    .topSpaceToView(self.backgroundImageView,40*UIRate)
    .heightIs(85*UIRate)
    .widthIs(85*UIRate);
    self.iconImageView.sd_cornerRadiusFromWidthRatio = @(0.5);
    
    self.titleLabel.sd_layout
    .centerXEqualToView(self.contentView)
    .topSpaceToView(self.iconImageView,15*UIRate)
    .widthIs(100*UIRate)
    .heightIs(20*UIRate);
}

- (void)setModel:(ModelMember *)model
{
    _model = model;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.portrait] placeholderImage:[UIImage imageNamed:@"dashi_touxiang"]];
      self.titleLabel.text = model.memberName;
    
    self.titleLabel.text = model.memberName?:@"";

}

@end
