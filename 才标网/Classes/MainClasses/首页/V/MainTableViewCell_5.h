//
//  MainTableViewCell_5.h
//  才标网
//
//  Created by 李强 on 2017/2/15.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskModel.h"

@interface MainTableViewCell_5 : UITableViewCell

@property (nonatomic, strong) TaskModel *model;

+ (MainTableViewCell_5 *)cellWithTableView:(UITableView *)tableView;

@end
