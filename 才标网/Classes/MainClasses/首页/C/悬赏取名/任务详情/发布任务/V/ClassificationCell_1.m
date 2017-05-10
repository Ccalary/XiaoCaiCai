//
//  ClassificationCell_1.m
//  才标网
//
//  Created by baichun on 17/3/28.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "ClassificationCell_1.h"

@implementation ClassificationCell_1
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self drawView];
    }
    
    return self;
}

+ (ClassificationCell_1 *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"ClassificationCell_1";
    ClassificationCell_1 *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[ClassificationCell_1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

-(void)drawView{
    self.titleLabel = [[UILabel alloc]init];
    _titleLabel.font = [UIFont systemFontOfSize:15*UIRate];
    _titleLabel.text = @"第 1 类 化工原料";
    [self.contentView addSubview:_titleLabel];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = COLOR_BackgroundColor;
//    [self.contentView addSubview:lineView];
    
    _titleLabel.sd_layout
    .leftSpaceToView(self.contentView,15*UIRate)
    .centerYEqualToView(self.contentView)
    .heightIs(20*UIRate)
    .rightSpaceToView(self.contentView,15*UIRate);
    
    
    lineView.sd_layout
    .leftSpaceToView(self.contentView,0)
    .rightSpaceToView(self.contentView,0)
    .bottomSpaceToView(self.contentView,0)
    .heightIs(1);
    
    
}
@end
