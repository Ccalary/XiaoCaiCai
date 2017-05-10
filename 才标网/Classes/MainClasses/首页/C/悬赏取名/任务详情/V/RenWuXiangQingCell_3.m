//
//  RenWuXiangQingCell_3.m
//  才标网
//
//  Created by baichun on 17/3/13.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "RenWuXiangQingCell_3.h"
#import "ToolsHelper.h"
@implementation RenWuXiangQingCell_3

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self drawView];
    }
    
    return self;
}

+ (RenWuXiangQingCell_3 *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"RenWuXiangQingCell_3";
    RenWuXiangQingCell_3 *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[RenWuXiangQingCell_3 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

-(void)drawView{
    self.iconImageView = [[UIImageView alloc] init];
    _iconImageView.image = [UIImage imageNamed:@"pic_man"];
    [self.contentView addSubview:_iconImageView];
    
    self.iphoneLabel = [[UILabel alloc]init];
    _iphoneLabel.font = [UIFont systemFontOfSize:15*UIRate];
    _iphoneLabel.textColor = HEXCOLOR(0x333333);
    [self.contentView addSubview:_iphoneLabel];
    
    UIImageView *sexImabeView = [[UIImageView alloc]init];
    sexImabeView.image = [UIImage imageNamed:@"details_man"];
    sexImabeView.hidden = YES;
    [self.contentView addSubview:sexImabeView];
    
    self.timeLabel = [[UILabel alloc]init];
    _timeLabel.font = [UIFont systemFontOfSize:10*UIRate];
    _timeLabel.textColor = HEXCOLOR(0x666666);
    [self.contentView addSubview:_timeLabel];
    
    self.queryLabel = [[UILabel alloc]init];
    _queryLabel.font = [UIFont systemFontOfSize:13*UIRate];
    _queryLabel.textColor = COLOR_LOGIN;
    _queryLabel.textAlignment = NSTextAlignmentCenter;
    _queryLabel.text = @"已采纳";
    [self.contentView addSubview:_queryLabel];
    
    self.trademarkBtn = [[UIButton alloc]init];
    _trademarkBtn.titleLabel.font = [UIFont systemFontOfSize:15*UIRate];
    [_trademarkBtn setTitle:@"商标注册" forState:UIControlStateNormal];
    _trademarkBtn.backgroundColor = COLOR_ButtonBackGround_Blue;
    
    [_trademarkBtn addTarget:self action:@selector(trademark) forControlEvents:UIControlEventTouchUpInside];
    
    [_trademarkBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [[_trademarkBtn layer] setMasksToBounds:YES];
    [self.contentView addSubview:_trademarkBtn];
    
    self.trademarkBtn1 = [[UIButton alloc]init];
    _trademarkBtn1.titleLabel.font = [UIFont systemFontOfSize:15*UIRate];
    [_trademarkBtn1 setTitle:@"采 纳" forState:UIControlStateNormal];
    _trademarkBtn1.backgroundColor = COLOR_Orange;
    
    [_trademarkBtn1 addTarget:self action:@selector(adopt) forControlEvents:UIControlEventTouchUpInside];
    [_trademarkBtn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [[_trademarkBtn1 layer] setMasksToBounds:YES];
    [self.contentView addSubview:_trademarkBtn1];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = COLOR_BackgroundColor;
    [self.contentView addSubview:lineView];
    
   
    self.nameLabel = [[UILabel alloc]init];
    _nameLabel.font = [UIFont systemFontOfSize:15*UIRate];
    _nameLabel.textColor = HEXCOLOR(0x333333);
    _nameLabel.text = @"名称：";
    _nameLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_nameLabel];
    
    self.adoptBtn = [[UIButton alloc]init];
    [_adoptBtn setImage:[UIImage imageNamed:@"detaile_jubao"] forState:UIControlStateNormal];
    [_adoptBtn addTarget:self action:@selector(report) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_adoptBtn];
    
    
    self.explainLabel = [[UILabel alloc]init];
    _explainLabel.font = [UIFont systemFontOfSize:15*UIRate];
    _explainLabel.textColor = HEXCOLOR(0x333333);
    _explainLabel.text = @"释义：";
    [self.contentView addSubview:_explainLabel];
    
    UIView *lineView1 = [[UIView alloc]init];
    lineView1.backgroundColor = COLOR_BackgroundColor;
    [self.contentView addSubview:lineView1];
    
    UIView *lineView2 = [[UIView alloc]init];
    lineView2.backgroundColor = COLOR_BackgroundColor;
    [self.contentView addSubview:lineView2];
    
    _iconImageView.sd_layout
    .leftSpaceToView(self.contentView,10*UIRate)
    .topSpaceToView(self.contentView,10*UIRate)
    .heightIs(40*UIRate)
    .widthIs(40*UIRate);
    _iconImageView.sd_cornerRadiusFromWidthRatio = @(0.5);

    _iphoneLabel.sd_layout
    .leftSpaceToView(_iconImageView,10*UIRate)
    .topEqualToView(_iconImageView)
    .heightIs(20*UIRate)
    .widthIs(150*UIRate);
    
    sexImabeView.sd_layout
    .leftSpaceToView(_iphoneLabel,5*UIRate)
    .topEqualToView(_iphoneLabel)
    .heightIs(15*UIRate)
    .widthIs(15*UIRate);
    
    _timeLabel.sd_layout
    .leftEqualToView(_iphoneLabel)
    .bottomEqualToView(_iconImageView)
    .topSpaceToView(_iphoneLabel,5*UIRate)
    .widthIs(100*UIRate);
    
    _queryLabel.sd_layout
    .leftSpaceToView(_timeLabel,5*UIRate)
    .bottomEqualToView(_timeLabel)
    .topEqualToView(_timeLabel)
    .widthIs(50*UIRate);
    
    _trademarkBtn.sd_layout
    .rightSpaceToView(self.contentView,20*UIRate)
    .topSpaceToView(self.contentView,15*UIRate)
    .widthIs(80*UIRate)
    .heightIs(25*UIRate);
    
     _trademarkBtn.sd_cornerRadiusFromHeightRatio = @(0.5);
    
    _trademarkBtn1.sd_layout
    .rightSpaceToView(self.contentView,20*UIRate)
    .topSpaceToView(self.contentView,15*UIRate)
    .widthIs(80*UIRate)
    .heightIs(25*UIRate);
    
    _trademarkBtn1.sd_cornerRadiusFromHeightRatio = @(0.5);
    
    lineView.sd_layout
    .leftSpaceToView(self.contentView,0)
    .rightSpaceToView(self.contentView,0)
    .topSpaceToView(_iconImageView,15*UIRate)
    .heightIs(1);
    
    _nameLabel.sd_layout
    .leftSpaceToView(self.contentView,15*UIRate)
    .topSpaceToView(lineView,5*UIRate)
    .widthIs(200*UIRate)
    .heightIs(20*UIRate);
    
    _adoptBtn.sd_layout
    .rightSpaceToView(self.contentView,20*UIRate)
    .topSpaceToView(lineView,5*UIRate)
    .widthIs(20*UIRate)
    .heightIs(20*UIRate);
    
    
    lineView1.sd_layout
    .leftSpaceToView(self.contentView,0)
    .rightSpaceToView(self.contentView,0)
    .topSpaceToView(_nameLabel,5)
    .heightIs(1);
    
    _explainLabel.sd_layout
    .leftSpaceToView(self.contentView,15*UIRate)
    .rightSpaceToView(self.contentView,0)
    .topSpaceToView(lineView1,5)
    .heightIs(20*UIRate);
    
    lineView2.sd_layout
    .leftSpaceToView(self.contentView,0)
    .rightSpaceToView(self.contentView,0)
    .topSpaceToView(_explainLabel,10*UIRate)
    .heightIs(20*UIRate);
    
}

-(void)setTaskTouGao:(TaskTouGaoModel *)model isXuanShangFenQian:(int)isFenQian{
    
    _model = model;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.creatorPortrait] placeholderImage:[UIImage imageNamed:@"pic_man"]];
    self.iphoneLabel.text = model.creatorName;
    self.timeLabel.text = [NSDate dateWithTimeStamp:model.createdTimestamp dateFormat:@"yyyy-MM-dd"];
   
            if (isFenQian == 1) {
        
           if (model.isUsed == 1) {
               _queryLabel.text = @"已采纳";
               _queryLabel.textColor = COLOR_LOGIN;

                //商标注册不隐藏
                self.trademarkBtn.hidden = NO;
               //采纳隐藏
               self.trademarkBtn1.hidden = YES;
           }else{
               self.queryLabel.textColor = COLOR_Blue;
               self.queryLabel.text = @"已查看";
               self.trademarkBtn.hidden = YES;
               self.trademarkBtn1.hidden = YES;
           }
              
          }else{
              
              self.trademarkBtn1.hidden = NO;
              self.trademarkBtn.hidden = YES;
              self.queryLabel.text = @"已查看";
              self.queryLabel.textColor = COLOR_Blue;
          }
    
   
    
    self.explainLabel.text = [NSString stringWithFormat:@"释义：%@",model.reason];
    self.explainLabel.attributedText = [ToolsHelper changeSomeText:model.reason inText:self.explainLabel.text withColor:COLOR_LightGray];
    
    
    self.nameLabel.text = [NSString stringWithFormat:@"名称：%@",model.brandName];
    self.nameLabel.attributedText = [ToolsHelper changeSomeText:model.brandName inText:self.nameLabel.text withColor:COLOR_LightGray];
}


-(void)trademark{
    
    //点击商标注册
    if (self.trademarblock){
        self.trademarblock(_model.brandName);
    }
}

-(void)adopt{
    
    //点击采纳
    if (self.adoptblock){
        self.adoptblock(_model.touGaoId);
    }
}


-(void)report{
    
    //点击举报
    if (self.reporblock){
        self.reporblock(self.model.touGaoId, self.model.brandName);
    }
}
@end
