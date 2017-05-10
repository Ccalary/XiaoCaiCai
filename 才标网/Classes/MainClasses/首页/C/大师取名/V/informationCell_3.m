//
//  informationCell_3.m
//  才标网
//
//  Created by baichun on 17/3/15.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "informationCell_3.h"
@interface informationCell_3()
@property (nonatomic, strong)UILabel *mTextLabel;
@property (nonatomic, strong)UIButton *showBtn;
@end

@implementation informationCell_3
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
    {
        if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
        {
            self.contentView.backgroundColor = [UIColor whiteColor];
            [self drawView];
        }
        
        return self;
    }
    
+ (informationCell_3 *)cellWithTableView:(UITableView *)tableView
    {
        static NSString *idenifier = @"informationCell_3";
        informationCell_3 *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
        if (cell == nil)
        {
            cell = [[informationCell_3 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        return cell;
    }
    
-(void)drawView{
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont systemFontOfSize:15*UIRate];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.text = @"大师简介";
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:titleLabel];
    
    _mTextLabel = [[UILabel alloc] init];
    _mTextLabel.font = SYSTEM_FONT_(14*UIRate);
    _mTextLabel.textColor = COLOR_darkGray;
    _mTextLabel.numberOfLines = 0;
    [self.contentView addSubview:_mTextLabel];
    
    _showBtn = [[UIButton alloc]init];
    [_showBtn addTarget:self action:@selector(showBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_showBtn setTitle:@"查看全部" forState:UIControlStateNormal];
    [_showBtn setTitleColor:COLOR_ButtonBackGround_Blue forState:UIControlStateNormal];
    _showBtn.titleLabel.font = [UIFont systemFontOfSize:13*UIRate];
    _showBtn.hidden = YES;
    _showBtn.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_showBtn];
    
    UIView *dividerLine1 = [[UIView alloc] init];
    dividerLine1.backgroundColor = COLOR_BackgroundColor;
    [self.contentView addSubview:dividerLine1];
    
    titleLabel.sd_layout
    .leftSpaceToView(self.contentView,5*UIRate)
    .rightSpaceToView(self.contentView,5*UIRate)
    .topEqualToView(self.contentView).offset(15*UIRate)
    .heightIs(20*UIRate);
    
    _mTextLabel.sd_layout
    .leftEqualToView(titleLabel)
    .rightEqualToView(titleLabel)
    .topSpaceToView(titleLabel,10*UIRate)
    .heightIs(70*UIRate);
    [_mTextLabel setAutoHeight:70*UIRate];
    
    _showBtn.sd_layout
    .rightSpaceToView(self.contentView,5)
    .bottomSpaceToView(self.contentView,8*UIRate)
    .widthIs(80*UIRate)
    .heightIs(20*UIRate);
    
    dividerLine1.sd_layout
    .leftEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .bottomEqualToView(self.contentView)
    .heightIs(1);
}


- (void)setModel:(ModelMember *)model
{
    _model = model;
    NSString *str = model.memberExtend.introduce ?: @"";
    //是否显示更多
    if (str.length > 65){
        self.showBtn.hidden = NO;
    }else {
        self.showBtn.hidden = YES;
    }
    
    [self setLabelSpace:self.mTextLabel withValue:str withFont:SYSTEM_FONT_(14*UIRate)];
    
}

-(void)showBtn:(UIButton *)btn{
    
    if (self.block){
        self.block(self.model.memberExtend.introduce);
    }
}

//给UILabel设置行间距和字间距
-(void)setLabelSpace:(UILabel*)label withValue:(NSString*)str withFont:(UIFont*)font {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = 5*UIRate; //设置行间距
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    //设置字间距 NSKernAttributeName:@1.5f
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle};
    
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:str attributes:dic];
    label.attributedText = attributeStr;
}

@end
