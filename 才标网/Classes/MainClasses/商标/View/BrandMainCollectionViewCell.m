//
//  BrandMainCollectionViewCell.m
//  才标网
//
//  Created by caohouhong on 17/3/15.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "BrandMainCollectionViewCell.h"
@interface BrandMainCollectionViewCell()

@end

@implementation BrandMainCollectionViewCell

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
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.text = @"商标注册送版权";
    _titleLabel.font = SYSTEM_FONT_(15*UIRate);
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = COLOR_darkGray;
  //  [self.contentView addSubview:_titleLabel];
    
    _brandImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:_brandImageView];
    
    _titleLabel.sd_layout
    .leftEqualToView(self.contentView)
    .bottomSpaceToView(self.contentView,10*UIRate)
    .widthRatioToView(self.contentView,1)
    .heightIs(20*UIRate);
    
    _brandImageView.sd_layout
    .leftSpaceToView(self.contentView,0)
    .rightSpaceToView(self.contentView,0)
    .topSpaceToView(self.contentView,0)
    .bottomSpaceToView(self.contentView,0);
    
 }
-(void)setModel:(HomeAdsModel *)model{
  //  self.titleLabel.text = model.name;
    //此处占位图
    [self.brandImageView sd_setImageWithURL:IMAGE_URL(model.adImg) placeholderImage:[UIImage imageNamed:@"c_brand_default_pic"]];
}
@end
