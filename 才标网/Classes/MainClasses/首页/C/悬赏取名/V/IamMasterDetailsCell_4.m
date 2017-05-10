//
//  IamMasterDetailsCell_4.m
//  才标网
//
//  Created by baichun on 17/3/27.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "IamMasterDetailsCell_4.h"

@implementation IamMasterDetailsCell_4
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self drawView];
    }
    
    return self;
}
+ (IamMasterDetailsCell_4 *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"IamMasterDetailsCell_4";
    IamMasterDetailsCell_4 *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[IamMasterDetailsCell_4 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}


-(void)drawView{
    self.nameLabel = [[UILabel alloc]init];
    _nameLabel.text = @"洋葱:";
    _nameLabel.textColor = COLOR_LightGray;
    _nameLabel.font = [UIFont systemFontOfSize:15*UIRate];
    [self.contentView addSubview:_nameLabel];
    
    
    self.answerLabel = [[UILabel alloc]init];
    _answerLabel.text = @"跟我生辰八字有啥关系？";
    _answerLabel.font = [UIFont systemFontOfSize:15*UIRate];
    [self.contentView addSubview:_answerLabel];
    
    UIButton *replyBtn = [[UIButton alloc]init];
    [replyBtn setTitle:@"回 复" forState:UIControlStateNormal];
    replyBtn.backgroundColor = [UIColor whiteColor];
    replyBtn.layer.masksToBounds = YES;
    replyBtn.layer.cornerRadius = 15;
    [replyBtn.layer setBorderWidth:1];//设置边界的宽度
    replyBtn.layer.borderColor = COLOR_OrangeRed.CGColor;
    [replyBtn setTitleColor:COLOR_OrangeRed forState:UIControlStateNormal];

    _nameLabel.sd_layout
    .leftSpaceToView(self.contentView,15*UIRate)
    .topSpaceToView(self.contentView,10*UIRate)
    .widthIs(45*UIRate)
    .heightIs(20*UIRate);
    
    _answerLabel.sd_layout
    .leftSpaceToView(_nameLabel,5*UIRate)
    .rightSpaceToView(self.contentView,5*UIRate)
    .topSpaceToView(self.contentView,10*UIRate)
    .heightIs(20*UIRate);
    
   
    
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
