//
//  IamMasterFoot.m
//  才标网
//
//  Created by baichun on 17/3/30.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "IamMasterFoot.h"

@implementation IamMasterFoot

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithReuseIdentifier:reuseIdentifier];
    self.contentView.backgroundColor = [UIColor whiteColor];
    if (self) {
        
        [self drawView];
    }
    
    return self;
}

-(void)drawView{
    
    self.replyBtn = [[UIButton alloc]init];
    [_replyBtn setTitle:@"回 复" forState:UIControlStateNormal];
    _replyBtn.backgroundColor = [UIColor whiteColor];
    _replyBtn.layer.masksToBounds = YES;
    _replyBtn.layer.cornerRadius = 15;
    [_replyBtn.layer setBorderWidth:1];//设置边界的宽度
    _replyBtn.layer.borderColor = COLOR_OrangeRed.CGColor;
    [_replyBtn setTitleColor:COLOR_OrangeRed forState:UIControlStateNormal];
    [_replyBtn addTarget:self action:@selector(replybtn) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_replyBtn];
    
     _replyBtn.sd_layout
     .topSpaceToView(self.contentView,10*UIRate)
     .bottomSpaceToView(self.contentView,10*UIRate)
     .centerXEqualToView(self.contentView)
     .widthIs(90*UIRate);
}

-(void)replybtn{
    
    if (self.saveblock) {
        self.saveblock();
    }

    
}



@end
