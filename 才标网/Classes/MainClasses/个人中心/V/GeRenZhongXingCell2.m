//
//  GeRenZhongXingCell2.m
//  才标网
//
//  Created by 李强 on 2017/2/17.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "GeRenZhongXingCell2.h"

@implementation GeRenZhongXingCell2


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self drawView];
    }
    
    return self;
}

+ (GeRenZhongXingCell2 *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"GeRenZhongXingCell2";
    GeRenZhongXingCell2 *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[GeRenZhongXingCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}

- (void)drawView
{
    [self addUnderlineWithLeftMargin:10 rightMargin:0 lineHeight:0.5];
    
    self.imgvHeader  = [[UIImageView alloc] init];
    self.imageView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.imgvHeader];
    
    self.lblTitle = [[UILabel alloc]init];
    self.lblTitle.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:self.lblTitle];
    
    self.rigtTitle = [[UILabel alloc]init];
    self.rigtTitle.font = [UIFont systemFontOfSize:13];
    self.rigtTitle.textColor = COLOR_LightGray;
    [self.contentView addSubview:self.rigtTitle];
    
    
    _imgvHeader.sd_layout
    .leftSpaceToView(self.contentView,15*UIRate)
    .topSpaceToView(self.contentView,15*UIRate)
    .widthIs(20*UIRate)
    .heightIs(20*UIRate);
    
    _lblTitle.sd_layout
    .leftSpaceToView(_imgvHeader,15*UIRate)
    .topEqualToView(_imgvHeader)
    .bottomEqualToView(_imgvHeader)
    .widthIs(100*UIRate);
    
    _rigtTitle.sd_layout
    .topEqualToView(_lblTitle)
    .bottomEqualToView(_lblTitle)
    .rightSpaceToView(self.contentView,50*UIRate)
    .leftSpaceToView(_lblTitle,80*UIRate);
    
    
}
@end
