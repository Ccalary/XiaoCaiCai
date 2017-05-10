//
//  MainCollectionViewLayout.h
//  才标网
//
//  Created by caohouhong on 17/4/17.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainCollectionViewLayout : UICollectionViewLayout
@property (nonatomic) CGSize itemSize;
@property (nonatomic) NSInteger visibleCount;
@property (nonatomic) UICollectionViewScrollDirection scrollDirection;
@end
