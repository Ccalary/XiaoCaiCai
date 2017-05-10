//
//  RenWuXiangQingCell_1.m
//  才标网
//
//  Created by baichun on 17/3/8.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "RenWuXiangQingCell_1.h"

@implementation RenWuXiangQingCell_1

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self drawView];
    }
    
    return self;
}

+ (RenWuXiangQingCell_1 *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"RenWuXiangQingCell_1";
    RenWuXiangQingCell_1 *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[RenWuXiangQingCell_1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)drawView
{
    [self addUnderlineWithLeftMargin:0];
    
    self.titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:14*UIRate];
    _titleLabel.textColor = HEXCOLOR(0x333333);
    _titleLabel.text = @"标题";
    _titleLabel.numberOfLines = 0;
    [self.contentView addSubview:_titleLabel];
    
    self.tagLabel = [[UILabel alloc] init];
    _tagLabel.font = [UIFont systemFontOfSize:12*UIRate];
    _tagLabel.textColor = COLOR_ButtonBackGround_Blue;
    _tagLabel.text = @"商标起名";
    _tagLabel.textAlignment = NSTextAlignmentCenter;
    _tagLabel.layer.borderColor = COLOR_ButtonBackGround_Blue.CGColor;
    _tagLabel.layer.borderWidth = 1;
    [self.contentView addSubview:_tagLabel];
    
    self.priceLable = [[UILabel alloc] init];
    _priceLable.font = [UIFont systemFontOfSize:18*UIRate];
    _priceLable.textColor = HEXCOLOR(0xff6600);
    _priceLable.text = @"￥0.00";
    _priceLable.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_priceLable];
    
    UIView *xianView = [[UIView alloc]init];
    xianView.backgroundColor = COLOR_BackgroundColor;
    [self.contentView addSubview:xianView];
    
    UIImageView *iconImageView = [[UIImageView alloc] init];
    iconImageView.image = [UIImage imageNamed:@"details_tuoguan"];
    [self.contentView addSubview:iconImageView];
    
    UILabel *tuoGuanLabel = [[UILabel alloc]init];
    tuoGuanLabel.font = [UIFont systemFontOfSize:12*UIRate];
    tuoGuanLabel.textColor = HEXCOLOR(0x999999);
    tuoGuanLabel.text = @"已托管赏金";

    [self.contentView addSubview:tuoGuanLabel];
    
    self.touGaoLabel = [[UILabel alloc]init];
    _touGaoLabel.font = [UIFont systemFontOfSize:12*UIRate];
    _touGaoLabel.textColor = COLOR_OrangeRed;
    _touGaoLabel.text = @"0个投稿";
    _touGaoLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_touGaoLabel];

    self.stop = [[UILabel alloc]init];
    _stop.font = [UIFont systemFontOfSize:12*UIRate];
    _stop.textColor = HEXCOLOR(0x999999);
    _stop.text = @"";
    _stop.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_stop];
    
    
    _tagLabel.sd_layout
    .leftSpaceToView(self.contentView,10*UIRate)
    .topSpaceToView(self.contentView,10*UIRate)
    .widthIs(60*UIRate)
    .heightIs(18*UIRate);
    _tagLabel.sd_cornerRadiusFromHeightRatio = @(0.5);

    _titleLabel.sd_layout
    .leftSpaceToView(_tagLabel,10*UIRate)
    .topEqualToView(_tagLabel)
    .widthIs(200*UIRate)
    .autoHeightRatio(0);
    
    _priceLable.sd_layout
    .rightSpaceToView(self.contentView,15*UIRate)
    .topEqualToView(_titleLabel)
    .widthIs(80*UIRate)
    .heightIs(18*UIRate);
    
    xianView.sd_layout
    .leftEqualToView(_tagLabel)
    .rightSpaceToView(self.contentView,0)
    .topSpaceToView(_titleLabel,10*UIRate)
    .heightIs(1);
    
    iconImageView.sd_layout
    .leftEqualToView(xianView)
    .topSpaceToView(xianView,16*UIRate)
    .widthIs(13*UIRate)
    .heightIs(13*UIRate);
    
    tuoGuanLabel.sd_layout
    .leftSpaceToView(iconImageView,5)
    .centerYEqualToView(iconImageView)
    .widthIs(90*UIRate)
    .heightIs(18*UIRate);
    
    _touGaoLabel.sd_layout
    .leftSpaceToView(tuoGuanLabel,10)
    .centerYEqualToView(tuoGuanLabel)
    .widthIs(60*UIRate)
    .heightIs(18*UIRate);
    
    _stop.sd_layout
    .rightEqualToView(_priceLable)
    .centerYEqualToView(_touGaoLabel)
    .widthIs(80*UIRate)
    .heightIs(18*UIRate);

}

-(void)setTaskModel:(TaskModel *)model{
    
    self.titleLabel.text = model.taskTitle?:@"标题";
    
    if (model.namedCategory == 1) {
        self.tagLabel.text = @"商标起名";
    }else{
        self.tagLabel.text = @"公司起名";
    }
    self.priceLable.text = [NSString stringWithFormat:@"￥%.2f",model.priceYuan];
    self.touGaoLabel.text = [NSString stringWithFormat:@"%d个投稿",model.touGaoNum];
    NSString *timeStr = [NSDate getTimeStatusWithFutureTime:model.expireTime];
    NSString *isXuangShangFenQian = [NSString stringWithFormat:@"%d",model.isXuanShangFenQian];
    if ([isXuangShangFenQian isEqualToString:@"1"]) {
         self.stop.text = @"已经截稿";
        self.stop.textColor = COLOR_Blue;
    }else{
    self.stop.text = [NSString stringWithFormat:@"%@截稿",timeStr];
        _stop.textColor = HEXCOLOR(0x999999);
    }
}
@end
