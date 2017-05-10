//
//  CatePopTableViewCell.m
//  才标网
//
//  Created by caohouhong on 17/3/22.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "CatePopTableViewCell.h"
@interface CatePopTableViewCell()

@end

@implementation CatePopTableViewCell

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
    _topTitleLabel.textColor = COLOR_darkGray;
    _topTitleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_topTitleLabel];
    
    UIView *dividerLine1 = [[UIView alloc] init];
    dividerLine1.backgroundColor = COLOR_BackgroundColor;
    [self.contentView addSubview:dividerLine1];
    
    _topTitleLabel.sd_layout
    .centerXEqualToView(self.contentView)
    .centerYEqualToView(self.contentView)
    .widthRatioToView(self.contentView,1)
    .heightRatioToView(self.contentView,1);
    
    dividerLine1.sd_layout
    .leftEqualToView(self.contentView)
    .bottomEqualToView(self.contentView)
    .widthRatioToView(self.contentView,1)
    .heightIs(1);
}

@end
