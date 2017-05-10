//
//  GuideVC.h
//  才标网
//
//  Created by baichun on 17/4/11.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "MainBaseViewController.h"

@protocol GuideVCDelegate <NSObject>

- (void)enterTheApp;

@end

@interface GuideVC : UIViewController

@property (nonatomic, weak) id<GuideVCDelegate> delegate;
@end
