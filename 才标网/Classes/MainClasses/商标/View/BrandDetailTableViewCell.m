//
//  BrandDetailTableViewCell.m
//  才标网
//
//  Created by caohouhong on 17/3/24.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "BrandDetailTableViewCell.h"


@implementation BrandDetailTableViewCell

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
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textColor = COLOR_Gray;
    _titleLabel.font = SYSTEM_FONT_(15*UIRate);
    [self.contentView addSubview:_titleLabel];
    
//    _contenLabel = [[UILabel alloc] init];
//    _contenLabel.textColor = COLOR_Gray;
//    _contenLabel.font = SYSTEM_FONT_(15*UIRate);
//    [self.contentView addSubview:_contenLabel];
//    
//    _contentImageView = [[UIImageView alloc] init];
//    _contentImageView.image = [UIImage imageNamed:@"brand_s_fav_s_14x12"];
//    _contentImageView.hidden = YES;
//    [self.contentView addSubview:_contentImageView];
    
//    _titleLabel.sd_layout
//    .leftSpaceToView(self.contentView,10*UIRate)
//    .topSpaceToView(self.contentView,10*UIRate)
//    .widthIs(ScreenWidth/2.0 - 10*UIRate)
//    .heightIs(20*UIRate);
    
     _titleLabel.sd_layout
     .leftEqualToView(self)
     .rightEqualToView(self)
     .bottomEqualToView(self)
     .topEqualToView(self);
    
//    _contenLabel.sd_layout
//    .leftSpaceToView(self.contentView,ScreenWidth/2.0)
//    .topSpaceToView(self.contentView,10*UIRate)
//    .widthIs(ScreenWidth/2.0 - 10*UIRate)
//    .autoHeightRatio(0);
//    
//    _contentImageView.sd_layout
//    .leftEqualToView(_contenLabel)
//    .centerYEqualToView(self.contentView)
//    .widthIs(14*UIRate)
//    .heightIs(12*UIRate);
    
    self.contentView.sd_layout
    .topEqualToView(self)
    .leftEqualToView(_titleLabel)
    .bottomEqualToView(_titleLabel);
}

@end
