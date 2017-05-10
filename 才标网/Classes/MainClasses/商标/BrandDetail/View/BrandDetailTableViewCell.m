//
//  BrandDetailTableViewCell.m
//  才标网
//
//  Created by caohouhong on 17/3/24.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "BrandDetailTableViewCell.h"


@implementation BrandDetailTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {

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
    
    _contenLabel = [[UILabel alloc] init];
    _contenLabel.textColor = COLOR_Gray;
    _contenLabel.numberOfLines = 0;
    _contenLabel.font = SYSTEM_FONT_(15*UIRate);
    [self.contentView addSubview:_contenLabel];
    
    UIView *dividerLine1 = [[UIView alloc] init];
    dividerLine1.backgroundColor = COLOR_BackgroundColor;
    [self.contentView addSubview:dividerLine1];
    
    _titleLabel.sd_layout
    .leftSpaceToView(self.contentView,10*UIRate)
    .topSpaceToView(self.contentView,10*UIRate)
    .widthIs(ScreenWidth/2.0 - 10*UIRate)
    .heightIs(20*UIRate);
    
    _contenLabel.sd_layout
    .leftSpaceToView(self.contentView,ScreenWidth/2.0)
    .topSpaceToView(self.contentView,10*UIRate)
    .widthIs(ScreenWidth/2.0 - 10*UIRate)
    .autoHeightRatio(0);
    
    dividerLine1.sd_layout
    .leftEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .widthIs(ScreenWidth)
    .heightIs(1);
    
}

@end
