//
//  masterDetailsCell_1.m
//  才标网
//
//  Created by baichun on 17/3/14.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "masterDetailsCell_1.h"

@implementation masterDetailsCell_1
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self drawView];
    }
    
    return self;
}

+ (masterDetailsCell_1 *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"masterDetailsCell_1";
    masterDetailsCell_1 *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[masterDetailsCell_1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

-(void)drawView{
    self.tagLabel = [[UILabel alloc] init];
    _tagLabel.font = [UIFont systemFontOfSize:12*UIRate];
    _tagLabel.textColor = COLOR_ButtonBackGround_Blue;
    _tagLabel.text = @"商标起名";
    _tagLabel.textAlignment = NSTextAlignmentCenter;
    _tagLabel.layer.borderColor = COLOR_ButtonBackGround_Blue.CGColor;
    _tagLabel.layer.borderWidth = 1;
    _tagLabel.layer.cornerRadius = 10;
    [self.contentView addSubview:_tagLabel];
    
    self.titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:15*UIRate];
    _titleLabel.textColor = HEXCOLOR(0x333333);
    _titleLabel.text = @"请大师取个好名字";
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_titleLabel];
    
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:lineView];
    
    self.priceLable = [[UILabel alloc] init];
    _priceLable.font = [UIFont systemFontOfSize:16*UIRate];
    _priceLable.textColor = HEXCOLOR(0xff6600);
    _priceLable.text = @"￥998";
    [self.contentView addSubview:_priceLable];

    self.complete = [[UILabel alloc] init];
    _complete.font = [UIFont systemFontOfSize:12*UIRate];
    _complete.textColor = HEXCOLOR(0xff6600);
    _complete.text = @"取名完成";
    _complete.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_complete];
    
    _tagLabel.sd_layout
    .leftSpaceToView(self.contentView,15*UIRate)
    .topSpaceToView(self.contentView,10*UIRate)
    .widthIs(60*UIRate)
    .heightIs(20*UIRate);
    
    _titleLabel.sd_layout
    .leftSpaceToView(_tagLabel,15*UIRate)
    .rightSpaceToView(self.contentView,15*UIRate)
    .topSpaceToView(self.contentView,5*UIRate)
    .heightIs(30*UIRate);
    
    
    lineView.sd_layout
    .leftEqualToView(_tagLabel)
    .rightEqualToView(self.contentView)
    .topSpaceToView(_tagLabel,1)
    .heightIs(1);
    
    
    _priceLable.sd_layout
    .leftSpaceToView(self.contentView,10*UIRate)
    .topSpaceToView(lineView,3*UIRate)
    .widthIs(160*UIRate)
    .heightIs(30*UIRate);
    
    
    _complete.sd_layout
    .rightSpaceToView(self.contentView,15*UIRate)
    .topEqualToView(_priceLable)
    .widthIs(80*UIRate)
    .heightIs(20*UIRate);
    
    
}







- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
