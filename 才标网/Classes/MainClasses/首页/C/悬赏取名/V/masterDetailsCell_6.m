//
//  masterDetailsCell_6.m
//  才标网
//
//  Created by baichun on 17/3/14.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "masterDetailsCell_6.h"

@implementation masterDetailsCell_6
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self drawView];
    }
    
    return self;
}

+ (masterDetailsCell_6 *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"masterDetailsCell_6";
    masterDetailsCell_6 *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[masterDetailsCell_6 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

-(void)drawView{
    
    self.titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:15*UIRate];
    _titleLabel.textColor = HEXCOLOR(0x333333);
    _titleLabel.text = @"具体需求:";
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_titleLabel];
    
    
    self.contentLabel = [[UILabel alloc] init];
    _contentLabel.font = [UIFont systemFontOfSize:14*UIRate];
    _contentLabel.textColor = HEXCOLOR(0x333333);
    _contentLabel.text = @"做洗发液产品推广，主要是男士洗发液，需要一个商标注册名字，谢谢";
    _contentLabel.textAlignment = NSTextAlignmentLeft;

    _contentLabel.numberOfLines = 0;
    [self.contentView addSubview:_contentLabel];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = COLOR_BackgroundColor;
    [self.contentView addSubview:lineView];
    
    _titleLabel.sd_layout
    .leftSpaceToView(self.contentView,15*UIRate)
    .topSpaceToView(self.contentView,10*UIRate)
    .heightIs(30*UIRate)
    .widthIs(280*UIRate);
    
    _contentLabel.sd_layout
    .leftSpaceToView(self.contentView,15*UIRate)
    .topSpaceToView(_titleLabel,5*UIRate)
    .rightSpaceToView(self.contentView,15*UIRate)
    .autoHeightRatio(0);
    
    lineView.sd_layout
    .leftSpaceToView(self.contentView,0)
    .rightSpaceToView(self.contentView,0)
    .bottomSpaceToView(self.contentView,0)
    .heightIs(1);
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
