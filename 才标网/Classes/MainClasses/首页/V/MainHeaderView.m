//
//  MainHeaderView.m
//  才标网
//
//  Created by caohouhong on 17/3/29.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "MainHeaderView.h"

@implementation MainHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self){
     
        self.backgroundColor = [UIColor whiteColor];
        [self drawView];
    }
    return self;
}

- (void)drawView
{
    _topView = [[UIView alloc]  init];
    _topView.backgroundColor = HEXCOLOR(0xff6464);
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = SYSTEM_FONT_(16*UIRate);
    _titleLabel.textColor = COLOR_Black;
    _titleLabel.text = @"大师推荐";
    
    _seeMoreButton = [[UIButton alloc] init];
    [_seeMoreButton setTitle:@"查看更多 >" forState:UIControlStateNormal];
    [_seeMoreButton addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    _seeMoreButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    _seeMoreButton.titleLabel.font = SYSTEM_FONT_(13*UIRate);
    [_seeMoreButton setTitleColor:COLOR_Gray forState:UIControlStateNormal];
    
    
    UIView *dividerLine1 = [[UIView alloc] init];
    dividerLine1.backgroundColor = COLOR_BackgroundColor;
    
    [self sd_addSubviews:@[_topView, _titleLabel, _seeMoreButton, dividerLine1]];
    
    _topView.sd_layout
    .leftEqualToView(self)
    .centerYEqualToView(self)
    .widthIs(5*UIRate)
    .heightIs(15*UIRate);
    
    _titleLabel.sd_layout
    .leftSpaceToView(self,10*UIRate)
    .centerYEqualToView(self)
    .widthIs(100*UIRate)
    .heightIs(20*UIRate);
    
    
    _seeMoreButton.sd_layout
    .rightSpaceToView(self,10*UIRate)
    .centerYEqualToView(self)
    .widthIs(100*UIRate)
    .heightIs(30*UIRate);
    
    dividerLine1.sd_layout
    .leftEqualToView(self)
    .rightEqualToView(self)
    .bottomEqualToView(self)
    .heightIs(1);
}

- (void)btnAction{
    
    if (self.block){
        self.block();
    }
}



@end
