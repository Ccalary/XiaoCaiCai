//
//  ReleaseVCell_2.m
//  才标网
//
//  Created by baichun on 17/3/14.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "ReleaseVCell_2.h"

@implementation ReleaseVCell_2

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self drawView];
    }
    
    return self;
}

+ (ReleaseVCell_2 *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"ReleaseVCell_2";
    ReleaseVCell_2 *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[ReleaseVCell_2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

-(void)drawView{
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.font = [UIFont systemFontOfSize:15*UIRate];
    titleLabel.textColor = COLOR_Black;
    titleLabel.text = @"标题";
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:titleLabel];
    
    UITextField *text = [[UITextField alloc]init];
    text.placeholder = @"不超过20个字";
    text.backgroundColor = [UIColor whiteColor];
    text.font = [UIFont systemFontOfSize:13];
    text.tag = 1029;
    [self.contentView addSubview:text];

    titleLabel.sd_layout
    .leftSpaceToView(self.contentView,15)
    .centerYEqualToView(self.contentView)
    .widthIs(40*UIRate)
    .heightIs(30*UIRate);
    
    
    text.sd_layout
    .leftSpaceToView(titleLabel,20)
    .rightSpaceToView(self.contentView,5)
    .centerYEqualToView(self.contentView)
    .heightIs(30*UIRate);
    
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
