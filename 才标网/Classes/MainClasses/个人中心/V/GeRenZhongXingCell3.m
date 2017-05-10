//
//  GeRenZhongXingCell3.m
//  才标网
//
//  Created by 李强 on 2017/2/17.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "GeRenZhongXingCell3.h"

@interface GeRenZhongXingCell3()
@property (nonatomic, weak) UILabel *lab1;
@property (nonatomic, weak) UILabel *lab2;
@property (nonatomic, weak) UILabel *lab3;
@property (nonatomic, weak) UILabel *lab4;
@end

@implementation GeRenZhongXingCell3


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self drawView];
    }
    
    return self;
}

+ (GeRenZhongXingCell3 *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"GeRenZhongXingCell3";
    GeRenZhongXingCell3 *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[GeRenZhongXingCell3 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)drawView
{
    UIButton *btn1 = [[UIButton alloc] init];
    btn1.backgroundColor = [UIColor whiteColor];
    [btn1 setTitle:@"悬赏任务" forState:UIControlStateNormal];
    [btn1 setTitleColor:COLOR_Black forState:UIControlStateNormal];
    [btn1 setImage:[UIImage imageNamed:@"uc_reward_48x48"] forState:UIControlStateNormal];
    btn1.titleLabel.font = SYSTEM_FONT_(13*UIRate);
    btn1.tag = 60000;
    [btn1 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:btn1];
    
    UIButton *btn2 = [[UIButton alloc] init];
    btn2.backgroundColor = [UIColor whiteColor];
    [btn2 setTitle:@"我的投稿" forState:UIControlStateNormal];
    [btn2 setTitleColor:COLOR_Black forState:UIControlStateNormal];
    [btn2 setImage:[UIImage imageNamed:@"uc_letter_48x48"] forState:UIControlStateNormal];
    btn2.titleLabel.font = SYSTEM_FONT_(13*UIRate);
    btn2.tag = 60001;
    [btn2 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:btn2];
    
    UIButton *btn3 = [[UIButton alloc] init];
    btn3.backgroundColor = [UIColor whiteColor];
    [btn3 setTitle:@"大师任务" forState:UIControlStateNormal];
    [btn3 setTitleColor:COLOR_Black forState:UIControlStateNormal];
    [btn3 setImage:[UIImage imageNamed:@"uc_task_48x48"] forState:UIControlStateNormal];
    btn3.titleLabel.font = SYSTEM_FONT_(13*UIRate);
    btn3.tag = 60002;
    [btn3 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:btn3];
    
    UIButton *btn4 = [[UIButton alloc] init];
    btn4.backgroundColor = [UIColor whiteColor];
    [btn4 setTitle:@"我是大师" forState:UIControlStateNormal];
    [btn4 setTitleColor:COLOR_Black forState:UIControlStateNormal];
    [btn4 setImage:[UIImage imageNamed:@"uc_master_48x48"] forState:UIControlStateNormal];
    btn4.titleLabel.font = SYSTEM_FONT_(13*UIRate);
    btn4.tag = 60003;
    [btn4 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:btn4];
    
    UILabel *lab1 = [self createLabel];
    lab1.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:lab1];
    self.lab1 = lab1;
    
    UILabel *lab2 = [self createLabel];
    lab2.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:lab2];
    self.lab2 = lab2;
    
    UILabel *lab3 = [self createLabel];
    lab3.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:lab3];
    self.lab3 = lab3;
    
    UILabel *lab4 = [self createLabel];
    lab4.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:lab4];
    self.lab4 = lab4;
    
    CGFloat space = 3.0;
    
    btn1.sd_layout
    .leftSpaceToView(self.contentView,0)
    .centerYEqualToView(self.contentView)
    .widthIs(ScreenWidth/4)
    .heightIs(80*UIRate);
    
    [btn1 layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop
                          imageTitleSpace:space];
    
    lab1.sd_layout
    .centerXEqualToView(btn1).offset(25*UIRate)
    .topEqualToView(btn1).offset (15*UIRate)
    .widthIs(15*UIRate).heightIs(15*UIRate);
    lab1.sd_cornerRadiusFromWidthRatio = @(0.5);
    
    btn2.sd_layout
    .leftSpaceToView(btn1,0)
    .centerYEqualToView(self.contentView)
    .widthIs(ScreenWidth/4)
    .heightIs(80*UIRate);
    
    [btn2 layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop
                          imageTitleSpace:space];
    
    lab2.sd_layout
    .centerXEqualToView(btn2).offset(25*UIRate)
    .topEqualToView(lab1)
    .widthIs(15).heightIs(15);
    lab2.sd_cornerRadiusFromWidthRatio = @(0.5);
    
    btn3.sd_layout
    .leftSpaceToView(btn2,0)
    .centerYEqualToView(self.contentView)
    .widthIs(ScreenWidth/4)
    .heightIs(80*UIRate);
    
    [btn3 layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop
                          imageTitleSpace:space];

    
    lab3.sd_layout
    .centerXEqualToView(btn3).offset(25*UIRate)
    .topEqualToView(lab1)
    .widthIs(15*UIRate).heightIs(15*UIRate);
    lab3.sd_cornerRadiusFromWidthRatio = @(0.5);
    
    btn4.sd_layout
    .leftSpaceToView(btn3,0)
    .centerYEqualToView(self.contentView)
    .widthIs(ScreenWidth/4)
    .heightIs(80*UIRate);
    
    [btn4 layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop
                          imageTitleSpace:space];
    
    lab4.sd_layout
    .centerXEqualToView(btn4).offset(25*UIRate)
    .topEqualToView(lab1)
    .widthIs(15*UIRate).heightIs(15*UIRate);
    lab4.sd_cornerRadiusFromWidthRatio = @(0.5);
    
    [self addUnderlineWithLeftMargin:0 rightMargin:0 lineHeight:0.5];
}


