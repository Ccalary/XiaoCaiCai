//
//  ShowMoreTextVC.m
//  才标网
//
//  Created by caohouhong on 17/4/8.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "ShowMoreTextVC.h"
#import "NavigationView.h"

@interface ShowMoreTextVC ()

@end

@implementation ShowMoreTextVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationItem.title = self.titleStr;
    [self drawView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)drawView{
    
    //处理Nav
    __weak typeof (self) weakSelf = self;
    NavigationView *nav = [[NavigationView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64) andTitle:self.titleStr block:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    [self.view addSubview:nav];
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(10*UIRate, 10*UIRate + 64, ScreenWidth - 20*UIRate, ScreenHeight - 10*UIRate)];
    textView.editable = NO;
    textView.font = SYSTEM_FONT_(15*UIRate);
    textView.text = self.textStr;
    textView.textColor = COLOR_darkGray;
    [self.view addSubview:textView];
    
}

@end
