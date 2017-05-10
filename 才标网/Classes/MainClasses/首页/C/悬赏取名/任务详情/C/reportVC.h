//
//  reportVC.h
//  才标网
//
//  Created by baichun on 17/3/27.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "MainBaseViewController.h"

@interface reportVC : MainBaseViewController
@property (nonatomic,copy)NSString *str;

@property (nonatomic,assign) int TouGaoId; //投稿ID 或任务ID
@property (nonatomic,strong) NSString *brandName;

//1-悬赏任务 2-大师任务 3-投稿任务
@property (nonatomic, strong) NSString *entityMode;
@end
