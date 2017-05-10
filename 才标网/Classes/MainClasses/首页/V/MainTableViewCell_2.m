//
//  MainTableViewCell_2.m
//  才标网
//
//  Created by 李强 on 2017/2/15.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "MainTableViewCell_2.h"

@interface MainTableViewCell_2 ()
@property (nonatomic, strong) NSString *searchStr;
@end

@implementation MainTableViewCell_2


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self drawView];
    }
    
    return self;
}

+ (MainTableViewCell_2 *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"MainTableViewCell_2";
    MainTableViewCell_2 *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[MainTableViewCell_2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)drawView
{
    UIButton *btn1 = [self creatButtonWithTitle:@"智能起名" image:@"home_zizhu" tag:MainTableViewCell_2BtnTypeSelf];
    UIButton *btn2 = [self creatButtonWithTitle:@"悬赏起名" image:@"home_xuanshang" tag:MainTableViewCell_2BtnTypeReward];
    UIButton *btn3 = [self creatButtonWithTitle:@"大师起名" image:@"home_dashi" tag:MainTableViewCell_2BtnTypeMaster];

    UIView *dividerView = [[UIView alloc] init];
    dividerView.backgroundColor = COLOR_BackgroundColor;
    
    
    [self.contentView sd_addSubviews:@[btn1, btn2, btn3,dividerView]];
    
    btn2.sd_layout
    .centerXEqualToView(self.contentView)
    .topSpaceToView(self.contentView,15*UIRate)
    .widthIs(80*UIRate)
    .heightIs(80*UIRate);
    
    btn1.sd_layout
    .leftSpaceToView(self.contentView,25*UIRate)
    .topEqualToView(btn2)
    .widthIs(80*UIRate)
    .heightIs(80*UIRate);
    
    btn3.sd_layout
    .rightSpaceToView(self.contentView,25*UIRate)
    .topEqualToView(btn2)
    .heightIs(80*UIRate)
    .widthIs(80*UIRate);
    
    [btn1 layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop
                               imageTitleSpace:10*UIRate];
    
    [btn2 layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop
                               imageTitleSpace:10*UIRate];
    
    [btn3 layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop
                               imageTitleSpace:10*UIRate];
    
    dividerView.sd_layout
    .leftEqualToView(self.contentView)
    .bottomEqualToView(self.contentView)
    .widthRatioToView(self.contentView,1)
    .heightIs(15*UIRate);
}

- (UIButton *)creatButtonWithTitle:(NSString *)title image:(NSString *)imageName tag:(MainTableViewCell_2BtnType)tag
{
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:COLOR_Black forState:UIControlStateNormal];
    button.titleLabel.font = SYSTEM_FONT_(13*UIRate);
    button.tag = tag;
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

//action

- (void)textFieldAction:(UITextField *)textField{
    
    self.searchStr = textField.text;
    
}

- (void)buttonAction:(UIButton *)button{
    if (self.delegate){
        [self.delegate cell_2ClickButtonWithTag:button.tag andStr:self.searchStr];
    }
}


@end
