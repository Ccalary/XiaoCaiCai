//
//  BrandMMainTopView.h
//  才标网
//
//  Created by caohouhong on 17/3/15.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,BrandMainTopViewBtnType){
    ///商标购买
    BrandMainTopViewBtnTypeSearch    = 0,
    ///商品分类
    BrandMainTopViewBtnTypeCategory  = 1,
    ///出售商品
    BrandMainTopViewBtnTypeSale      = 2,
};

@protocol  BrandMainTopViewDelegate<NSObject>

- (void)brandMainTopViewClickButtonWithTag:(BrandMainTopViewBtnType)tag;

@end

@interface BrandMainTopView : UICollectionReusableView

@property (nonatomic, weak) id<BrandMainTopViewDelegate> delegate;

@end
