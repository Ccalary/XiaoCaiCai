//
//  EditpageVC.h
//  才标网
//
//  Created by baichun on 17/3/24.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "MainBaseViewController.h"
#import "TaskTouGaoModel.h"
@interface EditpageVC : MainBaseViewController
@property (nonatomic,assign) int TouGaoId;
@property (nonatomic,strong) TaskTouGaoModel *model;
@end
