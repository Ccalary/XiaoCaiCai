//
//  RewardTaskListVC.h
//  才标网
//
//  Created by caohouhong on 17/3/14.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RewardTaskListVC : UIViewController

/**
  mode:任务模块 1-悬赏任务 2-大师任务
  state:查询状态：1-进行中 2-已结束 不传表示“全部”
 */
- (instancetype)initWithTaskMode:(int)mode andSearchState:(int)state;

@end
