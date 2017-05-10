//
//  ClassificationCell_2.m
//  才标网
//
//  Created by baichun on 17/4/19.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "ClassificationCell_2.h"

@implementation ClassificationCell_2
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self drawView];
    }
    
    return self;
}

+ (ClassificationCell_2 *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"ClassificationCell_2";
    ClassificationCell_2 *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[ClassificationCell_2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}
-(void)drawView{
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.font = [UIFont systemFontOfSize:15*UIRate];
    _titleLabel.numberOfLines = 0;
    [self.contentView addSubview:_titleLabel];
    
    _titleLabel.sd_layout
    .leftSpaceToView(self.contentView,15*UIRate)
    .rightSpaceToView(self.contentView,15*UIRate)
    .topSpaceToView(self.contentView,5*UIRate)
    .autoHeightRatio(0);
}

@end
