//
//  MasterHeard.h
//  才标网
//
//  Created by baichun on 17/3/29.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskTouGaoModel.h"

typedef void(^registeredBlock)();

@interface MasterHeard : UITableViewHeaderFooterView
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *explainLabel;
@property (nonatomic,copy) registeredBlock regisblock;
@property (nonatomic,strong) TaskTouGaoModel *model;

@end
