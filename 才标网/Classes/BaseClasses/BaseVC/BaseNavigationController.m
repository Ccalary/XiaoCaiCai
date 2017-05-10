//
//  BaseNavigationController.m
//  我的框架
//
//  Created by liqiang on 16/3/24.
//  Copyright © 2016年 Liqiang. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.translucent = NO; //设置为NO之后自动下沉64
   // 添加背景图片－其中UIBarMetricsDefault指的是手机竖直方向的NavigationBar,另外一个常用的UIBarMetricsLandscapePhone指的是手机横向的NavigationBar。
    //这行代码处理添加背景图片6p上显示不全的问题
//    UIImage *bgImage = [[UIImage imageNamed:@"nav_bg_img"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch];
//    [self.navigationBar setBackgroundImage:bgImage forBarMetrics:UIBarMetricsDefault];
    
    //背景色
    self.navigationBar.barTintColor = COLOR_ButtonBackGround_Blue;
    //bar上图标text的颜色
    self.navigationBar.tintColor = COLOR_White;

    
    [self.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:COLOR_White,NSForegroundColorAttributeName,[UIFont fontWithName:@"HelveticaNeue-Bold" size:18],NSFontAttributeName,nil]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([self.viewControllers count] > 0){
        viewController.hidesBottomBarWhenPushed = YES;
        
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_back_white_12x22"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
        viewController.navigationItem.leftBarButtonItem = backItem;
    }
    //一定要写在最后，要不然无效
    [super pushViewController:viewController animated:animated];
}

- (void)backAction{
    [self popViewControllerAnimated:YES];
}

@end
