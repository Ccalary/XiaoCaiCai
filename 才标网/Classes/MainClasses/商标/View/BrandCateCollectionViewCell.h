//
//  BrandCateCollectionViewCell.h
//  才标网
//
//  Created by caohouhong on 17/3/15.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductModel.h"
@interface BrandCateCollectionViewCell : UICollectionViewCell
@property (nonatomic,strong)ProductModel *model;
-(void)setModel:(ProductModel *)model;
@end
