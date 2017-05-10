//
//  ReleaseVCell_8.m
//  才标网
//
//  Created by baichun on 17/3/17.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "ReleaseVCell_8.h"

@implementation ReleaseVCell_8
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self drawView];
    }
    
    return self;
}

+ (ReleaseVCell_8 *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"ReleaseVCell_8";
    ReleaseVCell_8 *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[ReleaseVCell_8 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

-(void)drawView{
    
    UIButton *agreedBtn = [[UIButton alloc]init];
    [agreedBtn setImage:[UIImage imageNamed:@"icon_tongyi"] forState:UIControlStateNormal];
//    [self.contentView addSubview:agreedBtn];
    
    UIButton *termsBtn = [[UIButton alloc]init];
    [termsBtn setTitle:@"同意发布任务条款" forState:UIControlStateNormal];
    termsBtn.titleLabel.font = [UIFont systemFontOfSize:13*UIRate];
    [termsBtn setTitleColor:COLOR_OrangeRed forState:UIControlStateNormal];
//    [self.contentView addSubview:termsBtn];
    
    
    UIButton *releaseBtn = [[UIButton alloc]init];
    [releaseBtn setTitle:@"发  布" forState:UIControlStateNormal];
    [releaseBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    releaseBtn.titleLabel.font = [UIFont systemFontOfSize:16*UIRate];
    releaseBtn.backgroundColor = COLOR_OrangeRed;
    releaseBtn.layer.cornerRadius = 15;
    releaseBtn.clipsToBounds = YES;
    releaseBtn.tag = 1028;
    [self.contentView addSubview:releaseBtn];
    
    
//    agreedBtn.sd_layout
//    .leftSpaceToView(self.contentView,120*UIRate)
//    .topSpaceToView(self.contentView,10*UIRate)
//    .widthIs(15*UIRate)
//    .heightIs(15*UIRate);
//    
//    termsBtn.sd_layout
//    .leftSpaceToView(agreedBtn,3*UIRate)
//    .rightSpaceToView(self.contentView,111*UIRate)
//    .topSpaceToView(self.contentView,10*UIRate)
//    .heightIs(15*UIRate);
    
    releaseBtn.sd_layout
    .centerXEqualToView(self.contentView)
    .centerYEqualToView(self.contentView)
    .widthIs(293*UIRate)
    .heightIs(40*UIRate);
    
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
