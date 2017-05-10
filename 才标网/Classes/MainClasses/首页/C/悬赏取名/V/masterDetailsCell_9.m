//
//  masterDetailsCell_9.m
//  才标网
//
//  Created by baichun on 17/3/14.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "masterDetailsCell_9.h"

@implementation masterDetailsCell_9
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self drawView];
    }
    
    return self;
}

+ (masterDetailsCell_9 *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"masterDetailsCell_9";
    masterDetailsCell_9 *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[masterDetailsCell_9 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

-(void)drawView{
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont systemFontOfSize:15*UIRate];
    titleLabel.textColor = HEXCOLOR(0x999999);
    titleLabel.text = @"名称：辉格";
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:titleLabel];
    
    
    
    
    UIButton *registeredBtn = [[UIButton alloc]init];
    [registeredBtn addTarget:self action:@selector(registeredBtn:) forControlEvents:UIControlEventTouchUpInside];
    [registeredBtn setTitle:@"注册商标" forState:UIControlStateNormal];
    [registeredBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    registeredBtn.layer.cornerRadius = 10;
    
    
    [registeredBtn.layer setBorderWidth:1];//设置边界的宽度
    registeredBtn.layer.borderWidth = 1;
    registeredBtn.layer.borderColor = COLOR_ButtonBackGround_Blue.CGColor;
    [registeredBtn setTitleColor:COLOR_ButtonBackGround_Blue forState:UIControlStateNormal];
    registeredBtn.titleLabel.font = [UIFont systemFontOfSize:15*UIRate];
    registeredBtn.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:registeredBtn];
    
    
    
    UILabel *explainLabel = [[UILabel alloc] init];
    explainLabel.font = [UIFont systemFontOfSize:15*UIRate];
    explainLabel.textColor = HEXCOLOR(0x333333);
    explainLabel.text = @"释义：光辉有格调";
    explainLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:explainLabel];

    
    
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = COLOR_BackgroundColor;
    [self.contentView addSubview:lineView];
    
    UIView *lineView1 = [[UIView alloc]init];
    lineView1.backgroundColor = COLOR_BackgroundColor;
    [self.contentView addSubview:lineView1];
    
    
    UIView *lineView2 = [[UIView alloc]init];
    lineView2.backgroundColor = COLOR_BackgroundColor;
    [self.contentView addSubview:lineView2];
    
    self.saveBtn = [[UIButton alloc]init];
    [_saveBtn addTarget:self action:@selector(saveBtn) forControlEvents:UIControlEventTouchUpInside];
    [_saveBtn setTitle:@"我要提问" forState:UIControlStateNormal];
    _saveBtn.layer.cornerRadius = 8;
    //    [registeredBtn.layer setBorderWidth:1];//设置边界的宽度
    //    registeredBtn.layer.borderWidth = 1;
    [_saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _saveBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    _saveBtn.backgroundColor = COLOR_ButtonBackGround_Orange;
    [self.contentView addSubview:_saveBtn];
    

   
    self.nameLabel = [[UILabel alloc]init];
    _nameLabel.text = @"洋葱:";
    _nameLabel.textColor = COLOR_LightGray;
    _nameLabel.font = [UIFont systemFontOfSize:15*UIRate];
    [self.contentView addSubview:_nameLabel];
    
    self.answerLabel = [[UILabel alloc]init];
    _answerLabel.text = @"跟我生辰八字有啥关系？";
    _answerLabel.font = [UIFont systemFontOfSize:15*UIRate];
    [self.contentView addSubview:_answerLabel];
    
    
    
    titleLabel.sd_layout
    .leftSpaceToView(self.contentView,15*UIRate)
    .topSpaceToView(self.contentView,10*UIRate)
    .heightIs(30*UIRate)
    .widthIs(280*UIRate);
    
    registeredBtn.sd_layout
    .rightSpaceToView(self.contentView,10*UIRate)
    .topSpaceToView(self.contentView,10*UIRate)
    .heightIs(20*UIRate)
    .widthIs(70*UIRate);
    
    
    explainLabel.sd_layout
    .leftEqualToView(titleLabel)
    .topSpaceToView(titleLabel,5*UIRate)
    .heightIs(30*UIRate)
    .widthIs(300*UIRate);
    
    lineView.sd_layout
    .leftSpaceToView(self.contentView,0)
    .rightSpaceToView(self.contentView,0)
    .heightIs(1)
    .topSpaceToView(explainLabel,5*UIRate);
    
}

-(void)registeredBtn:(UIButton *)btn{
        
    
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
