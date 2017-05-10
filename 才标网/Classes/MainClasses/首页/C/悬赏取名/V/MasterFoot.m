//
//  MasterFoot.m
//  才标网
//
//  Created by baichun on 17/3/29.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "MasterFoot.h"

@implementation MasterFoot
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithReuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self drawView];
    }
    
    return self;
}

-(void)drawView{
    

    self.registeredBtn = [[UIButton alloc]init];
    [_registeredBtn addTarget:self action:@selector(registered) forControlEvents:UIControlEventTouchUpInside];
    [_registeredBtn setTitle:@"我要提问" forState:UIControlStateNormal];
    
    _registeredBtn.layer.cornerRadius = 8;
    //    [registeredBtn.layer setBorderWidth:1];//设置边界的宽度
    //    registeredBtn.layer.borderWidth = 1;
    
    [_registeredBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    
    _registeredBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    _registeredBtn.backgroundColor = COLOR_ButtonBackGround_Orange;
    [self.contentView addSubview:_registeredBtn];
    
    _registeredBtn.sd_layout
    .leftSpaceToView(self.contentView,20*UIRate)
    .rightSpaceToView(self.contentView,20*UIRate)
    .topSpaceToView(self.contentView,10*UIRate)
    .bottomSpaceToView(self.contentView,10*UIRate);
    
    
    
    
}

-(void)registered{
    
    if (self.saveblock) {
        self.saveblock();
    }
    
}

@end
