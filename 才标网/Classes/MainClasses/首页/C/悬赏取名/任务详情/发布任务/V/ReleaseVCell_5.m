//
//  ReleaseVCell_5.m
//  才标网
//
//  Created by baichun on 17/3/14.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "ReleaseVCell_5.h"

#define MAX_LIMIT_NUMS 200
@interface ReleaseVCell_5 ()<UITextViewDelegate>

@property (nonatomic, strong) UILabel *titleLabel;

@end
@implementation ReleaseVCell_5
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self drawView];
    }
    
    return self;
}

+ (ReleaseVCell_5 *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"ReleaseVCell_5";
    ReleaseVCell_5 *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[ReleaseVCell_5 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}


-(void)drawView{
    
    UITextView *textView = [[UITextView alloc]init];
    textView.delegate = self;
    textView.tag = 2014;
    textView.placeholder = @"您还可以描述具体需求，写的越清晰，投稿越多";
    textView.placeholderLabel.font = SYSTEM_FONT_(13*UIRate);
    textView.placeholderLabel.textColor = COLOR_Gray;
    textView.textColor = COLOR_Gray;
    textView.font = SYSTEM_FONT_(13*UIRate);
    [self.contentView addSubview:textView];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = SYSTEM_FONT_(11*UIRate);
    _titleLabel.textColor = COLOR_Gray;
    _titleLabel.text = @"0/200";
    _titleLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_titleLabel];

    UIView *dividerLine1 = [[UIView alloc] init];
    dividerLine1.backgroundColor = COLOR_BackgroundColor;
    [self.contentView addSubview:dividerLine1];
    
    textView.sd_layout
    .leftSpaceToView(self.contentView,15*UIRate)
    .rightSpaceToView(self.contentView,15*UIRate)
    .bottomSpaceToView(self.contentView,10*UIRate)
    .topSpaceToView(self.contentView,10*UIRate);
    
    _titleLabel.sd_layout
    .rightSpaceToView(self.contentView,15*UIRate)
    .bottomSpaceToView(self.contentView,5*UIRate)
    .widthIs(80*UIRate)
    .heightIs(20*UIRate);
    
    dividerLine1.sd_layout
    .leftEqualToView(self.contentView)
    .bottomEqualToView(self.contentView)
    .widthRatioToView(self.contentView,1)
    .heightIs(1);
}

- (void)textViewDidChange:(UITextView *)textView
{
    
    
    NSString  *nsTextContent = textView.text;
    NSInteger existTextNum = nsTextContent.length;
    
    if (existTextNum > MAX_LIMIT_NUMS)
    {
        //截取到最大位置的字符
        NSString *s = [nsTextContent substringToIndex:MAX_LIMIT_NUMS];
        
        [textView setText:s];
    }
 
    self.titleLabel.text = [NSString stringWithFormat:@"%ld/%d",existTextNum,MAX_LIMIT_NUMS];
    
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
@end
