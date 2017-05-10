//
//  AccordingindustryCell_1.m
//  才标网
//
//  Created by baichun on 17/3/20.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "AccordingindustryCell_1.h"
@interface AccordingindustryCell_1()

@end

@implementation AccordingindustryCell_1
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self drawView];
    }
    
    return self;
}

+ (AccordingindustryCell_1 *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"AccordingindustryCell_1";
    AccordingindustryCell_1 *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[AccordingindustryCell_1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

-(void)drawView{
    _nameLabel = [[UILabel alloc]init];
    _nameLabel.font = [UIFont systemFontOfSize:15*UIRate];
    _nameLabel.textColor = COLOR_darkGray;
    [self.contentView addSubview:_nameLabel];
    
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"咨询注册";
    titleLabel.font = [UIFont systemFontOfSize:15*UIRate];
    titleLabel.textColor = COLOR_OrangeRed;
    titleLabel.textAlignment=NSTextAlignmentRight;
    [self.contentView addSubview:titleLabel];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = COLOR_BackgroundColor;
    [self.contentView addSubview:lineView];
    
    _nameLabel.sd_layout
    .leftSpaceToView(self.contentView,15*UIRate)
    .centerYEqualToView(self.contentView)
    .widthIs(ScreenWidth - 100*UIRate)
    .heightIs(20*UIRate);
    
    titleLabel.sd_layout
    .rightSpaceToView(self.contentView,15*UIRate)
    .centerYEqualToView(self.contentView)
    .widthIs(80*UIRate)
    .heightIs(20*UIRate);
    
    lineView.sd_layout
    .leftSpaceToView(self.contentView,0)
    .rightSpaceToView(self.contentView,0)
    .bottomSpaceToView(self.contentView,0)
    .heightIs(1);
}

@end
