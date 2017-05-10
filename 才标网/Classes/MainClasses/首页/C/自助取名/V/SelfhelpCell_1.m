//
//  SelfhelpCell_1.m
//  才标网
//
//  Created by baichun on 17/3/18.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "SelfhelpCell_1.h"

@implementation SelfhelpCell_1
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self drawView];
    }
    
    return self;
}

+ (SelfhelpCell_1 *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"SelfhelpCell_1";
    SelfhelpCell_1 *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[SelfhelpCell_1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)drawView
{
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.textColor = COLOR_Green;
    titleLabel.text = @"行业起名";
    titleLabel.font = [UIFont systemFontOfSize:18*UIRate];
    [self.contentView addSubview:titleLabel];

    UIView *kuangView = [[UIView alloc] init];
    kuangView.layer.cornerRadius = 5;
    kuangView.layer.borderWidth= 1.0f;
    kuangView.layer.borderColor = HEXCOLOR(0xc7c7cd).CGColor;
    [self.contentView addSubview:kuangView];
    
    self.industryLabel = [[UILabel alloc]init];
    _industryLabel.font = [UIFont systemFontOfSize:18*UIRate];
    _industryLabel.textColor = COLOR_Gray;
    [self.contentView addSubview:_industryLabel];
    
    
    self.iconBtn = [[UIButton alloc]init];
    [_iconBtn setImage:[UIImage imageNamed:@"icon_xiala2"] forState:UIControlStateNormal];
    [self.contentView addSubview:_iconBtn];
    //放置在label上
    self.coverBtn = [[UIButton alloc]init];
    [_coverBtn addTarget:self action:@selector(iconBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_coverBtn];
    
    self.determineBtn = [[UIButton alloc]init];
    [_determineBtn setTitle:@"按行业起名" forState:UIControlStateNormal];
    [_determineBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _determineBtn.backgroundColor = COLOR_Green;
    _determineBtn.layer.masksToBounds = YES;
    _determineBtn.layer.cornerRadius = 8;
    [_determineBtn.layer setBorderWidth:1];//设置边界的宽度
    _determineBtn.layer.borderColor = COLOR_Green.CGColor;
    [_determineBtn addTarget:self action:@selector(determineBtn:) forControlEvents:UIControlEventTouchUpInside];
    _determineBtn.titleLabel.font = [UIFont systemFontOfSize:18*UIRate];
    [self.contentView addSubview:_determineBtn];
    
    titleLabel.sd_layout
    .leftSpaceToView(self.contentView,15*UIRate)
    .topSpaceToView(self.contentView,10*UIRate)
    .heightIs(20*UIRate)
    .widthIs(300*UIRate);
    
    kuangView.sd_layout
    .leftSpaceToView(self.contentView,15*UIRate)
    .topSpaceToView(titleLabel,10*UIRate)
    .heightIs(40*UIRate)
    .widthIs(200*UIRate);
    
    _industryLabel.sd_layout
    .leftSpaceToView(self.contentView,20*UIRate)
    .centerYEqualToView(kuangView)
    .heightIs(40*UIRate)
    .widthIs(180*UIRate);
    
    _coverBtn.sd_layout
    .leftSpaceToView(self.contentView,20*UIRate)
    .centerYEqualToView(kuangView)
    .heightIs(40*UIRate)
    .widthIs(180*UIRate);
    
    _iconBtn.sd_layout
    .topSpaceToView(titleLabel,15*UIRate)
    .leftSpaceToView(self.contentView,185*UIRate)
    .heightIs(30*UIRate)
    .widthIs(30*UIRate);
    
    _determineBtn.sd_layout
    .rightSpaceToView(self.contentView,15*UIRate)
    .topSpaceToView(titleLabel,10*UIRate)
    .widthIs(100*UIRate)
    .heightIs(40*UIRate);
}

-(void)iconBtn:(UIButton *)btn{
    self.block0();
}
-(void)determineBtn:(UIButton *)btn{
    self.block1();
}

@end
