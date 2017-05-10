//
//  BrandCateCollectionViewCell.m
//  才标网
//
//  Created by caohouhong on 17/3/15.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "BrandCateCollectionViewCell.h"
@interface BrandCateCollectionViewCell()
@property (nonatomic, strong) UILabel *titleLabel, *moneyLabel;
@property (nonatomic, strong) UIImageView *brandImageView;
@end

@implementation BrandCateCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self){
        self.backgroundColor = [UIColor whiteColor];
        [self drawView];
    }
    return self;
}

- (void)drawView{
    
    _brandImageView = [[UIImageView alloc] init];
//    _brandImageView.contentMode = UIViewContentModeCenter;
    _brandImageView.image = [UIImage imageNamed:@"brand_s_default_110x75"];
    [self.contentView addSubview:_brandImageView];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.text = @"专利发明";
    _titleLabel.font = SYSTEM_FONT_(15*UIRate);
    _titleLabel.textColor = COLOR_darkGray;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_titleLabel];
    
    _moneyLabel = [[UILabel alloc] init];
    _moneyLabel.text = @"¥0.00";
    _moneyLabel.font = SYSTEM_FONT_(15*UIRate);
    _moneyLabel.textColor = COLOR_Orange;
    _moneyLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_moneyLabel];
    
    _brandImageView.sd_layout
    .centerXEqualToView(self.contentView)
    .topSpaceToView(self.contentView,10*UIRate)
    .widthIs(115*UIRate)
    .heightIs(115*UIRate);
    
    _titleLabel.sd_layout
    .leftEqualToView(self.contentView)
    .topSpaceToView(self.contentView,140*UIRate)
    .widthRatioToView(self.contentView,1)
    .heightIs(20*UIRate);
    
    _moneyLabel.sd_layout
    .leftEqualToView(self.contentView)
    .bottomSpaceToView(self.contentView,5*UIRate)
    .widthRatioToView(self.contentView,1)
    .heightIs(20*UIRate);
}

-(void)setModel:(ProductModel *)model{
    //brand_s_default_110x75暂时的占位图
    [_brandImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.thumb]] placeholderImage:[UIImage imageNamed:@"brand_s_default_110x75"]];
    _titleLabel.text = model.name;
    
    /*
     * 备注：price和special 只会一个有值，不会同时存在。
     如果  price有值special为false，商品为正常价格；
     如果  special有值price为false，商品为促销价格；
     * */
    if ([model.price isEqualToString:@"false"]){
        _moneyLabel.text = model.special;
    }else {
        _moneyLabel.text = model.price;
    }
}
@end
