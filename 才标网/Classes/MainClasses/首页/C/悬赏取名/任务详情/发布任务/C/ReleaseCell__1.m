//
//  ReleaseCell__1.m
//  才标网
//
//  Created by baichun on 17/3/22.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "ReleaseCell__1.h"

@implementation ReleaseCell__1
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self drawView];
    }
    
    return self;
}

+ (ReleaseCell__1 *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"ReleaseCell__1";
    ReleaseCell__1 *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[ReleaseCell__1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}


-(void)drawView{
    UILabel *typeLabel = [[UILabel alloc]init];
    typeLabel.font = [UIFont systemFontOfSize:15*UIRate];
    typeLabel.textColor = COLOR_Black;
    typeLabel.text = @"类型";
    typeLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:typeLabel];
    
    self.rademarkBtn = [[UIButton alloc]init];
    [self.rademarkBtn addTarget:self action:@selector(rademarkBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.rademarkBtn setTitle:@"商标起名" forState:UIControlStateNormal];
    [self.rademarkBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.rademarkBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft
                                      imageTitleSpace:5];
    self.rademarkBtn.titleLabel.font = [UIFont systemFontOfSize:14*UIRate];
    self.rademarkBtn.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.rademarkBtn];
    
    self.companyBtn = [[UIButton alloc]init];
    [self.companyBtn  addTarget:self action:@selector(companyBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.companyBtn  setTitle:@"公司起名" forState:UIControlStateNormal];
    [self.companyBtn  setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.companyBtn  layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft
                                      imageTitleSpace:5];
    self.companyBtn .titleLabel.font = [UIFont systemFontOfSize:14*UIRate];
    self.companyBtn .backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.companyBtn
     
     ];
    
    
    typeLabel.sd_layout
    .leftSpaceToView(self.contentView,15*UIRate)
    .centerYEqualToView(self.contentView)
    .widthIs(40*UIRate)
    .heightIs(30*UIRate);
    
    _rademarkBtn.sd_layout
    .leftSpaceToView(typeLabel,130*UIRate)
    .centerYEqualToView(self.contentView)
    .widthIs(80*UIRate)
    .heightIs(30*UIRate);
    
    _companyBtn.sd_layout
    .rightSpaceToView(self.contentView,10*UIRate)
    .centerYEqualToView(self.contentView)
    .heightIs(30*UIRate)
    .widthIs(80*UIRate);
    
}

-(void)rademarkBtn:(UIButton *)btn{
    
    self.block0(btn);
    
}

-(void)companyBtn:(UIButton *)btn{
    
    
    self.block1(btn);
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
