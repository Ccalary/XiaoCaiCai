//
//  masterDetailsCell_10.m
//  才标网
//
//  Created by baichun on 17/3/14.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "masterDetailsCell_10.h"

@implementation masterDetailsCell_10
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self drawView];
    }
    
    return self;
}

+ (masterDetailsCell_10 *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"masterDetailsCell_10";
    masterDetailsCell_10 *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[masterDetailsCell_10 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

-(void)drawView{
    
    
    
    
    
    self.registeredBtn = [[UIButton alloc]init];
    [_registeredBtn addTarget:self action:@selector(registered) forControlEvents:UIControlEventTouchUpInside];
    [_registeredBtn setTitle:@"我要提问" forState:UIControlStateNormal];
    
    _registeredBtn.layer.cornerRadius = 8;
//    [registeredBtn.layer setBorderWidth:1];//设置边界的宽度
//    registeredBtn.layer.borderWidth = 1;

    [_registeredBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    
    
    _registeredBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    _registeredBtn.backgroundColor = COLOR_ButtonBackGround_Orange;
    [self.contentView addSubview:_registeredBtn];
    
    _registeredBtn.sd_layout
    .leftSpaceToView(self.contentView,20*UIRate)
    .rightSpaceToView(self.contentView,20*UIRate)
    .topSpaceToView(self.contentView,10*UIRate)
    .bottomSpaceToView(self.contentView,10*UIRate);
    
    
    
    
}

-(void)registered{
    
    if (self.saveblock) {
        self.saveblock();
    }
    
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
