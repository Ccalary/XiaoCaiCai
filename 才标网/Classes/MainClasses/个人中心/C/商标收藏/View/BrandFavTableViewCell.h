//
//  BrandFavTableViewCell.h
//  才标网
//
//  Created by caohouhong on 17/3/14.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TrademarkFollowModel.h"
typedef void(^cancelBlock)(TrademarkFollowModel *model);

@interface BrandFavTableViewCell : UITableViewCell

@property (nonatomic, strong)TrademarkFollowModel *model;

@property (nonatomic, copy)cancelBlock block;

@end
