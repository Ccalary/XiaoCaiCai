//
//  PleaseNameCell_1.m
//  才标网
//
//  Created by baichun on 17/3/15.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "PleaseNameCell_1.h"

@implementation PleaseNameCell_1
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
    {
        if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
        {
            self.contentView.backgroundColor = [UIColor whiteColor];
            [self drawView];
        }
        
        return self;
    }
    
+ (PleaseNameCell_1 *)cellWithTableView:(UITableView *)tableView
    {
        static NSString *idenifier = @"PleaseNameCell_1";
        PleaseNameCell_1 *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
        if (cell == nil)
        {
            cell = [[PleaseNameCell_1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        return cell;
    }
    
-(void)drawView{
    
    
  
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont systemFontOfSize:13];
    titleLabel.textColor = HEXCOLOR(0x999999);
    titleLabel.text = @"老板名字";
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:titleLabel];
    
    UITextField *nameField = [[UITextField alloc]init];
    nameField.placeholder = @"请输入老板名字";
    nameField.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:nameField];
   
    
    titleLabel.sd_layout
    .leftSpaceToView(self.contentView,15)
    .topSpaceToView(self.contentView,5)
    .widthIs(60*UIRate)
    .heightIs(30*UIRate);
    
    nameField.sd_layout
    .leftSpaceToView(titleLabel,5)
    .rightSpaceToView(self.contentView,5)
    .topEqualToView(titleLabel)
    .bottomEqualToView(titleLabel);
    
    
    
    
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
