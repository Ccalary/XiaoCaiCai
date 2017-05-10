//
//  RenWuXiangQingCell_5.m
//  才标网
//
//  Created by baichun on 17/3/15.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "RenWuXiangQingCell_5.h"

@implementation RenWuXiangQingCell_5
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
    {
        if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
        {
            [self drawView];
        }
        
        return self;
    }
    
+ (RenWuXiangQingCell_5 *)cellWithTableView:(UITableView *)tableView
    {
        static NSString *idenifier = @"RenWuXiangQingCell_5";
        RenWuXiangQingCell_5 *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
        if (cell == nil)
        {
            cell = [[RenWuXiangQingCell_5 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        return cell;
    }

    
    
-(void)drawView{
    
    
        self.nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:13];
        _nameLabel.textColor = HEXCOLOR(0x999999);
        _nameLabel.text = @"所有投稿(2)";
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_nameLabel];
    
    _nameLabel.sd_layout
    .leftSpaceToView(self.contentView,15)
    .rightSpaceToView(self.contentView,5)
    .topSpaceToView(self.contentView,5)
    .bottomSpaceToView(self.contentView,5);
    
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
