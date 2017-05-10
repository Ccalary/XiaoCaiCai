//
//  reportCell.m
//  才标网
//
//  Created by baichun on 17/3/27.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "reportCell.h"

@implementation reportCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self drawView];
    }
    
    return self;
}

+ (reportCell *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"reportCell";
    reportCell *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[reportCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}



-(void)drawView{
    self.titleLabel = [[UILabel alloc]init];
    _titleLabel.text = @"色情";
    _titleLabel.font = [UIFont systemFontOfSize:15*UIRate];
    [self.contentView addSubview:_titleLabel];
    
    self.imageV = [[UIImageView alloc]init];
    self.imageV.image = [UIImage imageNamed:@"btn_weichaxun_n-1"];
    self.imageV.tag = 8888;
    [self.contentView addSubview:self.imageV];
    
    UIView *lineView =[[UIView alloc]init];
    lineView.backgroundColor = COLOR_BackgroundColor;
    [self.contentView addSubview:lineView];
    
    _titleLabel.sd_layout
    .leftSpaceToView(self.contentView,15*UIRate)
    .centerYEqualToView(self.contentView)
    .widthIs(120*UIRate)
    .heightIs(20*UIRate);
    
    _imageV.sd_layout
    .rightSpaceToView(self.contentView,15*UIRate)
    .centerYEqualToView(self.contentView)
    .widthIs(20*UIRate)
    .heightIs(20*UIRate);
    
    lineView.sd_layout
    .bottomSpaceToView(self.contentView,0)
    .heightIs(1)
    .rightSpaceToView(self.contentView,0)
    .leftSpaceToView(self.contentView,0);
    
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
