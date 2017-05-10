//
//  addedVC.m
//  才标网
//
//  Created by baichun on 17/3/28.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "addedVC.h"
#import "reportVC.h"


@interface addedVC ()
@property (nonatomic,strong)UITextView *tView;
@end

@implementation addedVC

- (void)viewDidLoad {
    [super viewDidLoad];
     self.navigationItem.title = @"补充说明";
    [self drawView];
    self.view.backgroundColor = COLOR_BackgroundColor;
}
-(void)drawView{
    self.tView = [[UITextView alloc]init];
    _tView.placeholder = @"补充说明";
    [self.view addSubview:_tView];
    _tView.sd_layout
    .leftSpaceToView(self.view,15*UIRate)
    .rightSpaceToView(self.view,15*UIRate)
    .topSpaceToView(self.view,30*UIRate)
    .heightIs(200*UIRate);
    
    UIButton *releaseBtn = [[UIButton alloc]init];
    [releaseBtn setTitle:@"确定" forState:UIControlStateNormal];
    [releaseBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    releaseBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    
    releaseBtn.backgroundColor = HEXCOLOR(0xff5c0b);
    [releaseBtn addTarget:self action:@selector(footViewAction) forControlEvents:UIControlEventTouchUpInside];
    releaseBtn.layer.cornerRadius = 10;
    releaseBtn.clipsToBounds = YES;
    [self.view addSubview:releaseBtn];
    releaseBtn.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(_tView,20*UIRate)
    .widthIs(100*UIRate)
    .heightIs(30*UIRate);
    
    
}
-(void)footViewAction{
    reportVC *setPrizeVC = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
    
    setPrizeVC.str = nil;
    if (self.tView.text.length != 0) {
        setPrizeVC.str = self.tView.text;
    }
    [self.navigationController
     popToViewController:setPrizeVC animated:true];

    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
