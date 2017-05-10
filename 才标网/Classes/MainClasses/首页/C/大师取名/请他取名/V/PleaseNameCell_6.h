//
//  PleaseNameCell_6.h
//  才标网
//
//  Created by baichun on 17/3/15.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DashiPackageModel.h"

@interface PleaseNameCell_6 : UITableViewCell

@property (nonatomic, strong) DashiPackageModel *model;
@property (nonatomic, strong) UIButton *selectBtn;

+ (PleaseNameCell_6 *)cellWithTableView:(UITableView *)tableView;

@end
