//
//  NavigationView.m
//  才标网
//
//  Created by caohouhong on 17/4/10.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "NavigationView.h"
@interface NavigationView()
@property (nonatomic, copy) NavigationViewBlock block;
@end

@implementation NavigationView

- (instancetype)initWithFrame:(CGRect)frame andTitle:(NSString *)title block:(NavigationViewBlock) block
{
    self = [super initWithFrame:frame];
    if (self){
        _block = [block copy];
        [self drawViewWithTitle:title];
    }
    return self;
}

- (void)drawViewWithTitle:(NSString *)title{
    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    navView.backgroundColor = COLOR_Blue;
    [self addSubview:navView];
    
    UIView *dividerLine1 = [[UIView alloc] initWithFrame:CGRectMake(0, 63, ScreenWidth, 1)];
    dividerLine1.backgroundColor = COLOR_BackgroundColor;
    [self addSubview:dividerLine1];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(30*UIRate, 20, ScreenWidth - 60*UIRate, 44)];
    titleLabel.font = SYSTEM_FONT_(18);
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = title;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLabel];
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 40*UIRate, 44)];
    [backButton setImage:[UIImage imageNamed:@"nav_back_white_12x22"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:backButton];
}

- (void)backButtonAction{
    if (self.block){
        self.block();
    }
}

@end
