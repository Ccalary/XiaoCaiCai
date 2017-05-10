//
//  EditpageCell.h
//  才标网
//
//  Created by baichun on 17/3/24.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^delectBlock)();
@interface EditpageCell : UICollectionViewCell
@property (nonatomic,copy) delectBlock delectblock;
@property (nonatomic, strong) UIImageView *ImageView;
@property (nonatomic, strong) UIButton *delectBtn;

@end
