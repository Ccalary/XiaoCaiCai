//
//  IamMasterDetailsCell_3.m
//  才标网
//
//  Created by baichun on 17/3/20.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "IamMasterDetailsCell_3.h"

@implementation IamMasterDetailsCell_3
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self drawView];
    }
    
    return self;
}

+ (IamMasterDetailsCell_3 *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"IamMasterDetailsCell_3";
    IamMasterDetailsCell_3 *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[IamMasterDetailsCell_3 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

-(void)drawView{
    
    UILabel *titlelabel = [[UILabel alloc]init];
    titlelabel.text = @"释义说明:";
    titlelabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:titlelabel];
    
    UIButton *btn = [[UIButton alloc]init];
    [btn setImage:[UIImage imageNamed:@"IamMaster_shangchuanzhaopian"] forState:UIControlStateNormal];
    [self.contentView addSubview:btn];
    
    titlelabel.sd_layout
    .topSpaceToView(self.contentView,5*UIRate)
    .leftSpaceToView(self.contentView,15*UIRate)
    .heightIs(20*UIRate)
    .widthIs(100*UIRate);
    
    btn.sd_layout
    .leftSpaceToView(self.contentView,15*UIRate)
    .topSpaceToView(titlelabel,5*UIRate)
    .heightIs(70*UIRate)
    .widthIs(70*UIRate);
    
    
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
