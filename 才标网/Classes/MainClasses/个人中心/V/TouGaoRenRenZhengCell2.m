//
//  TouGaoRenRenZhengCell2.m
//  才标网
//
//  Created by 李强 on 2017/2/17.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "TouGaoRenRenZhengCell2.h"

@interface TouGaoRenRenZhengCell2 ()

@property (nonatomic, weak) UIButton *btn1;
@property (nonatomic, weak) UIButton *btn2;
@property (nonatomic, weak) UILabel *addressLabel;

@end

@implementation TouGaoRenRenZhengCell2


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self drawView];
    }
    
    return self;
}

+ (TouGaoRenRenZhengCell2 *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"TouGaoRenRenZhengCell2";
    TouGaoRenRenZhengCell2 *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[TouGaoRenRenZhengCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)drawView
{
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont systemFontOfSize:15*UIRate];
    titleLabel.textColor = HEXCOLOR(0x333333);
    titleLabel.text = @"地区";
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:titleLabel];
    
    UIButton *btn1 = [[UIButton alloc] init];
    btn1.backgroundColor = [UIColor whiteColor];
    [btn1 setTitle:@"选择省" forState:UIControlStateNormal];
    [btn1 setTitleColor:HEXCOLOR(0x999999) forState:UIControlStateNormal];
    [btn1 setImage:[UIImage imageNamed:@"icon_xiala2"] forState:UIControlStateNormal];
    btn1.titleLabel.font = [UIFont systemFontOfSize:15*UIRate];
    [btn1 addTarget:self action:@selector(btn1) forControlEvents:UIControlEventTouchUpInside];
    btn1.enabled = NO;
    btn1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.contentView addSubview:btn1];
    [btn1 layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight
                          imageTitleSpace:20];
    self.btn1 = btn1;
    
    UIButton *btn2 = [[UIButton alloc] init];
    btn2.backgroundColor = [UIColor whiteColor];
    [btn2 setTitle:@"选择市" forState:UIControlStateNormal];
    [btn2 setTitleColor:HEXCOLOR(0x999999) forState:UIControlStateNormal];
    [btn2 setImage:[UIImage imageNamed:@"icon_xiala2"] forState:UIControlStateNormal];
    btn2.titleLabel.font = [UIFont systemFontOfSize:15*UIRate];
    [btn2 addTarget:self action:@selector(btn1) forControlEvents:UIControlEventTouchUpInside];
    btn2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    btn2.enabled = NO;
    [self.contentView addSubview:btn2];
    [btn2 layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight
                          imageTitleSpace:20];
    self.btn2 = btn2;
    
    
    UILabel *addressLabel = [[UILabel alloc] init];
    addressLabel.font = [UIFont systemFontOfSize:14];
    addressLabel.textColor = HEXCOLOR(0x333333);
    addressLabel.text = @"江苏省   无锡市";
    addressLabel.textAlignment = NSTextAlignmentLeft;
    addressLabel.backgroundColor = [UIColor whiteColor];
    addressLabel.hidden = YES;
    [self.contentView addSubview:addressLabel];
    self.addressLabel = addressLabel;
    
    titleLabel.sd_layout
    .leftSpaceToView(self.contentView ,15)
    .topSpaceToView(self.contentView,0)
    .bottomSpaceToView(self.contentView,0)
    .widthIs(45);
    
    btn1.sd_layout
    .leftSpaceToView(titleLabel,15)
    .topSpaceToView(self.contentView,0)
    .bottomSpaceToView(self.contentView,0)
    .widthIs(60*UIRate);
    
    btn2.sd_layout
    .leftSpaceToView(btn1,15)
    .topSpaceToView(self.contentView,0)
    .bottomSpaceToView(self.contentView,0)
    .widthIs(60*UIRate);
    
    addressLabel.sd_layout
    .leftEqualToView(btn1)
    .rightSpaceToView(self.contentView,10)
    .topSpaceToView(self.contentView,0)
    .bottomSpaceToView(self.contentView,0);
}

- (void)setProvinceName:(NSString *)provinceName
{
    _provinceName = provinceName;
    
    if (provinceName)
    {
        [self.btn1 setTitle:provinceName forState:UIControlStateNormal];
    }
}

- (void)setCityName:(NSString *)cityName
{
    _cityName = cityName;
    
    if (cityName)
    {
        [self.btn2 setTitle:cityName forState:UIControlStateNormal];
    }
}

- (void)afterReZheng{
     [self.btn1 setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
     [self.btn2 setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
     self.btn1.enabled = NO;
     self.btn2.enabled = NO;
}

@end
