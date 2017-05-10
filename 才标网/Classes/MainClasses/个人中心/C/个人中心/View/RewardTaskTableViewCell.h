//
//  RewardTaskTableViewCell.h
//  才标网
//
//  Created by caohouhong on 17/3/14.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskModel.h"

@interface RewardTaskTableViewCell : UITableViewCell

@property (nonatomic, strong) TaskModel *taskModel;

@property (nonatomic, strong) TaskModel *myContriModel;

@property (nonatomic, strong) TaskModel *masterTaskModel;

@property (nonatomic, strong) TaskModel *amMasterModel;
@end
