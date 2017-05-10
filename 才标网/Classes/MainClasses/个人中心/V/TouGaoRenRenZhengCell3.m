//
//  TouGaoRenRenZhengCell3.m
//  才标网
//
//  Created by 李强 on 2017/2/17.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "TouGaoRenRenZhengCell3.h"

@implementation TouGaoRenRenZhengCell3


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor whiteColor];
        [self drawView];
    }
    
    return self;
}

+ (TouGaoRenRenZhengCell3 *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"TouGaoRenRenZhengCell3";
    TouGaoRenRenZhengCell3 *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[TouGaoRenRenZhengCell3 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)drawView
{
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont systemFontOfSize:15*UIRate];
    titleLabel.textColor = HEXCOLOR(0x333333);
    titleLabel.text = @"擅长";
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:titleLabel];
    
    titleLabel.sd_layout
    .leftSpaceToView(self.contentView ,15*UIRate)
    .topSpaceToView(self.contentView,0)
    .bottomSpaceToView(self.contentView,0)
    .widthIs(60*UIRate);
}

@end
