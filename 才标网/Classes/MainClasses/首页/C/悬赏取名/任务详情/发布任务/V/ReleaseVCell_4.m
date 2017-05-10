//
//  ReleaseVCell_4.m
//  才标网
//
//  Created by baichun on 17/3/14.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "ReleaseVCell_4.h"

@implementation ReleaseVCell_4
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self drawView];
    }
    
    return self;
}

+ (ReleaseVCell_4 *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"ReleaseVCell_4";
    ReleaseVCell_4 *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[ReleaseVCell_4 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}


-(void)drawView{
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.font = [UIFont systemFontOfSize:15*UIRate];
    titleLabel.textColor = COLOR_Black;
    titleLabel.text = @"行业";
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:titleLabel];
    
    _chooseBtn = [[UIButton alloc]init];
    [_chooseBtn addTarget:self action:@selector(chooseBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_chooseBtn setTitle:@"请选择" forState:UIControlStateNormal];
    [_chooseBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight
                               imageTitleSpace:5];
    _chooseBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
      [_chooseBtn setImage:[UIImage imageNamed:@"icon_xiala2"] forState:UIControlStateNormal];
    _chooseBtn.titleLabel.font = [UIFont systemFontOfSize:15*UIRate];
    [_chooseBtn setTitleColor:COLOR_Gray forState:UIControlStateNormal];
    _chooseBtn.tag = 1024;
    [self.contentView addSubview:_chooseBtn];
    
    UIView *dividerLine1 = [[UIView alloc] init];
    dividerLine1.backgroundColor = COLOR_BackgroundColor;
    [self.contentView addSubview:dividerLine1];
    
    titleLabel.sd_layout
    .leftSpaceToView(self.contentView,15*UIRate)
    .centerYEqualToView(self.contentView)
    .widthIs(80*UIRate)
    .heightIs(30*UIRate);
    
    _chooseBtn.sd_layout
    .rightSpaceToView(self.contentView,25*UIRate)
    .centerYEqualToView(self.contentView)
    .widthIs(ScreenWidth - 120*UIRate)
    .heightIs(30*UIRate);
    
    dividerLine1.sd_layout
    .leftEqualToView(self.contentView)
    .bottomEqualToView(self.contentView)
    .widthRatioToView(self.contentView,1)
    .heightIs(1);
}

- (void)reloadButtonFrame:(UIButton *)button withTitle:(NSString *)title{
    [button setTitle:title forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"icon_xiala2"] forState:UIControlStateNormal];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [button layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:5];
}

-(void)chooseBtn:(UIButton *)btn{
    
    self.block0(btn);
}
@end
