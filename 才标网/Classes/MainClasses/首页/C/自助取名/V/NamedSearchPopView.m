//
//  NamedSearchPopView.m
//  才标网
//
//  Created by caohouhong on 17/4/5.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "NamedSearchPopView.h"

@implementation NamedSearchPopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self){
        self.backgroundColor = [UIColor whiteColor];
        [self drawView];
    }
    return self;
}

- (void)drawView{
    
    self.titleLabel = [[UILabel alloc]init];
    _titleLabel.text = @"注册前查询,有效提高成功率";
    _titleLabel.textColor = COLOR_darkGray;
    _titleLabel.font = [UIFont systemFontOfSize:15*UIRate];
    [self addSubview:_titleLabel];
    
    UIButton *blackBtn = [[UIButton alloc]init];
    [blackBtn setImage:[UIImage imageNamed:@"home_delect_20x20"] forState:UIControlStateNormal];
    [blackBtn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:blackBtn];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = COLOR_BackgroundColor;
    [self addSubview:lineView];
    
    UILabel *trademarkLabel = [[UILabel alloc]init];
    trademarkLabel.text = @"商标名称";
    trademarkLabel.textColor = COLOR_darkGray;
    trademarkLabel.font = [UIFont systemFontOfSize:15*UIRate];
    [self addSubview:trademarkLabel];
    
    UILabel *tradeLayerLabel = [[UILabel alloc]init];
    tradeLayerLabel.layer.borderWidth= 1.0f;
    tradeLayerLabel.layer.borderColor = COLOR_LineViewColor.CGColor;
    tradeLayerLabel.layer.cornerRadius = 5;
    [self addSubview:tradeLayerLabel];
    
    UILabel *iphoneLabel = [[UILabel alloc]init];
    iphoneLabel.text = @"电话";
    iphoneLabel.textColor = COLOR_darkGray;
    iphoneLabel.font = [UIFont systemFontOfSize:15*UIRate];
    [self addSubview:iphoneLabel];
    
    UILabel *phoneLayerLabel = [[UILabel alloc]init];
    phoneLayerLabel.layer.borderWidth= 1.0f;
    phoneLayerLabel.layer.borderColor = COLOR_LineViewColor.CGColor;
    phoneLayerLabel.layer.cornerRadius = 5;
    [self addSubview:phoneLayerLabel];
    
    
    UILabel *nameLabel = [[UILabel alloc]init];
    nameLabel.text = @"姓名";
    nameLabel.textColor = COLOR_darkGray;
    nameLabel.font = [UIFont systemFontOfSize:15*UIRate];
    [self addSubview:nameLabel];
    
    UILabel *nameLayerLabel = [[UILabel alloc]init];
    nameLayerLabel.layer.borderWidth= 1.0f;
    nameLayerLabel.layer.borderColor = COLOR_LineViewColor.CGColor;
    nameLayerLabel.layer.cornerRadius = 5;
    [self addSubview:nameLayerLabel];
    
    _trademarkTF = [[UITextField alloc]init];
    _trademarkTF.font = [UIFont systemFontOfSize:15*UIRate];
    _trademarkTF.tag = 1010;
    [self addSubview:_trademarkTF];

    _nameTF = [[UITextField alloc]init];
    _nameTF.font = [UIFont systemFontOfSize:15*UIRate];
    _nameTF.placeholder = @"请输入姓名";
    _nameTF.tag = 1011;
    [self addSubview:_nameTF];
    
    _iphoneTF = [[UITextField alloc]init];
    _iphoneTF.font = [UIFont systemFontOfSize:15*UIRate];
    _iphoneTF.placeholder = @"仅官方可见";
    _iphoneTF.tag = 1012;
    _iphoneTF.keyboardType = UIKeyboardTypeNumberPad;
    [self addSubview:_iphoneTF];
    
    self.btn = [[UIButton alloc]init];
    [_btn setTitle:@"免费获取查询结果" forState:UIControlStateNormal];
    _btn.titleLabel.font = [UIFont systemFontOfSize:15*UIRate];
    _btn.backgroundColor = COLOR_OrangeRed;
    [_btn addTarget:self action:@selector(saveClickButton) forControlEvents:UIControlEventTouchUpInside];
    [_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _btn.layer.masksToBounds = YES;
    _btn.layer.cornerRadius = 8;
    [_btn.layer setBorderWidth:1];//设置边界的宽度
    _btn.layer.borderColor = COLOR_OrangeRed.CGColor;
    [self addSubview:_btn];
    
    _titleLabel.sd_layout
    .leftSpaceToView(self,20*UIRate)
    .topSpaceToView(self,15*UIRate)
    .rightSpaceToView(self,20*UIRate)
    .heightIs(20*UIRate);
    
    blackBtn.sd_layout
    .rightSpaceToView(self,15*UIRate)
    .centerYEqualToView(_titleLabel)
    .widthIs(30*UIRate)
    .heightIs(30*UIRate);
    
    lineView.sd_layout
    .topSpaceToView(self,45*UIRate)
    .leftSpaceToView(self,0)
    .rightSpaceToView(self,0)
    .heightIs(1);
    
    trademarkLabel.sd_layout
    .leftSpaceToView(self,20*UIRate)
    .topSpaceToView(lineView,25*UIRate)
    .widthIs(75*UIRate)
    .heightIs(25*UIRate);
    
    tradeLayerLabel.sd_layout
    .centerYEqualToView(trademarkLabel)
    .leftSpaceToView(trademarkLabel,5*UIRate)
    .widthIs(145*UIRate)
    .heightIs(35*UIRate);
    
    _trademarkTF.sd_layout
    .centerYEqualToView(tradeLayerLabel)
    .leftSpaceToView(trademarkLabel,8*UIRate)
    .widthIs(140*UIRate)
    .heightIs(35*UIRate);
    
    nameLabel.sd_layout
    .topSpaceToView(trademarkLabel,30*UIRate)
    .leftSpaceToView(self,20*UIRate)
    .widthIs(75*UIRate)
    .heightIs(25*UIRate);
    
    nameLayerLabel.sd_layout
    .centerYEqualToView(nameLabel)
    .leftSpaceToView(nameLabel,5*UIRate)
    .widthIs(145*UIRate)
    .heightIs(35*UIRate);

    _nameTF.sd_layout
    .centerYEqualToView(nameLayerLabel)
    .leftSpaceToView(nameLabel,8*UIRate)
    .widthIs(140*UIRate)
    .heightIs(35*UIRate);
    
    iphoneLabel.sd_layout
    .topSpaceToView(nameLabel,30*UIRate)
    .leftSpaceToView(self,20*UIRate)
    .widthIs(75*UIRate)
    .heightIs(25*UIRate);
    
    phoneLayerLabel.sd_layout
    .centerYEqualToView(iphoneLabel)
    .leftSpaceToView(iphoneLabel,5*UIRate)
    .widthIs(145*UIRate)
    .heightIs(35*UIRate);
    
    _iphoneTF.sd_layout
    .centerYEqualToView(phoneLayerLabel)
    .leftSpaceToView(iphoneLabel,8*UIRate)
    .widthIs(140*UIRate)
    .heightIs(35*UIRate);

    _btn.sd_layout
    .leftSpaceToView(self,20*UIRate)
    .rightSpaceToView(self,20*UIRate)
    .bottomSpaceToView(self,20*UIRate)
    .heightIs(40*UIRate);
  
}

//取消按钮
- (void)cancelClick{
    if (self.closeBlock){
        self.closeBlock();
    }
}

//查询结果
- (void)saveClickButton{
    [self endEditing:YES];
    if (!self.trademarkTF.text.length){
        [LCProgressHUD showFailure:@"请输入商标名称"];
        return;
    }
    
    if (!self.nameTF.text.length){
        [LCProgressHUD showFailure:@"请输入姓名"];
        return;
    }
    
    if (self.iphoneTF.text.length != 11){
        [LCProgressHUD showFailure:@"请输入11位电话号码"];
        return;
    }
    
    [self endEditing:YES];
    
    if (self.searchBlock){
        self.searchBlock(self.trademarkTF.text, self.nameTF.text, self.iphoneTF.text);
    }
}
@end
