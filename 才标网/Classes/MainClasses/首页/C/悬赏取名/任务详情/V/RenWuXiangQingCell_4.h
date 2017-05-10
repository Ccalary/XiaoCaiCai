//
//  RenWuXiangQingCell_4.h
//  才标网
//
//  Created by baichun on 17/3/13.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskTouGaoModel.h"
@interface RenWuXiangQingCell_4 : UITableViewCell
+ (RenWuXiangQingCell_4 *)cellWithTableView:(UITableView *)tableView;
@property(nonatomic,strong)UIImageView *iconImageView;
@property(nonatomic,strong)UILabel *iphoneLabel;
@property(nonatomic,strong)UIImageView *sexImabeView;
@property(nonatomic,strong)UILabel *timeLabel;
@property(nonatomic,strong)UILabel *queryLabel;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UILabel *adoptLabl;
@property(nonatomic,strong)UILabel *explainLabel;

-(void)setTaskTouGaoModel:(TaskTouGaoModel *)model;
@end
