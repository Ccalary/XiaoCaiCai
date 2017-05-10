//
//  LQAppFrameTabBarController.m
//  我的框架
//
//  Created by liqiang on 16/3/24.
//  Copyright © 2016年 Liqiang. All rights reserved.
//

#import "LQAppFrameTabBarController.h"
#import "BaseNavigationController.h"
#import "MainVC.h"
#import "UserCenterVC.h"
#import "BrandMainVC.h"

#define kClassKey   @"rootVCClassString"
#define kTitleKey   @"title"
#define kImgKey     @"imageName"
#define kSelImgKey  @"selectedImageName"
#define kSupportPortraitOnly @"supportPortraitOnly"

@interface LQAppFrameTabBarController ()

@end

@implementation LQAppFrameTabBarController

//+ (instancetype)sharedMainTabBar
//{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        mainTabBar = [[LQAppFrameTabBarController alloc] init];
//    
//    });
//    return mainTabBar;
//}
//
//+ (instancetype)updataTabBar
//{
//    mainTabBar = [[LQAppFrameTabBarController alloc] init];
//    return mainTabBar;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    UITabBar *tabbar = [UITabBar appearance];
    tabbar.tintColor = HEXCOLOR(0x0090ff);
    
    [self addChildViewControllers];
    
}

//添加子控制器
- (void)addChildViewControllers{
    [self addChildrenViewController:[[MainVC alloc] init] andTitle:@"查询" andImageName:@"tab_home" andSelectImage:@"tab_home_pre"];
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