-(UILabel *)createLabel {
    UILabel *label = [[UILabel alloc]init];
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = [UIColor whiteColor];
    label.layer.borderColor = [UIColor redColor].CGColor;
    label.layer.borderWidth = 1;
    label.textAlignment = NSTextAlignmentCenter;
    label.hidden = YES;
    return label;
}


- (void)buttonAction:(UIButton *)btn
{
    int messageNum = 0;
    switch (btn.tag) {
        case 60000://悬赏任务
            messageNum = self.model.xuanShangTaskMsgNum;
            break;
        case 60001://我的投稿
            messageNum = self.model.myTouGaoMsgNum;
            break;
        case 60002://大师任务
            messageNum = self.model.daShiTaskMsgNum;
            break;
        case 60003://我是大师
            messageNum = self.model.iAmDaShiMsgNum;
            break;
        default:
            break;
    }
    
    if (self.delegate){
        [self.delegate GeRenZhongXingCell3ClickButtonWithTag:(int)btn.tag andMsgNum:messageNum];
    }
}

- (void)setModel:(ModelMemberExtend *)model{
    
    _model = model;
    
    self.lab1.text = [NSString stringWithFormat:@"%i",model.xuanShangTaskMsgNum];
    //大于0则显示
    self.lab1.hidden = (model.xuanShangTaskMsgNum > 0) ? NO : YES;
    
    self.lab2.text = [NSString stringWithFormat:@"%i",model.myTouGaoMsgNum];
    self.lab2.hidden = (model.myTouGaoMsgNum > 0) ? NO : YES;
    
    self.lab3.text = [NSString stringWithFormat:@"%i",model.daShiTaskMsgNum];
    self.lab3.hidden = (model.daShiTaskMsgNum > 0) ? NO : YES;
    
    self.lab4.text = [NSString stringWithFormat:@"%i",model.iAmDaShiMsgNum];
    self.lab4.hidden = (model.iAmDaShiMsgNum > 0) ? NO : YES;
}
@end
