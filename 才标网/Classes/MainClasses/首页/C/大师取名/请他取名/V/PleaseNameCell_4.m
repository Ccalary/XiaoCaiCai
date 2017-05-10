//
//  PleaseNameCell_4.m
//  才标网
//
//  Created by baichun on 17/3/15.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "PleaseNameCell_4.h"

@implementation PleaseNameCell_4
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
    {
        if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
        {
            self.contentView.backgroundColor = [UIColor whiteColor];
            [self drawView];
        }
        
        return self;
    }
    
+ (PleaseNameCell_4 *)cellWithTableView:(UITableView *)tableView
    {
        static NSString *idenifier = @"PleaseNameCell_4";
        PleaseNameCell_4 *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
        if (cell == nil)
        {
            cell = [[PleaseNameCell_4 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        return cell;
    }
    
-(void)drawView{
    
    
    
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont systemFontOfSize:13];
    titleLabel.textColor = HEXCOLOR(0x999999);
    titleLabel.text = @"出生时刻";
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:titleLabel];
    
    
    self.birthdayBtn = [[UIButton alloc]init];
    [_birthdayBtn addTarget:self action:@selector(birthdayBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_birthdayBtn setTitle:@"请选择" forState:UIControlStateNormal];
    [_birthdayBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight
                                 imageTitleSpace:5];
    _birthdayBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_birthdayBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_birthdayBtn setImage:[UIImage imageNamed:@"icon_xiala2"] forState:UIControlStateNormal];
    [self.contentView addSubview:_birthdayBtn];
    
    titleLabel.sd_layout
    .leftSpaceToView(self.contentView,15)
    .topSpaceToView(self.contentView,5)
    .widthIs(60*UIRate)
    .heightIs(30*UIRate);
    
    _birthdayBtn.sd_layout
    .leftSpaceToView(titleLabel,5)
    .rightSpaceToView(self.contentView,5)
    .topEqualToView(titleLabel)
    .bottomEqualToView(titleLabel);
}
    
-(void)birthdayBtn:(UIButton *)btn{
    
    
    self.block0(btn);
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
