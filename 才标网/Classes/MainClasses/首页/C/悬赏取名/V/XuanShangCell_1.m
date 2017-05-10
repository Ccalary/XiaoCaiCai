//
//  XuanShangCell_1.m
//  才标网
//
//  Created by baichun on 17/3/17.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "XuanShangCell_1.h"

@interface XuanShangCell_1()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *tagLabel;
@property (nonatomic, strong) UILabel *dateLable;
@property (nonatomic, strong) UILabel *dateLable1;
@property (nonatomic, strong) UILabel *priceLable;

@end

@implementation XuanShangCell_1
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self drawView];
    }
    
    return self;
}

+ (XuanShangCell_1 *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"XuanShangCell_1";
    XuanShangCell_1 *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[XuanShangCell_1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)drawView
{
    self.iconImageView = [[UIImageView alloc] init];
    _iconImageView.image = [UIImage imageNamed:@"home_icon_default"];
    [self.contentView addSubview:_iconImageView];
    
    self.titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:15*UIRate];
    _titleLabel.textColor = HEXCOLOR(0x333333);
    _titleLabel.text = @"标题";
    [self.contentView addSubview:_titleLabel];
    
    self.tagLabel = [[UILabel alloc] init];
    _tagLabel.font = [UIFont systemFontOfSize:15*UIRate];
    _tagLabel.textColor = COLOR_Blue;
    _tagLabel.text = @"商标起名";
    _tagLabel.textAlignment = NSTextAlignmentCenter;
    _tagLabel.layer.borderColor = COLOR_Blue.CGColor;
    _tagLabel.layer.borderWidth = 1;
    [self.contentView addSubview:_tagLabel];
    
    self.dateLable = [[UILabel alloc] init];
    _dateLable.font = [UIFont systemFontOfSize:13*UIRate];
    _dateLable.textColor = COLOR_LightGray;
//    _dateLable.text = @"7天后截稿";
    _dateLable.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_dateLable];
    
    
    self.dateLable1 = [[UILabel alloc] init];
    _dateLable1.font = [UIFont systemFontOfSize:13*UIRate];
    _dateLable1.textColor = COLOR_LightGray;
    _dateLable1.text = @"未采纳";
    [self.contentView addSubview:_dateLable1];
    
    self.priceLable = [[UILabel alloc] init];
    _priceLable.font = SYSTEM_FONT_BOLD_(15*UIRate);
    _priceLable.textColor = HEXCOLOR(0xff6600);
    _priceLable.text = @"￥0.00";
    _priceLable.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_priceLable];
    
    UIView *dividerLine1 = [[UIView alloc] init];
    dividerLine1.backgroundColor = COLOR_BackgroundColor;
    [self.contentView addSubview:dividerLine1];
    
    _iconImageView.sd_layout
    .leftSpaceToView(self.contentView,15*UIRate)
    .centerYEqualToView(self.contentView)
    .heightIs(50*UIRate)
    .widthIs(50*UIRate);
    _iconImageView.sd_cornerRadiusFromWidthRatio = @(0.5);
    
    _priceLable.sd_layout
    .rightSpaceToView(self.contentView,15*UIRate)
    .topEqualToView(_iconImageView)
    .widthIs(100*UIRate)
    .heightIs(20*UIRate);
    
    _titleLabel.sd_layout
    .leftSpaceToView(_iconImageView,10*UIRate)
    .rightSpaceToView(_priceLable,10*UIRate)
    .topEqualToView(_iconImageView)
    .heightIs(20*UIRate);
    
    _tagLabel.sd_layout
    .leftEqualToView(_titleLabel)
    .bottomSpaceToView(self.contentView,10*UIRate)
    .widthIs(80*UIRate)
    .heightIs(25*UIRate);
    _tagLabel.sd_cornerRadiusFromHeightRatio = @(0.5);
    
    _dateLable1.sd_layout
    .leftSpaceToView(_tagLabel,15*UIRate)
    .centerYEqualToView(_tagLabel)
    .widthIs(70*UIRate)
    .heightIs(20*UIRate);
    
    _dateLable.sd_layout
    .rightEqualToView(_priceLable)
    .centerYEqualToView(_dateLable1)
    .widthIs(100*UIRate)
    .heightIs(20*UIRate);

    dividerLine1.sd_layout
    .leftEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .bottomEqualToView(self.contentView)
    .heightIs(1);
}
- (void)setModel:(TaskModel *)model
{
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.creatorPortrait] placeholderImage:[UIImage imageNamed:@"home_icon_default"]];
    
    self.titleLabel.text = model.taskTitle?:@"";
    if (model.namedCategory == 1) {
        _tagLabel.textColor = COLOR_Blue;
        _tagLabel.text = @"商标起名";
        _tagLabel.layer.borderColor = COLOR_Blue.CGColor;
        _tagLabel.layer.borderWidth = 1;
    }else{
        _tagLabel.textColor = COLOR_Green;
        _tagLabel.text = @"公司起名";
        _tagLabel.layer.borderColor = COLOR_Green.CGColor;
        _tagLabel.layer.borderWidth = 1;
        
    }
    if (model.isXuanShangFenQian == 1) {
        self.dateLable1.text = @"已采纳";
        self.dateLable.text = @"已经截稿";
        self.priceLable.text = [NSString stringWithFormat:@"¥%.2f",model.priceYuan];

    }else{
        self.dateLable1.text = @"未采纳";
        NSString *timeStr = [NSDate getTimeStatusWithFutureTime:model.expireTime];
        self.dateLable.text = [NSString stringWithFormat:@"%@截稿",timeStr];
        self.priceLable.text = [NSString stringWithFormat:@"¥%.2f",model.priceYuan];
    }
   
}

@end
