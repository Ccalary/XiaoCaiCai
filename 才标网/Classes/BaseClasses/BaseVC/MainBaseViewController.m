//
//  MainBaseViewController.m
//  lingdaozhe
//
//  Created by liqiang on 16/5/5.
//  Copyright © 2016年 bckj. All rights reserved.
//

#import "MainBaseViewController.h"
#import "LCProgressHUD.h"

@interface MainBaseViewController ()

@end

@implementation MainBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.automaticallyAdjustsScrollViewInsets = NO;
    self.tabBarController.automaticallyAdjustsScrollViewInsets = NO;
    
    self.supportPortraitOnly = YES;
    self.view.backgroundColor = COLOR_BackgroundColor;
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
 
    self.NavLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, ScreenWidth, 0.5)];
    self.NavLineView.backgroundColor = COLOR_LineViewColor;
    [self.navigationController.navigationBar addSubview:self.NavLineView];

}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

@end
