//
//  PleaseNameCell_7.m
//  才标网
//
//  Created by baichun on 17/3/15.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "PleaseNameCell_7.h"
@interface PleaseNameCell_7()
@property (nonatomic, strong)UILabel *priceLable;
@property (nonatomic, strong) UIImageView *imageView1, *imageView2, *imageView3,*imageView4;
@end

@implementation PleaseNameCell_7
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
    {
        if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
        {
            self.contentView.backgroundColor = [UIColor whiteColor];
            [self drawView];
        }
        
        return self;
    }
    
+ (PleaseNameCell_7 *)cellWithTableView:(UITableView *)tableView
    {
        static NSString *idenifier = @"PleaseNameCell_7";
        PleaseNameCell_7 *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
        if (cell == nil)
        {
            cell = [[PleaseNameCell_7 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        return cell;
    }
    
    
-(void)drawView{
    
    _priceLable = [[UILabel alloc] init];
    _priceLable.font = [UIFont systemFontOfSize:15*UIRate];
    _priceLable.textColor = COLOR_OrangeRed;
    _priceLable.text = @"2998套餐";
    [self.contentView addSubview:_priceLable];
    
    UIButton *selectBtn = [[UIButton alloc] init];
    [selectBtn setImage:[UIImage imageNamed:@"btn_weichaxun_n"] forState:UIControlStateNormal];
    [selectBtn setImage:[UIImage imageNamed:@"btn_weichaxun_s"] forState:UIControlStateSelected];
    [self.contentView addSubview:selectBtn];
    
    _imageView1 = [[UIImageView alloc] init];
    _imageView1.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:_imageView1];
    
    _imageView2 = [[UIImageView alloc] init];
    _imageView2.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:_imageView2];
    
    _imageView3 = [[UIImageView alloc] init];
    _imageView3.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:_imageView3];
    
    _imageView4 = [[UIImageView alloc] init];
    _imageView4.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:_imageView4];
    
    UIView *dividerLine1 = [[UIView alloc] init];
    dividerLine1.backgroundColor = COLOR_BackgroundColor;
    [self.contentView addSubview:dividerLine1];
    
    selectBtn.sd_layout
    .leftSpaceToView(self.contentView,15*UIRate)
    .topSpaceToView(self.contentView,5*UIRate)
    .widthIs(15*UIRate)
    .heightIs(15*UIRate);
    
    _priceLable.sd_layout
    .leftSpaceToView(self.contentView,40*UIRate)
    .centerYEqualToView(selectBtn)
    .widthIs(ScreenWidth - 100*UIRate)
    .heightIs(20*UIRate);
    
    _imageView1.sd_layout
    .leftEqualToView(_priceLable)
    .topSpaceToView(_priceLable,5*UIRate)
    .widthIs(70*UIRate)
    .heightIs(70*UIRate);
    
    _imageView2.sd_layout
    .leftSpaceToView(_imageView1,10*UIRate)
    .centerYEqualToView(_imageView1)
    .widthIs(70*UIRate)
    .heightIs(70*UIRate);
    
    _imageView3.sd_layout
    .leftSpaceToView(_imageView2,10*UIRate)
    .centerYEqualToView(_imageView1)
    .widthIs(70*UIRate)
    .heightIs(70*UIRate);
    
    _imageView4.sd_layout
    .leftSpaceToView(_imageView3,10*UIRate)
    .centerYEqualToView(_imageView1)
    .widthIs(70*UIRate)
    .heightIs(70*UIRate);
    
    dividerLine1.sd_layout
    .leftEqualToView(self.contentView)
    .bottomEqualToView(self.contentView)
    .widthRatioToView(self.contentView,1)
    .heightIs(1);
}

@end
