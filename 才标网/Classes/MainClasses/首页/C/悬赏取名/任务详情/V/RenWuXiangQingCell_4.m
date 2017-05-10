//
//  RenWuXiangQingCell_4.m
//  才标网
//
//  Created by baichun on 17/3/13.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "RenWuXiangQingCell_4.h"
#import "ToolsHelper.h"
@implementation RenWuXiangQingCell_4
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self drawView];
    }
    
    return self;
}

+ (RenWuXiangQingCell_4 *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"RenWuXiangQingCell_4";
    RenWuXiangQingCell_4 *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[RenWuXiangQingCell_4 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

-(void)drawView{
    
    
    
    self.nameLabel = [[UILabel alloc]init];
    _nameLabel.font = [UIFont systemFontOfSize:15*UIRate];
    _nameLabel.textColor = COLOR_Gray;
    _nameLabel.text = @"名称：辉格";

    [self.contentView addSubview:_nameLabel];
    
    self.adoptLabl = [[UILabel alloc]init];
    _adoptLabl.font = [UIFont systemFontOfSize:14*UIRate];
    _adoptLabl.textColor = HEXCOLOR(0xc7c7cd);
    _adoptLabl.text = @"未采纳";

    [self.contentView addSubview:_adoptLabl];
    
    
    self.explainLabel = [[UILabel alloc]init];
    _explainLabel.font = [UIFont systemFontOfSize:15*UIRate];
    _explainLabel.textColor = COLOR_Gray;
    _explainLabel.text = @"释义：光辉有格调";
    _explainLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_explainLabel];
    
    UIView *linewView = [[UIView alloc]init];
    linewView.backgroundColor = COLOR_BackgroundColor;
    [self.contentView addSubview:linewView];
    
    
    self.iconImageView = [[UIImageView alloc] init];
    _iconImageView.image = [UIImage imageNamed:@"pic_man"];
    [self.contentView addSubview:_iconImageView];
    
    self.iphoneLabel = [[UILabel alloc]init];
    _iphoneLabel.font = [UIFont systemFontOfSize:14*UIRate];
    _iphoneLabel.textColor = HEXCOLOR(0x333333);
    _iphoneLabel.text = @"187****1003";
    _iphoneLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_iphoneLabel];
    
    self.sexImabeView = [[UIImageView alloc]init];
    _sexImabeView.image = [UIImage imageNamed:@"details_man"];
    [self.contentView addSubview:_sexImabeView];
    
    self.timeLabel = [[UILabel alloc]init];
    _timeLabel.font = [UIFont systemFontOfSize:10*UIRate];
    _timeLabel.textColor = HEXCOLOR(0x666666);
    _timeLabel.text = @"2014-02-07";
    _timeLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_timeLabel];
    
    self.queryLabel = [[UILabel alloc]init];
    _queryLabel.font = [UIFont systemFontOfSize:10*UIRate];
    _queryLabel.textColor = COLOR_Blue;
    _queryLabel.textAlignment = NSTextAlignmentLeft;
    _queryLabel.text = @"";
    [self.contentView addSubview:_queryLabel];
   
    UIView *lineView1 = [[UIView alloc]init];
    lineView1.backgroundColor = COLOR_BackgroundColor;
    [self.contentView addSubview:lineView1];
   
    _iconImageView.sd_layout
    .leftSpaceToView(self.contentView,20*UIRate)
    .topSpaceToView(self.contentView,10*UIRate)
    .heightIs(40*UIRate)
    .widthIs(40*UIRate);
    _iconImageView.sd_cornerRadiusFromWidthRatio = @(0.5);
    
    
    _iphoneLabel.sd_layout
    .leftSpaceToView(_iconImageView,10*UIRate)
    .topEqualToView(_iconImageView)
    .heightIs(20*UIRate)
    .widthIs(150*UIRate);
    
    _sexImabeView.sd_layout
    .leftSpaceToView(_iphoneLabel,5*UIRate)
    .topEqualToView(_iphoneLabel)
    .heightIs(15*UIRate)
    .widthIs(15*UIRate);
    
    
    _timeLabel.sd_layout
    .leftEqualToView(_iphoneLabel)
    .bottomEqualToView(_iconImageView)
    .topSpaceToView(_iphoneLabel,5*UIRate)
    .widthIs(70*UIRate);
    
    _queryLabel.sd_layout
    .leftSpaceToView(_timeLabel,5*UIRate)
    .bottomEqualToView(_timeLabel)
    .topEqualToView(_timeLabel)
    .widthIs(50*UIRate);

    linewView.sd_layout
    .leftSpaceToView(self.contentView,0)
    .rightSpaceToView(self.contentView,0)
    .topSpaceToView(self.iconImageView,5*UIRate)
    .heightIs(1);
    
    self.nameLabel.sd_layout
    .leftSpaceToView(self.contentView,20*UIRate)
    .topSpaceToView(linewView,5*UIRate)
    .widthIs(200*UIRate)
    .heightIs(20*UIRate);
    
    
    self.adoptLabl.sd_layout
    .rightSpaceToView(self.contentView,15*UIRate)
    .topSpaceToView(linewView,5*UIRate)
    .widthIs(50*UIRate)
    .heightIs(20*UIRate);
    
    self.explainLabel.sd_layout
    .leftEqualToView(_nameLabel)
    .rightSpaceToView(self.contentView,15*UIRate)
    .topSpaceToView(self.adoptLabl,5*UIRate)
    .heightIs(20*UIRate);
    
    lineView1.sd_layout
    .leftSpaceToView(self.contentView,0)
    .rightSpaceToView(self.contentView,0)
    .heightIs(1)
    .bottomSpaceToView(self.contentView,0);
    
}

-(void)setTaskTouGaoModel:(TaskTouGaoModel *)model{
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.creatorPortrait] placeholderImage:[UIImage imageNamed:@"pic_man"]];
    self.iphoneLabel.text = model.creatorName;
    self.timeLabel.text = [NSDate dateWithTimeStamp:model.createdTimestamp dateFormat:@"yyyy-MM-dd"];
    self.sexImabeView.hidden = YES;
    if (model.isCheck == 1) {
        self.queryLabel.text = @"已查看";
    }
    if (model.isUsed == 1) {
        self.adoptLabl.text = @"已采纳";
    }else{
        
        self.adoptLabl.text = @"未采纳";
    }
    
    self.explainLabel.text = [NSString stringWithFormat:@"释义：%@",model.reason];
    self.explainLabel.attributedText = [ToolsHelper changeSomeText:model.reason inText:self.explainLabel.text withColor:COLOR_LightGray];
    self.nameLabel.text = [NSString stringWithFormat:@"名称：%@",model.brandName];
    self.nameLabel.attributedText = [ToolsHelper changeSomeText:model.brandName inText:self.nameLabel.text withColor:COLOR_LightGray];
}

@end
