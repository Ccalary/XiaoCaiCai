//
//  queryCell_1.m
//  才标网
//
//  Created by baichun on 17/3/14.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "queryCell_1.h"

@implementation queryCell_1
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self drawView];
    }
    
    return self;
}

+ (queryCell_1 *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"queryCell_1";
    queryCell_1 *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[queryCell_1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.backgroundColor = COLOR_BackgroundColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

-(void)drawView{
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont systemFontOfSize:12*UIRate];
    titleLabel.textColor = HEXCOLOR(0x333333);
    titleLabel.text = @"人工商标复查费用为6元，并出具检索报告，8点至17点，1小时内出具检索报告";
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.backgroundColor =  COLOR_BackgroundColor;
    titleLabel.numberOfLines = 0;
    [self.contentView addSubview:titleLabel];

    titleLabel.sd_layout
    .leftSpaceToView(self.contentView,15*UIRate)
    .rightSpaceToView(self.contentView,15*UIRate)
    .topSpaceToView(self.contentView,0)
    .bottomSpaceToView(self.contentView,0);
    
    
}











- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
