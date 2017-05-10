//
//  GeRenZhongXingCell1.m
//  才标网
//
//  Created by 李强 on 2017/2/17.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "GeRenZhongXingCell1.h"

@implementation GeRenZhongXingCell1


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        
        [self drawView];
    }
    
    return self;
}

+ (GeRenZhongXingCell1 *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"GeRenZhongXingCell1";
    GeRenZhongXingCell1 *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    cell.backgroundColor = COLOR_BackgroundColor;
    if (cell == nil)
    {
        cell = [[GeRenZhongXingCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)drawView
{
    self.backgroundImageView = [[UIImageView alloc]init];
    self.backgroundImageView.backgroundColor = [UIColor blackColor];
    self.backgroundImageView.image = [UIImage imageNamed:@"pic-bg"];
    [self.contentView addSubview:self.backgroundImageView];
    
    
    self.iconImageView = [[UIImageView alloc] init];
    self.iconImageView.image = [UIImage imageNamed:@"pic-touxiang"];
    self.iconImageView.backgroundColor = [UIColor redColor];
    [self.backgroundImageView addSubview:self.iconImageView];
    
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.text = @"赵子渊";
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.backgroundImageView addSubview:self.titleLabel];
    
    self.backgroundImageView.sd_layout
    .leftSpaceToView(self.contentView,0)
    .rightSpaceToView(self.contentView,0)
    .topSpaceToView(self.contentView,0)
    .bottomSpaceToView(self.contentView,20);
    
    self.iconImageView.sd_layout
    .centerXEqualToView(self.backgroundImageView)
    .topSpaceToView(self.backgroundImageView,85*UIRate)
    .heightIs(50*UIRate)
    .widthIs(50*UIRate);
    self.iconImageView.sd_cornerRadiusFromWidthRatio = @(0.5);
    
    self.titleLabel.sd_layout
    .leftSpaceToView(self.backgroundImageView,10*UIRate)
    .rightSpaceToView(self.backgroundImageView,10*UIRate)
    .topSpaceToView(self.iconImageView,15*UIRate)
    .heightIs(20*UIRate);
}
@end
