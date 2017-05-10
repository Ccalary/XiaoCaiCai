//
//  EditpageCell.m
//  才标网
//
//  Created by baichun on 17/3/24.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "EditpageCell.h"

@implementation EditpageCell


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
    _ImageView = [[UIImageView alloc] init];
    _ImageView.userInteractionEnabled = YES;
    [self.contentView addSubview:_ImageView];
    
    self.delectBtn = [[UIButton alloc]init];
    [self.delectBtn setImage:[UIImage imageNamed:@"camera_close"] forState:UIControlStateNormal];

    [self.delectBtn addTarget:self action:@selector(delect) forControlEvents:UIControlEventTouchUpInside];
    [_ImageView addSubview:self.delectBtn];
    
   
    _ImageView.sd_layout
    .leftSpaceToView(self.contentView,0)
    .rightSpaceToView(self.contentView,0)
    .topSpaceToView(self.contentView,0)
    .bottomSpaceToView(self.contentView,0);
    
    self.delectBtn.sd_layout
    .rightSpaceToView(_ImageView,0)
    .topSpaceToView(_ImageView,0)
    .widthIs(20*UIRate)
    .heightIs(20*UIRate);
    
    
    
}
//点击删除cell了
-(void)delect{
    
    
    if (self.delectblock) {
        self.delectblock();
    }
    
    
}

@end
