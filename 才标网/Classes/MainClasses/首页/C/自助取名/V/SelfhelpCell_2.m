//
//  SelfhelpCell_2.m
//  才标网
//
//  Created by baichun on 17/3/18.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "SelfhelpCell_2.h"
#import <QuartzCore/QuartzCore.h>
@implementation SelfhelpCell_2
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self drawView];
    }
    
    return self;
}

+ (SelfhelpCell_2 *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"SelfhelpCell_2";
    SelfhelpCell_2 *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[SelfhelpCell_2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}
-(void)drawView{
    
    self.titleLabel = [[UILabel alloc]init];
    _titleLabel.textColor = COLOR_OrangeRed;
    _titleLabel.text = @"关键字";
    _titleLabel.font = [UIFont systemFontOfSize:18*UIRate];
    [self.contentView addSubview:_titleLabel];
    
    UIView *kuangView = [[UIView alloc] init];
    kuangView.layer.cornerRadius = 5;
    kuangView.layer.borderWidth= 1.0f;
    kuangView.layer.borderColor = HEXCOLOR(0xc7c7cd).CGColor;
    [self.contentView addSubview:kuangView];
    
    self.textFd = [[UITextField alloc]init];
    _textFd.font = [UIFont systemFontOfSize:18*UIRate];
    _textFd.placeholder = @"请输入关键字";
    _textFd.textColor = COLOR_Gray;
    [self.contentView addSubview:_textFd];
    
    
    self.determineBtn = [[UIButton alloc]init];
    [_determineBtn setTitle:@"关键字起名" forState:UIControlStateNormal];
    [_determineBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_determineBtn addTarget:self action:@selector(determineBtnAction) forControlEvents:UIControlEventTouchUpInside];
    _determineBtn.layer.masksToBounds = YES;
    
    _determineBtn.layer.cornerRadius = 8;
    [_determineBtn.layer setBorderWidth:1];//设置边界的宽度
    _determineBtn.backgroundColor = COLOR_OrangeRed;
    _determineBtn.layer.borderColor = COLOR_OrangeRed.CGColor;

    _determineBtn.titleLabel.font = [UIFont systemFontOfSize:18*UIRate];
    [self.contentView addSubview:_determineBtn];

    _titleLabel.sd_layout
    .leftSpaceToView(self.contentView,15*UIRate)
    .topSpaceToView(self.contentView,10*UIRate)
    .heightIs(20*UIRate)
    .widthIs(300*UIRate);
    
    kuangView.sd_layout
    .leftSpaceToView(self.contentView,15*UIRate)
    .topSpaceToView(_titleLabel,10*UIRate)
    .heightIs(40*UIRate)
    .widthIs(200*UIRate);
    
    _textFd.sd_layout
    .leftSpaceToView(self.contentView,20*UIRate)
    .centerYEqualToView(kuangView)
    .heightIs(40*UIRate)
    .widthIs(180*UIRate);
    
    _determineBtn.sd_layout
    .rightSpaceToView(self.contentView,15*UIRate)
    .topSpaceToView(_titleLabel,10*UIRate)
    .widthIs(100*UIRate)
    .heightIs(40*UIRate);
}

-(void)determineBtnAction{
    if (self.block0){
      self.block0();
    }
}
@end
