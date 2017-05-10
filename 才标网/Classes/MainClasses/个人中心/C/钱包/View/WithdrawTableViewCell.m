//
//  WithdrawTableViewCell.m
//  才标网
//
//  Created by caohouhong on 17/3/14.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "WithdrawTableViewCell.h"
@interface WithdrawTableViewCell()


@end
@implementation WithdrawTableViewCell

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
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = SYSTEM_FONT_(15*UIRate);
    _titleLabel.textColor = COLOR_Black;
    [self.contentView addSubview:_titleLabel];
    
    _rightTextField = [[UITextField alloc] init];
    _rightTextField.font = SYSTEM_FONT_(15*UIRate);
    _rightTextField.textColor = COLOR_darkGray;
    _rightTextField.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_rightTextField];
    
    
    _titleLabel.sd_layout
    .leftSpaceToView(self.contentView, 15*UIRate)
    .centerYEqualToView(self.contentView)
    .widthIs(60*UIRate)
    .heightRatioToView(self.contentView,1);
    //宽度自适应
    [_titleLabel setSingleLineAutoResizeWithMaxWidth: 100*UIRate];
    
    _rightTextField.sd_layout
    .leftSpaceToView(_titleLabel,5*UIRate)
    .rightEqualToView(self.contentView).offset(-15*UIRate)
    .centerYEqualToView(_titleLabel)
    .heightRatioToView(self.contentView,1);
}

@end
