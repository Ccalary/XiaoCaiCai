//
//  BrandSearchResultCollectCell.h
//  才标网
//
//  Created by caohouhong on 17/3/24.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BrandSearchModel.h"

@class BrandSearchResultCollectCell;

@protocol BrandSearchResultCollectCellDelegate <NSObject>

- (void)onFavourButtonClick:(BrandSearchResultCollectCell *)cell;

@end

@interface BrandSearchResultCollectCell : UICollectionViewCell
//传索引过来
@property (nonatomic) NSIndexPath *indexPath; 

@property (nonatomic, strong) BrandSearchModel *model;
@property (nonatomic, weak) id<BrandSearchResultCollectCellDelegate> delegate;

@property (nonatomic, strong) UIView *dividerLine4;
@end
