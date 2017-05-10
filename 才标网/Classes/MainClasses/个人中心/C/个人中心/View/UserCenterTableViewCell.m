//
//  UserCenterTableViewCell.m
//  才标网
//
//  Created by caohouhong on 17/3/20.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "UserCenterTableViewCell.h"
@interface UserCenterTableViewCell()

@end

@implementation UserCenterTableViewCell

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
    
    _iconImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:_iconImageView];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = SYSTEM_FONT_(15*UIRate);
    _titleLabel.textColor = COLOR_Black;
    _titleLabel.text = @"商标";
    [self.contentView addSubview:_titleLabel];
    
    _rightTextLabel = [[UILabel alloc] init];
    _rightTextLabel.font = SYSTEM_FONT_(14*UIRate);
    _rightTextLabel.textColor = COLOR_LightGray;
//    _rightTextLabel.text = @"1条新消息";
    _rightTextLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_rightTextLabel];
    
    _arrowImageView = [[UIImageView alloc] init];
    _arrowImageView.image = [UIImage imageNamed:@"arrow_10x18"];
    [self.contentView addSubview:_arrowImageView];
    
    _iconImageView.sd_layout
    .leftSpaceToView(self.contentView,15*UIRate)
    .centerYEqualToView(self.contentView)
    .widthIs(24*UIRate)
    .heightIs(24*UIRate);
    
    _titleLabel.sd_layout
    .leftSpaceToView(_iconImageView,10*UIRate)
    .centerYEqualToView(self.contentView)
    .widthIs(150*UIRate)
    .heightRatioToView(self.contentView,1);
    
    _rightTextLabel.sd_layout
    .rightSpaceToView(self.contentView,45*UIRate)
    .centerYEqualToView(self.contentView)
    .widthIs(150*UIRate)
    .heightRatioToView(self.contentView,1);
    
    _arrowImageView.sd_layout
    .rightSpaceToView(self.contentView,15*UIRate)
    .centerYEqualToView(self.contentView)
    .widthIs(10*UIRate)
    .heightIs(18*UIRate);
}

@end
