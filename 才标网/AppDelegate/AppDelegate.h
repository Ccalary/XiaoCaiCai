//
//  AppDelegate.h
//  我的框架
//
//  Created by liqiang on 16/7/19.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

//极光推送的token
@property (strong, nonatomic) NSString *pushTokenStr;

@end

