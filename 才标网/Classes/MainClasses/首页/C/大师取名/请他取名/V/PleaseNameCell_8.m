//
//  PleaseNameCell_8.m
//  才标网
//
//  Created by baichun on 17/3/15.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "PleaseNameCell_8.h"

@implementation PleaseNameCell_8
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
    {
        if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
        {
            [self drawView];
        }
        
        return self;
    }
    
+ (PleaseNameCell_8 *)cellWithTableView:(UITableView *)tableView
    {
        static NSString *idenifier = @"PleaseNameCell_8";
        PleaseNameCell_8 *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
        if (cell == nil)
        {
            cell = [[PleaseNameCell_8 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        return cell;
    }
    
-(void)drawView{
    
    UILabel *fukuanLabel = [[UILabel alloc] init];
    fukuanLabel.font = [UIFont systemFontOfSize:15*UIRate];
    fukuanLabel.textColor = COLOR_Black;
    fukuanLabel.text = @"付款方式";
    [self.contentView addSubview:fukuanLabel];

    UIButton *weChatBtn = [[UIButton alloc]init];
    weChatBtn.tag = 10002;
    [weChatBtn setImage:[UIImage imageNamed:@"btn_weixin_n"] forState:UIControlStateNormal];
    [weChatBtn setImage:[UIImage imageNamed:@"btn_weixin_s"] forState:UIControlStateSelected];
    weChatBtn.selected = YES;
    [weChatBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:weChatBtn];
    
    
    UIButton *payBtn = [[UIButton alloc]init];
    payBtn.tag = 10001;
    [payBtn setImage:[UIImage imageNamed:@"btn_zhifubao_n"]forState:UIControlStateNormal];
    [payBtn setImage:[UIImage imageNamed:@"btn_zhifubao_s"]forState:UIControlStateSelected];
    [payBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:payBtn];
    
    UILabel *wxLabel = [[UILabel alloc]init];
    wxLabel.font = [UIFont systemFontOfSize:15*UIRate];
    wxLabel.text = @"微信";
    wxLabel.textAlignment = NSTextAlignmentCenter;
    wxLabel.textColor = COLOR_Gray;
    [weChatBtn addSubview:wxLabel];
    
    UILabel *payLabel = [[UILabel alloc]init];
    payLabel.font = [UIFont systemFontOfSize:15*UIRate];
    payLabel.text = @"支付宝";
    payLabel.textColor = COLOR_Gray;
    payLabel.textAlignment = NSTextAlignmentCenter;
    [payBtn addSubview:payLabel];
    
    fukuanLabel.sd_layout
    .leftSpaceToView(self.contentView,15*UIRate)
    .topSpaceToView(self.contentView,10*UIRate)
    .widthIs(100*UIRate)
    .heightIs(20*UIRate);
    
    weChatBtn.sd_layout
    .centerXEqualToView(self.contentView).offset(-85*UIRate)
    .topSpaceToView(fukuanLabel,12*UIRate)
    .widthIs(65*UIRate)
    .heightIs(65*UIRate);
    
    wxLabel.sd_layout
    .centerXEqualToView(weChatBtn)
    .bottomSpaceToView(weChatBtn,5*UIRate)
    .widthRatioToView(weChatBtn,1)
    .heightIs(15*UIRate);
    
    payBtn.sd_layout
    .centerXEqualToView(self.contentView).offset(85*UIRate)
    .topEqualToView(weChatBtn)
    .widthIs(65*UIRate)
    .heightIs(65*UIRate);
    
    payLabel.sd_layout
    .centerXEqualToView(payBtn)
    .bottomSpaceToView(payBtn,5*UIRate)
    .widthRatioToView(payBtn,1)
    .heightIs(15*UIRate);
    
}

- (void)btnAction:(UIButton *)button{
    button.selected = NO;
    switch (button.tag) {
        case 10002://微信
            button.selected = YES;
            break;
        case 10001://支付宝
            button.selected = YES;
            break;
        default:
            break;
    }
    
    if (self.block){
        self.block((int)button.tag - 10000);
    }
    
}

@end
