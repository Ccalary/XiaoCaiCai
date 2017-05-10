//
//  PleaseNameTableViewCell.m
//  才标网
//
//  Created by caohouhong on 17/3/22.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "PleaseNameTableViewCell.h"

@implementation PleaseNameTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self drawView];
    }
    
    return self;
}

+ (PleaseNameTableViewCell *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"PleaseNameTableViewCell";
    PleaseNameTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[PleaseNameTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

-(void)drawView{
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:15*UIRate];
    _titleLabel.textColor = COLOR_Black;
    [self.contentView addSubview:_titleLabel];
    
    _mTextField = [[UITextField alloc]init];
    _mTextField.font = [UIFont systemFontOfSize:15*UIRate];
    _mTextField.textColor = COLOR_Gray;
    [self.contentView addSubview:_mTextField];
    
    _selectedButton = [[UIButton alloc] init];
    [_selectedButton setTitle:@"请选择" forState:UIControlStateNormal];
    [_selectedButton setImage:[UIImage imageNamed:@"icon_xiala2"] forState:UIControlStateNormal];
    _selectedButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_selectedButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:5];
    [_selectedButton setTitleColor:COLOR_Gray forState:UIControlStateNormal];
    _selectedButton.titleLabel.font = SYSTEM_FONT_(15*UIRate);
    [self.contentView addSubview:_selectedButton];
    
    UIView *dividerLine1 = [[UIView alloc] init];
    dividerLine1.backgroundColor = COLOR_BackgroundColor;
    [self.contentView addSubview:dividerLine1];
    
    _titleLabel.sd_layout
    .leftSpaceToView(self.contentView,15*UIRate)
    .centerYEqualToView(self.contentView)
    .widthIs(80*UIRate)
    .heightIs(20*UIRate);
    
    _mTextField.sd_layout
    .leftSpaceToView(_titleLabel,5*UIRate)
    .centerYEqualToView(self.contentView)
    .widthIs(ScreenWidth - 120*UIRate)
    .heightRatioToView(self.contentView,1);
    
    _selectedButton.sd_layout
    .leftSpaceToView(_titleLabel,8*UIRate)
    .centerYEqualToView(self.contentView)
    .widthIs(ScreenWidth - 120*UIRate)
    .heightRatioToView(self.contentView,1);
    
    dividerLine1.sd_layout
    .leftEqualToView(self.contentView)
    .bottomEqualToView(self.contentView)
    .widthRatioToView(self.contentView,1)
    .heightIs(1);
}

- (void)reloadButtonFrame:(UIButton *)button withTitle:(NSString *)title{
    [button setTitle:title forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"icon_xiala2"] forState:UIControlStateNormal];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [button layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:5];
}
@end
