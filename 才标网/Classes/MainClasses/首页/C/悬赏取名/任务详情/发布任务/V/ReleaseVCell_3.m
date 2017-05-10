//
//  ReleaseVCell_3.m
//  才标网
//
//  Created by baichun on 17/3/14.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "ReleaseVCell_3.h"

@implementation ReleaseVCell_3
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self drawView];
    }
    
    return self;
}

+ (ReleaseVCell_3 *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"ReleaseVCell_3";
    ReleaseVCell_3 *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[ReleaseVCell_3 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

-(void)drawView{
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.font = [UIFont systemFontOfSize:15*UIRate];
    titleLabel.textColor = COLOR_Black;
    titleLabel.text = @"分类";
    [self.contentView addSubview:titleLabel];
    
    _chooseBtn = [[UIButton alloc]init];
    [_chooseBtn addTarget:self action:@selector(chooseBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_chooseBtn setTitle:@"请选择" forState:UIControlStateNormal];
    _chooseBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [_chooseBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight
                                 imageTitleSpace:5];

    [_chooseBtn setImage:[UIImage imageNamed:@"icon_xiala2"] forState:UIControlStateNormal];
    
    _chooseBtn.titleLabel.font = [UIFont systemFontOfSize:15*UIRate];
    [_chooseBtn setTitleColor:COLOR_Gray forState:UIControlStateNormal];
    [self.contentView addSubview:_chooseBtn];
    
    UIButton *classificationBtn = [[UIButton alloc]init];
    [classificationBtn addTarget:self action:@selector(classificationBtn:) forControlEvents:UIControlEventTouchUpInside];
    [classificationBtn setTitle:@"分类查询" forState:UIControlStateNormal];
    classificationBtn.titleLabel.font = [UIFont systemFontOfSize:15*UIRate];
    [classificationBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [classificationBtn setTitleColor:COLOR_OrangeRed forState:UIControlStateNormal];
    [self.contentView addSubview:classificationBtn];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = COLOR_BackgroundColor;
    [self.contentView addSubview:lineView];
    
    UIView *dividerLine1 = [[UIView alloc] init];
    dividerLine1.backgroundColor = COLOR_BackgroundColor;
    [self.contentView addSubview:dividerLine1];
    
    titleLabel.sd_layout
    .leftSpaceToView(self.contentView,15*UIRate)
    .centerYEqualToView(self.contentView)
    .widthIs(80*UIRate)
    .heightIs(30*UIRate);
    
    classificationBtn.sd_layout
    .rightSpaceToView(self.contentView,0)
    .centerYEqualToView(self.contentView)
    .widthIs(100*UIRate)
    .heightRatioToView(self.contentView,1);
    
    lineView.sd_layout
    .leftEqualToView(classificationBtn)
    .topSpaceToView(self.contentView,5)
    .bottomSpaceToView(self.contentView,5)
    .widthIs(1);
    
    _chooseBtn.sd_layout
    .rightSpaceToView(lineView,7*UIRate)
    .centerYEqualToView(self.contentView)
    .widthIs( ScreenWidth - 200*UIRate)
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
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [button layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:5];
}


-(void)classificationBtn:(UIButton *)btn{
    self.block0(btn);
    
}
-(void)chooseBtn:(UIButton *)btn{
    self.block1(btn);
    
}
@end
