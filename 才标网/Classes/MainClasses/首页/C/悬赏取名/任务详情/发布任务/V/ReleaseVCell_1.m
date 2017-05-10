//
//  ReleaseVCell_1.m
//  才标网
//
//  Created by baichun on 17/3/14.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "ReleaseVCell_1.h"

@implementation ReleaseVCell_1

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self drawView];
    }
    
    return self;
}

+ (ReleaseVCell_1 *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"ReleaseVCell_1";
    ReleaseVCell_1 *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[ReleaseVCell_1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}


-(void)drawView{
    UILabel *typeLabel = [[UILabel alloc]init];
    typeLabel.font = [UIFont systemFontOfSize:15*UIRate];
    typeLabel.textColor = COLOR_Black;
    typeLabel.text = @"类型";
    [self.contentView addSubview:typeLabel];
    
    UIView *dividerLine1 = [[UIView alloc] init];
    dividerLine1.backgroundColor = COLOR_BackgroundColor;
    [self.contentView addSubview:dividerLine1];
    
    self.rademarkBtn = [[UIButton alloc]init];
    [self.rademarkBtn addTarget:self action:@selector(rademarkBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.rademarkBtn setTitle:@"商标起名" forState:UIControlStateNormal];
    [self.rademarkBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.rademarkBtn setImage:[UIImage imageNamed:@"btn_weichaxun_n"] forState:UIControlStateNormal];
    [self.rademarkBtn setImage:[UIImage imageNamed:@"btn_weichaxun_s"] forState:UIControlStateSelected];
    [self.rademarkBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft
                          imageTitleSpace:5];
    self.rademarkBtn.titleLabel.font = [UIFont systemFontOfSize:14*UIRate];
    self.rademarkBtn.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.rademarkBtn];

    self.companyBtn = [[UIButton alloc]init];
    [self.companyBtn  addTarget:self action:@selector(companyBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.companyBtn  setTitle:@"公司起名" forState:UIControlStateNormal];
    [self.companyBtn setImage:[UIImage imageNamed:@"btn_weichaxun_n"] forState:UIControlStateNormal];
    [self.companyBtn setImage:[UIImage imageNamed:@"btn_weichaxun_s"] forState:UIControlStateSelected];
    [self.companyBtn  setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.companyBtn  layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft
                                 imageTitleSpace:5];
    self.companyBtn .titleLabel.font = [UIFont systemFontOfSize:14*UIRate];
    self.companyBtn .backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.companyBtn];

    
   typeLabel.sd_layout
    .leftSpaceToView(self.contentView,15)
    .centerYEqualToView(self.contentView)
    .widthIs(40*UIRate)
    .heightIs(30*UIRate);
    
    _rademarkBtn.sd_layout
    .leftSpaceToView(typeLabel,130*UIRate)
    .centerYEqualToView(self.contentView)
    .widthIs(80*UIRate)
    .heightIs(40*UIRate);
    
    _companyBtn.sd_layout
    .rightSpaceToView(self.contentView,15*UIRate)
    .topEqualToView(_rademarkBtn)
    .bottomEqualToView(_rademarkBtn)
    .widthIs(80*UIRate);
    
    dividerLine1.sd_layout
    .leftEqualToView(self.contentView)
    .bottomEqualToView(self.contentView)
    .widthRatioToView(self.contentView,1)
    .heightIs(1);
}

-(void)rademarkBtn:(UIButton *)btn{
    
    if (self.block0){
        self.block0();//商标起名
    }
}

-(void)companyBtn:(UIButton *)btn{

    if (self.block1){
        self.block1();//公司起名
    }
}

@end
