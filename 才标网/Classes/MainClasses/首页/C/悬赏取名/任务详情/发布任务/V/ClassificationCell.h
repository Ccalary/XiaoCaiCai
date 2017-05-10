//
//  ClassificationCell.h
//  才标网
//
//  Created by baichun on 17/3/28.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TradeMarkCategoryModel.h"

@interface ClassificationCell : UITableViewCell
+ (ClassificationCell *)cellWithTableView:(UITableView *)tableView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *label;

@property (nonatomic, strong) TradeMarkCategoryModel *model;
@end
