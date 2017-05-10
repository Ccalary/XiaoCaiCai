//
//  TradeCateCollectionViewCell.m
//  才标网
//
//  Created by caohouhong on 17/5/2.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "TradeCateCollectionViewCell.h"
@interface TradeCateCollectionViewCell()

@end

@implementation TradeCateCollectionViewCell

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
    
    self.contentView.layer.cornerRadius = 4.0;
    self.contentView.layer.borderWidth = 1;
    self.contentView.layer.borderColor = COLOR_BackgroundColor.CGColor;
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.text = @"专利发明";
    _titleLabel.font = SYSTEM_FONT_(15*UIRate);
    _titleLabel.textColor = COLOR_darkGray;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_titleLabel];
    
    _titleLabel.sd_layout
    .leftEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .centerYEqualToView(self.contentView)
    .heightIs(20*UIRate);
}

@end
