//
//  masterDetailsCell_8.h
//  才标网
//
//  Created by baichun on 17/3/14.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelMember.h"
#import "TTGroupTagView.h"
#import "TaskModel.h"
@interface masterDetailsCell_8 : UITableViewCell

@property (nonatomic, strong) ModelMember *model;

+ (masterDetailsCell_8 *)cellWithTableView:(UITableView *)tableView;
@property (nonatomic, strong)UIImageView *iconImageView;
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong) TTGroupTagView *tagView;
//任务详情大师特点
@property (nonatomic, strong) TaskModel *model1;
@property (nonatomic, strong) UILabel *label;
@end
