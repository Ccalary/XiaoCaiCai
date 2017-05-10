//
//  PushMessageVC.h
//  才标网
//
//  Created by baichun on 17/4/12.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "MainBaseViewController.h"


@protocol PushMessageDelegate <NSObject>

-(void)exit;

@end

@interface PushMessageVC : MainBaseViewController

@property (nonatomic,weak) id<PushMessageDelegate>delegate;

@end
