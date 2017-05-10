//
//  RenWuXiangQingCell_3.h
//  才标网
//
//  Created by baichun on 17/3/13.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskTouGaoModel.h"
typedef void(^trademarkBlock)(NSString *nameStr);
typedef void(^adoptBlock)();
typedef void(^reportBlock)(int ,NSString *);


@interface RenWuXiangQingCell_3 : UITableViewCell
+ (RenWuXiangQingCell_3 *)cellWithTableView:(UITableView *)tableView;
@property (nonatomic,strong) UIImageView *iconImageView;
@property (nonatomic,strong) UILabel *iphoneLabel;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UILabel *queryLabel;
@property (nonatomic,strong) UIButton *trademarkBtn;
@property (nonatomic,strong) UIButton *trademarkBtn1;
//商标注册
@property (nonatomic,copy) trademarkBlock trademarblock;
//采纳
@property (nonatomic,copy) adoptBlock adoptblock;
//举报
@property (nonatomic,copy) reportBlock reporblock;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UIButton *adoptBtn;
@property (nonatomic,strong) UILabel *explainLabel;
@property (nonatomic, strong) TaskTouGaoModel *model;

-(void)setTaskTouGao:(TaskTouGaoModel *)model isXuanShangFenQian:(int)isFenQian;
@end
