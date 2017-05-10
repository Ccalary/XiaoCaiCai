//
//  RenWuXiangQingCell_6.m
//  才标网
//
//  Created by baichun on 17/3/18.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "RenWuXiangQingCell_6.h"
#import "UserHelper.h"
@implementation RenWuXiangQingCell_6
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self drawView];
    }
    
    return self;
}

+ (RenWuXiangQingCell_6 *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"RenWuXiangQingCell_6";
    RenWuXiangQingCell_6 *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[RenWuXiangQingCell_6 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

-(void)drawView{
    
    self.iconImageView = [[UIImageView alloc] init];
    _iconImageView.image = [UIImage imageNamed:@"pic_man"];
    [self.contentView addSubview:_iconImageView];
    
    self.iphoneLabel = [[UILabel alloc]init];
    _iphoneLabel.font = [UIFont systemFontOfSize:14];
    _iphoneLabel.textColor = HEXCOLOR(0x333333);
    _iphoneLabel.text = @"187****1003";
    _iphoneLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_iphoneLabel];
    
    self.sexImabeView = [[UIImageView alloc]init];
    _sexImabeView.image = [UIImage imageNamed:@"details_man"];
    [self.contentView addSubview:_sexImabeView];
    
    self.timeLabel = [[UILabel alloc]init];
    _timeLabel.font = [UIFont systemFontOfSize:10];
    _timeLabel.textColor = HEXCOLOR(0x666666);
    _timeLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_timeLabel];
    
    self.queryLabel = [[UILabel alloc]init];
    _queryLabel.font = [UIFont systemFontOfSize:10];
    _queryLabel.textColor = COLOR_Blue;
    [self.contentView addSubview:_queryLabel];

    
    UIView *linewView = [[UIView alloc]init];
    linewView.backgroundColor = COLOR_BackgroundColor;
    [self.contentView addSubview:linewView];
    
    
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
    .widthIs(ScreenWidth/2);
    
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
    .heightIs(1)
    .bottomSpaceToView(self.contentView,0);
    
}
-(void)setTaskTouGaoModel:(TaskTouGaoModel *)model{
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.creatorPortrait] placeholderImage:[UIImage imageNamed:@"pic_man"]];
    
    self.iphoneLabel.text = model.creatorName?:@"";
    
    self.timeLabel.text = [NSDate dateWithTimeStamp:model.createdTimestamp dateFormat:@"yyyy-MM-dd"];
     self.sexImabeView.hidden = YES;
    
    if ((model.isCheck = 1)) {
        self.queryLabel.text = @"已查看";
    }else{
        self.queryLabel.text = @"";
    }
}
@end
