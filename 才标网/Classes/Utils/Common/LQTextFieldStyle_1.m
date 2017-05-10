//
//  LQTextFieldStyle_1.m
//  ZhouMo
//
//  Created by liqiang on 16/9/14.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import "LQTextFieldStyle_1.h"

@implementation LQTextFieldStyle_1

- (instancetype)init
{
    if (self = [super init])
    {
        [self drawView];
    }
    
    return self;
}

- (void)drawView
{
    //密码输入框
    UIImageView *iconImageView = [[UIImageView alloc] init];
    [self addSubview:iconImageView];
    self.iconImageView = iconImageView;
    
    UITextField *textField = [[UITextField alloc] init];
    textField.font = FONT_TEXTSIZE_Mid;
    [textField setPlaceholderColor:HEXCOLOR(0x333333)];
    [self addSubview:textField];
    self.textField = textField;
    
    UIView *pwdLineView = [[UIView alloc] init];
    pwdLineView.backgroundColor = HEXCOLOR(0x999999);
    [self addSubview:pwdLineView];
    
    iconImageView.sd_layout
    .leftSpaceToView(self,5)
    .topSpaceToView(self,0)
    .widthIs(18)
    .heightIs(21.5);
    
    textField.sd_layout
    .leftSpaceToView(iconImageView,10)
    .topEqualToView(iconImageView)
    .heightIs(21.5)
    .rightSpaceToView(self,0);
    
    pwdLineView.sd_layout
    .leftSpaceToView(self,0)
    .topSpaceToView(textField,5)
    .rightSpaceToView(self,0)
    .heightIs(0.5);
}

@end
