//
//  BrandMainCollectionViewCell.h
//  才标网
//
//  Created by caohouhong on 17/3/15.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeAdsModel.h"
@interface BrandMainCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *brandImageView;
@property (nonatomic, strong) HomeAdsModel *model;
-(void)setModel:(HomeAdsModel *)model;
@end
