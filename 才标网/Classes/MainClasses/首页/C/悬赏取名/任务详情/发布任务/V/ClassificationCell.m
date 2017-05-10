//
//  ClassificationCell.m
//  才标网
//
//  Created by baichun on 17/3/28.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "ClassificationCell.h"

@implementation ClassificationCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self drawView];
    }
    
    return self;
}

+ (ClassificationCell *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"ClassificationCell";
    ClassificationCell *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[ClassificationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}

-(void)drawView{
    self.titleLabel = [[UILabel alloc]init];
    _titleLabel.font = [UIFont systemFontOfSize:15*UIRate];
    _titleLabel.text = @"第 1 类 化工原料";
    [self.contentView addSubview:_titleLabel];
    
    
    self.label = [[UILabel alloc]init];
    _label.text = @"☆";
    _label.textColor = COLOR_Gray;
//    [self.contentView addSubview:_label];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = COLOR_BackgroundColor;
//    [self.contentView addSubview:lineView];

    _titleLabel.sd_layout
    .leftSpaceToView(self.contentView,15*UIRate)
    .centerYEqualToView(self.contentView)
    .heightIs(20*UIRate)
    .widthIs(130*UIRate);
    
    _label.sd_layout
    .leftSpaceToView(_titleLabel,5*UIRate)
    .widthIs(100*UIRate)
    .topEqualToView(_titleLabel)
    .heightIs(20*UIRate);
    
    lineView.sd_layout
    .leftSpaceToView(self.contentView,0)
    .rightSpaceToView(self.contentView,0)
    .bottomSpaceToView(self.contentView,0)
    .heightIs(1);
}

- (void)setModel:(TradeMarkCategoryModel *)model{
    
     self.titleLabel.text = [NSString stringWithFormat:@"%@ %@",model.category_number,model.category_name];
}

@end
