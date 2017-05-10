//
//  TouGaoRenRenZhengCell1.m
//  才标网
//
//  Created by 李强 on 2017/2/17.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "TouGaoRenRenZhengCell1.h"

@interface TouGaoRenRenZhengCell1 ()<UITextFieldDelegate>

@end

@implementation TouGaoRenRenZhengCell1


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self drawView];
    }
    
    return self;
}

+ (TouGaoRenRenZhengCell1 *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"TouGaoRenRenZhengCell1";
    TouGaoRenRenZhengCell1 *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[TouGaoRenRenZhengCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)drawView
{
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont systemFontOfSize:15*UIRate];
    titleLabel.textColor = HEXCOLOR(0x333333);
    titleLabel.text = @"姓名";
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:titleLabel];
    
    _textField = [[UITextField alloc] init];
    _textField.placeholder = @"请输入姓名";
    _textField.delegate = self;
    _textField.font = [UIFont systemFontOfSize:15*UIRate];
    [self.contentView addSubview:_textField];
    
    _checkingLabel = [[UILabel alloc] init];
    _checkingLabel.text = @"审核中...";
    _checkingLabel.font = SYSTEM_FONT_(15*UIRate);
    _checkingLabel.textColor = COLOR_Gray;
    _checkingLabel.hidden = YES;
    [self.contentView addSubview:_checkingLabel];
    
    _sureBtn = [[UIButton alloc] init];
    _sureBtn.backgroundColor = [UIColor clearColor];
    [_sureBtn setTitle:@" 已认证" forState:UIControlStateNormal];
    [_sureBtn setTitleColor:HEXCOLOR(0x5abe3f) forState:UIControlStateNormal];
    [_sureBtn setImage:[UIImage imageNamed:@"icon-yirenzheng"] forState:UIControlStateNormal];
    _sureBtn.titleLabel.font = [UIFont systemFontOfSize:14*UIRate];
    _sureBtn.userInteractionEnabled = NO;
    _sureBtn.hidden = YES;
    _sureBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.contentView addSubview:_sureBtn];
    
    titleLabel.sd_layout
    .leftSpaceToView(self.contentView ,15)
    .topSpaceToView(self.contentView,0)
    .bottomSpaceToView(self.contentView,0)
    .widthIs(45);
    
    _sureBtn.sd_layout
    .rightSpaceToView(self.contentView ,15)
    .topSpaceToView(self.contentView,0)
    .bottomSpaceToView(self.contentView,0)
    .widthIs(70);
    
    _checkingLabel.sd_layout
    .rightSpaceToView(self.contentView ,15)
    .topSpaceToView(self.contentView,0)
    .bottomSpaceToView(self.contentView,0)
    .widthIs(80);
    
    _textField.sd_layout
    .leftSpaceToView(titleLabel,10)
    .topSpaceToView(self.contentView,0)
    .bottomSpaceToView(self.contentView,0)
    .rightSpaceToView(_sureBtn,5);
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (self.didHaveTureName) {
        self.didHaveTureName(toBeString);
    }
    
    return YES;
}

@end
