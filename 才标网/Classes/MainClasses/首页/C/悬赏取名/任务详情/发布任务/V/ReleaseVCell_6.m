//
//  ReleaseVCell_6.m
//  才标网
//
//  Created by baichun on 17/3/14.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "ReleaseVCell_6.h"

@implementation ReleaseVCell_6
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self drawView];
    }
    
    return self;
}

+ (ReleaseVCell_6 *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"ReleaseVCell_6";
    ReleaseVCell_6 *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[ReleaseVCell_6 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

-(void)drawView{
    
    UILabel *label = [[UILabel alloc]init];
    label.font = [UIFont systemFontOfSize:15*UIRate];
    label.textColor = COLOR_Gray;
    label.text = @"要求";
    [self.contentView addSubview:label];
   
    label.sd_layout
    .leftSpaceToView(self.contentView,15*UIRate)
    .topSpaceToView(self.contentView,5*UIRate)
    .heightIs(15*UIRate)
    .widthIs(60*UIRate);
    
    
    self.popview = [[TTGroupTagView alloc] initWithFrame:CGRectMake(0, 25*UIRate, ScreenWidth, 50*UIRate)];
    
    self.popview.translatesAutoresizingMaskIntoConstraints = YES;
    
    self.popview.tagHeight = 20*UIRate;
    
    self.popview.textColor = COLOR_LightGray;
    self.popview.borderColor = COLOR_LightGray;
    
    self.popview.selTextColor = COLOR_OrangeRed;
    self.popview.selBorderColor = COLOR_OrangeRed;
    [self.contentView addSubview:_popview];

    
    label.sd_layout
    .leftSpaceToView(self.contentView,15*UIRate)
    .topSpaceToView(self.contentView,5*UIRate)
    .heightIs(15*UIRate)
    .widthIs(60*UIRate);
}

-(void)setDataArr:(NSMutableArray *)btn{
    
    [_popview addTags:btn withCornerScale:0.5];
}
@end
