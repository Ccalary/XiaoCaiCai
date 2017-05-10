//
//  TouGaoRenRenZhengCell4.m
//  才标网
//
//  Created by 李强 on 2017/2/17.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "TouGaoRenRenZhengCell4.h"
#define MAX_LIMIT_NUMS 200

@interface TouGaoRenRenZhengCell4 ()<UITextViewDelegate>

@property (nonatomic, strong) UILabel *titleLabel, *contentLabel;
@property (nonatomic,strong) UITextView *textView;

@end

@implementation TouGaoRenRenZhengCell4


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self drawView];
    }
    
    return self;
}

+ (TouGaoRenRenZhengCell4 *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"TouGaoRenRenZhengCell4";
    TouGaoRenRenZhengCell4 *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[TouGaoRenRenZhengCell4 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)drawView
{
    self.textView = [[UITextView alloc] init];
    _textView.placeholder = @"请输入擅长的内容";
    _textView.font = [UIFont systemFontOfSize:14*UIRate];
    _textView.delegate = self;
    _textView.textColor = COLOR_darkGray;
    [self.contentView addSubview:_textView];
    
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.font = [UIFont systemFontOfSize:14*UIRate];
    _contentLabel.textColor = COLOR_darkGray;
    _contentLabel.numberOfLines = 0;
    [self.contentView addSubview:_contentLabel];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:12*UIRate];
    _titleLabel.textColor = HEXCOLOR(0x999999);
    _titleLabel.text = @"0/200";
    _titleLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_titleLabel];
    
    _textView.sd_layout
    .leftSpaceToView(self.contentView,15)
    .topSpaceToView(self.contentView,5*UIRate)
    .rightSpaceToView(self.contentView,15)
    .heightIs(100*UIRate);
    
    _contentLabel.sd_layout
    .leftSpaceToView(self.contentView,15)
    .topSpaceToView(self.contentView,5*UIRate)
    .rightSpaceToView(self.contentView,15)
    .autoHeightRatio(0);
    
    _titleLabel.sd_layout
    .rightSpaceToView(self.contentView,15)
    .bottomSpaceToView(self.contentView,10*UIRate)
    .widthIs(60*UIRate)
    .heightIs(15*UIRate);
}

- (void)textViewDidChange:(UITextView *)textView
{
    self.titleLabel.text = [NSString stringWithFormat:@"%ld/200",textView.text.length];
    NSString  *nsTextContent = textView.text;
    NSInteger existTextNum = nsTextContent.length;
    
    if (existTextNum > MAX_LIMIT_NUMS)
    {
        //截取到最大位置的字符
        NSString *s = [nsTextContent substringToIndex:MAX_LIMIT_NUMS];
        
        [textView setText:s];
    }

    if (self.didHaveAttr1) {
        self.didHaveAttr1(textView.text);
    }
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text
{
    NSString *comcatstr = [textView.text stringByReplacingCharactersInRange:range withString:text];
    
    NSInteger caninputlen = MAX_LIMIT_NUMS - comcatstr.length;
    
    if (caninputlen >= 0)
    {
        return YES;
    }
    else
    {
        NSInteger len = text.length + caninputlen;
        //防止当text.length + caninputlen < 0时，使得rg.length为一个非法最大正数出错
        NSRange rg = {0,MAX(len,0)};
        
        if (rg.length > 0)
        {
            NSString *s = [text substringWithRange:rg];
            
            [textView setText:[textView.text stringByReplacingCharactersInRange:range withString:s]];
        }
        return NO;
    }
}

- (void)afterRenZhengWith:(NSString *)content{
    
    self.textView.hidden = YES;
    self.titleLabel.hidden = YES;
    
    self.contentLabel.text = content;
}

@end
