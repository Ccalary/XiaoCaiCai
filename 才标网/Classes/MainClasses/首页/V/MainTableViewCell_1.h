//
//  MainTableViewCell_1.h
//  才标网
//
//  Created by 李强 on 2017/2/15.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeAdsModel.h"

typedef void(^clikcBlock)(HomeAdsModel *adModel);

@interface MainTableViewCell_1 : UITableViewCell

+ (MainTableViewCell_1 *)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, copy) clikcBlock block;

@property (nonatomic, strong) NSArray *adsArray;

@end
