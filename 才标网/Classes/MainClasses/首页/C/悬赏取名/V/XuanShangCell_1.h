//
//  XuanShangCell_1.h
//  才标网
//
//  Created by baichun on 17/3/17.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskModel.h"
@interface XuanShangCell_1 : UITableViewCell
@property (nonatomic, strong) TaskModel *model;


+ (XuanShangCell_1 *)cellWithTableView:(UITableView *)tableView;

@end
