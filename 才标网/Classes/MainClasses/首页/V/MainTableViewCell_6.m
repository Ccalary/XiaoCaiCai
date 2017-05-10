//
//  MainTableViewCell_6.m
//  才标网
//
//  Created by 李强 on 2017/2/15.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "MainTableViewCell_6.h"

@interface MainTableViewCell_6 ()
@property (nonatomic, strong) UIView *topView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIButton *seeMoreButton;
@end

@implementation MainTableViewCell_6


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self drawView];
    }
    
    return self;
}

+ (MainTableViewCell_6 *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"MainTableViewCell_6";
    MainTableViewCell_6 *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[MainTableViewCell_6 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)drawView
{
    _topView = [[UIView alloc]  init];
    _topView.backgroundColor = HEXCOLOR(0xff6464);
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = SYSTEM_FONT_(16*UIRate);
    _titleLabel.textColor = COLOR_Black;
    _titleLabel.text = @"大师推荐";
    
    _seeMoreButton = [[UIButton alloc] init];
    [_seeMoreButton setTitle:@"查看更多 >" forState:UIControlStateNormal];
    [_seeMoreButton addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    _seeMoreButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    _seeMoreButton.titleLabel.font = SYSTEM_FONT_(13*UIRate);
    [_seeMoreButton setTitleColor:COLOR_Gray forState:UIControlStateNormal];
    
    UIView *dividerLine1 = [[UIView alloc] init];
    dividerLine1.backgroundColor = COLOR_BackgroundColor;
    
    [self.contentView sd_addSubviews:@[_topView, _titleLabel, _seeMoreButton, dividerLine1]];
    
    _topView.sd_layout
    .leftEqualToView(self.contentView)
    .centerYEqualToView(self.contentView)
    .widthIs(5*UIRate)
    .heightIs(15*UIRate);
    
    _titleLabel.sd_layout
    .leftSpaceToView(self.contentView,10*UIRate)
    .centerYEqualToView(self.contentView)
    .widthIs(100*UIRate)
    .heightIs(20*UIRate);

    
    _seeMoreButton.sd_layout
    .rightSpaceToView(self.contentView,10*UIRate)
    .centerYEqualToView(self.contentView)
    .widthIs(100*UIRate)
    .heightIs(30*UIRate);
    
    dividerLine1.sd_layout
    .leftEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .bottomEqualToView(self.contentView)
    .heightIs(1);
}

- (void)btnAction{
    
    if (self.block){
        self.block();
    }
}

@end
