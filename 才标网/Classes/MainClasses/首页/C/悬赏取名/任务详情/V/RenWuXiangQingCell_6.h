//
//  RenWuXiangQingCell_6.h
//  才标网
//
//  Created by baichun on 17/3/18.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskTouGaoModel.h"
@interface RenWuXiangQingCell_6 : UITableViewCell
+ (RenWuXiangQingCell_6 *)cellWithTableView:(UITableView *)tableView;
@property(nonatomic,strong)TaskTouGaoModel *model;
@property(nonatomic,strong)UIImageView *iconImageView;
@property(nonatomic,strong)UILabel *iphoneLabel;
@property(nonatomic,strong)UIImageView *sexImabeView;
@property(nonatomic,strong)UILabel *timeLabel;
@property(nonatomic,strong)UILabel *queryLabel;
-(void)setTaskTouGaoModel:(TaskTouGaoModel *)model;
@end
