//
//  BaseTabbarController.m
//  才标网
//
//  Created by caohouhong on 17/4/17.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "BaseTabbarController.h"
#import "BaseNavigationController.h"
#import "MainVC.h"
#import "UserCenterVC.h"
#import "BrandMainVC.h"
#import "SearchViewController.h"

@interface BaseTabbarController ()

@end

@implementation BaseTabbarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    UITabBar *tabbar = [UITabBar appearance];
    tabbar.tintColor = HEXCOLOR(0x397fff);
    
    [self addChildViewControllers];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//添加子控制器
- (void)addChildViewControllers{
    [self addChildrenViewController:[[SearchViewController alloc] init] andTitle:@"查询" andImageName:@"tab_search" andSelectImage:@"tab_search_pre"];
    [self addChildrenViewController:[[MainVC alloc] init] andTitle:@"起名" andImageName:@"tab_home" andSelectImage:@"tab_home_pre"];
    [self addChildrenViewController:[[BrandMainVC alloc] init] andTitle:@"商标" andImageName:@"tab_brand" andSelectImage:@"tab_brand_pre"];
    [self addChildrenViewController:[[UserCenterVC alloc] init] andTitle:@"我" andImageName:@"tab_me" andSelectImage:@"tab_me_pre"];
}

- (void)addChildrenViewController:(UIViewController *)childVC andTitle:(NSString *)title andImageName:(NSString *)imageName andSelectImage:(NSString *)selectedImage{
    childVC.tabBarItem.image = [UIImage imageNamed:imageName];
    childVC.tabBarItem.selectedImage =  [UIImage imageNamed:selectedImage];
    childVC.title = title;
    
    BaseNavigationController *baseNav = [[BaseNavigationController alloc] initWithRootViewController:childVC];
    
    [self addChildViewController:baseNav];
}
@end
