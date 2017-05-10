//
//  ReviewResultDetailCell.m
//  才标网
//
//  Created by caohouhong on 17/3/14.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "ReviewResultDetailCell.h"
@interface ReviewResultDetailCell()

@end

@implementation ReviewResultDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self drawView];
    }
    
    return self;
}

- (void)drawView{
    
    _topTitleLabel = [[UILabel alloc] init];
    _topTitleLabel.font = SYSTEM_FONT_(15*UIRate);
    _topTitleLabel.textColor = COLOR_Gray;
    [self.contentView addSubview:_topTitleLabel];
    
    _leftNameLabel = [[UILabel alloc] init];
    _leftNameLabel.font = SYSTEM_FONT_(15*UIRate);
    _leftNameLabel.textColor = COLOR_Black;
    _leftNameLabel.text = @"名字";
    [self.contentView addSubview:_leftNameLabel];
    
    _rightButton = [[UIButton alloc] init];
    [_rightButton setTitle:@"注册商标" forState:UIControlStateNormal];
    [_rightButton setTitleColor:COLOR_Blue forState:UIControlStateNormal];
    _rightButton.titleLabel.font = SYSTEM_FONT_(15*UIRate);
    _rightButton.backgroundColor = [UIColor clearColor];
    _rightButton.hidden = YES;
    _rightButton.layer.borderWidth = 1;
    _rightButton.layer.borderColor = COLOR_Blue.CGColor;
    [_rightButton addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_rightButton];
    
    _topTitleLabel.sd_layout
    .leftSpaceToView(self.contentView, 15*UIRate)
    .centerYEqualToView(self.contentView)
    .widthIs(80*UIRate)
    .heightIs(15*UIRate);
    
    _leftNameLabel.sd_layout
    .leftSpaceToView(_topTitleLabel,10*UIRate)
    .centerYEqualToView(_topTitleLabel)
    .widthIs(100*UIRate)
    .heightIs(15*UIRate);
    
    _rightButton.sd_layout
    .rightEqualToView(self.contentView).offset(-15*UIRate)
    .centerYEqualToView(self.contentView)
    .widthIs(80*UIRate)
    .heightIs(25*UIRate);
    
    _rightButton.sd_cornerRadiusFromHeightRatio = @(0.5);
}

- (void)rightBtnAction{
    if (self.block){
        self.block();
    }
}
@end
