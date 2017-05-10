//
//  RenWuXiangQingCell_1.h
//  才标网
//
//  Created by baichun on 17/3/8.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskModel.h"
#define SScreen_Width [UIScreen mainScreen].bounds.size.width

@interface RenWuXiangQingCell_1 : UITableViewCell

+ (RenWuXiangQingCell_1 *)cellWithTableView:(UITableView *)tableView;

-(void)setTaskModel:(TaskModel *)model;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *tagLabel;
@property(nonatomic,strong)UILabel *priceLable;
@property(nonatomic,strong)UILabel *touGaoLabel;
@property(nonatomic,strong)UILabel *stop;
@property(nonatomic,strong)UILabel *stop1;


@end
