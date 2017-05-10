//
//  MainTableViewCell_5.m
//  才标网
//
//  Created by 李强 on 2017/2/15.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "MainTableViewCell_5.h"
@interface MainTableViewCell_5 ()
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel, *tagLabel, *dateLable, *priceLable;
@property (nonatomic, strong) UIView *tagView;
@end

@implementation MainTableViewCell_5


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self drawView];
    }
    
    return self;
}

+ (MainTableViewCell_5 *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"MainTableViewCell_5";
    MainTableViewCell_5 *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[MainTableViewCell_5 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)drawView
{
    UIView *dividerLine1 = [[UIView alloc] init];
    dividerLine1.backgroundColor = COLOR_BackgroundColor;
    
    _iconImageView = [[UIImageView alloc] init];
    _iconImageView.image = [UIImage imageNamed:@"home_icon_default"];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:18*UIRate];
    _titleLabel.textColor = COLOR_darkGray;
    _titleLabel.text = @"标题";
    
    _tagView = [[UIView alloc] init];
    _tagView.backgroundColor = COLOR_Green;
    
    _tagLabel = [[UILabel alloc] init];
    _tagLabel.font = [UIFont systemFontOfSize:15*UIRate];
    _tagLabel.textColor = COLOR_Gray;
    _tagLabel.text = @"商标起名";

    
    _dateLable = [[UILabel alloc] init];
    _dateLable.font = [UIFont systemFontOfSize:15*UIRate];
    _dateLable.textColor = COLOR_LightGray;
    
    _priceLable = [[UILabel alloc] init];
    _priceLable.font = SYSTEM_FONT_BOLD_(15*UIRate);
    _priceLable.textColor = COLOR_OrangeLight;
    _priceLable.text = @"￥0.00";
    _priceLable.textAlignment = NSTextAlignmentRight;
    
    [self.contentView sd_addSubviews:@[dividerLine1, _iconImageView, _titleLabel, _tagView,_tagLabel, _dateLable, _priceLable]];
    
    _iconImageView.sd_layout
    .leftSpaceToView(self.contentView,10*UIRate)
    .centerYEqualToView(self.contentView)
    .heightIs(50*UIRate)
    .widthIs(50*UIRate);
    _iconImageView.sd_cornerRadiusFromWidthRatio = @(0.5);
    
    _priceLable.sd_layout
    .rightSpaceToView(self.contentView,15*UIRate)
    .centerYEqualToView(self.contentView)
    .widthIs(100*UIRate)
    .heightIs(20*UIRate);
    
    _titleLabel.sd_layout
    .leftSpaceToView(_iconImageView,10*UIRate)
    .topEqualToView(_iconImageView)
    .widthIs(ScreenWidth - 170*UIRate)
    .heightIs(18*UIRate);
    
    _tagLabel.sd_layout
    .leftEqualToView(_titleLabel).offset(12*UIRate)
    .bottomEqualToView(_iconImageView)
    .widthIs(65*UIRate)
    .heightIs(15*UIRate);
    
    _tagView.sd_layout
    .leftEqualToView(_titleLabel)
    .centerYEqualToView(_tagLabel)
    .widthIs(10*UIRate)
    .heightIs(10*UIRate);
    
    [_tagView setSd_cornerRadiusFromHeightRatio:@(0.5)];
    
    _dateLable.sd_layout
    .leftSpaceToView(_tagLabel,30*UIRate)
    .centerYEqualToView(_tagLabel)
    .widthIs(120*UIRate)
    .heightIs(15*UIRate);
    
    dividerLine1.sd_layout
    .leftEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .bottomEqualToView(self.contentView)
    .heightIs(1);
}

- (void)setModel:(TaskModel *)model
{
    _model = model;
    
    //头像
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:model.creatorPortrait] placeholderImage:[UIImage imageNamed:@"home_icon_default"]];
    
    _titleLabel.text = model.taskTitle?:@"";
    //起名分类 1-商标起名 2-公司起名
    if (model.namedCategory == 1){
        _tagLabel.text = @"商标起名";
        _tagView.backgroundColor = COLOR_Blue;
    }else {
        _tagLabel.text = @"公司起名";
        _tagView.backgroundColor = COLOR_Green;
    }
    
    if (model.isXuanShangFenQian == 1) {
        self.dateLable.text = @"已经截稿";
        _priceLable.text = [NSString stringWithFormat:@"¥%.2f",model.price/100.0];//拿的分

        
    }else{
        NSString *timeStr = [NSDate getTimeStatusWithFutureTime:model.expireTime];
        self.dateLable.text = [NSString stringWithFormat:@"%@截稿",timeStr];
        _priceLable.text = [NSString stringWithFormat:@"¥%.2f",model.price/100.0];//拿的分

    }

    
    
   }

@end
