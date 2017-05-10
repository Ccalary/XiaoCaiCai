//
//  BrandMainTopView.m
//  才标网
//
//  Created by caohouhong on 17/3/15.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "BrandMainTopView.h"

@implementation BrandMainTopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self){
        self.backgroundColor = COLOR_BackgroundColor;
        [self drawView];
    }
    return self;
}

- (void)drawView{
    CGFloat space = 5.0;
    
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor whiteColor];
    [self addSubview:backView];
    
    UIButton *searchBtn = [[UIButton alloc] init];
    [searchBtn setImage:[UIImage imageNamed:@"brand_chaxun"] forState:UIControlStateNormal];
    [searchBtn setTitle:@"商标购买" forState:UIControlStateNormal];
    searchBtn.titleLabel.font = SYSTEM_FONT_(15*UIRate);
   
    [searchBtn setTitleColor:COLOR_darkGray forState:UIControlStateNormal];
    [searchBtn setBackgroundColor:[UIColor whiteColor]];
    searchBtn.tag = BrandMainTopViewBtnTypeSearch;
    [searchBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:searchBtn];
    
    UIButton *categoryBtn = [[UIButton alloc] init];
    [categoryBtn setTitle:@"商品分类" forState:UIControlStateNormal];
    categoryBtn.titleLabel.font = SYSTEM_FONT_(15*UIRate);
    [categoryBtn setImage:[UIImage imageNamed:@"brand_fenlei"] forState:UIControlStateNormal];
    [categoryBtn setTitleColor:COLOR_darkGray forState:UIControlStateNormal];
    categoryBtn.tag = BrandMainTopViewBtnTypeCategory;
    
   
    [categoryBtn setBackgroundColor:[UIColor whiteColor]];
    [categoryBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:categoryBtn];
    
    UIButton *saleBtn = [[UIButton alloc] init];
    [saleBtn setTitle:@"出售商标" forState:UIControlStateNormal];
    saleBtn.titleLabel.font = SYSTEM_FONT_(15*UIRate);
    [saleBtn setImage:[UIImage imageNamed:@"brand_chushou"] forState:UIControlStateNormal];
    [saleBtn setTitleColor:COLOR_darkGray forState:UIControlStateNormal];
    saleBtn.tag = BrandMainTopViewBtnTypeSale;
    [saleBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [saleBtn setBackgroundColor:[UIColor whiteColor]];
    [backView addSubview:saleBtn];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = COLOR_BackgroundColor;
    [backView addSubview:lineView];
    
    CGFloat width = (ScreenWidth - 24*UIRate)/3.0;
    backView.sd_layout
    .leftSpaceToView(self,0)
    .rightSpaceToView(self,0)
    .topSpaceToView(self,0)
    .bottomSpaceToView(self,0);
    
    searchBtn.sd_layout
    .leftSpaceToView(backView,10*UIRate)
    .topSpaceToView(backView,10*UIRate)
    .widthIs(width)
    .heightIs(95*UIRate);
    [searchBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:space];
    
    categoryBtn.sd_layout
    .leftSpaceToView(searchBtn,0)
    .centerYEqualToView(searchBtn)
    .widthIs(width)
    .heightIs(95*UIRate);
     [categoryBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:space];
    
    saleBtn.sd_layout
    .leftSpaceToView(categoryBtn,0)
    .centerYEqualToView(searchBtn)
    .widthIs(width)
    .heightIs(95*UIRate);
    [saleBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:space];
    
    lineView.sd_layout
    .leftSpaceToView(backView,0)
    .rightSpaceToView(backView,0)
    .bottomSpaceToView(backView,0)
    .heightIs(10);
    
}

- (void)btnAction:(UIButton *)button{
    if (self.delegate){
        [self.delegate brandMainTopViewClickButtonWithTag:button.tag];
    }
}

@end
