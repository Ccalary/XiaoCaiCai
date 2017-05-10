//
//  MyContributeVC.m
//  才标网
//
//  Created by caohouhong on 17/3/18.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "MyContributeVC.h"
#import "CorePagesView.h"
#import "MyContributeListVC.h"

@interface MyContributeVC ()
@property (nonatomic,strong) CorePagesView *pagesView;

@end

@implementation MyContributeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的投稿";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (void)loadView{
    self.view=self.pagesView;
}

-(CorePagesView *)pagesView{
    
    if(_pagesView==nil){
        
        /**
         state:查询状态：1-进行中 2-已结束 不传表示“全部”
         */
        MyContributeListVC *tvc1 = [[MyContributeListVC alloc] initWithSearchState:0];
        MyContributeListVC *tvc2 = [[MyContributeListVC alloc] initWithSearchState:1];
        MyContributeListVC *tvc3 = [[MyContributeListVC alloc] initWithSearchState:2];
        
        CorePageModel *model1=[CorePageModel model:tvc1 pageBarName:@"全部"];
        CorePageModel *model2=[CorePageModel model:tvc2 pageBarName:@"进行中"];
        CorePageModel *model3=[CorePageModel model:tvc3 pageBarName:@"已结束"];
        
        NSArray *pageModels=@[model1,model2,model3];
        
        
        //自定义配置
        CorePagesViewConfig *config = [[CorePagesViewConfig alloc] init];
        
        config.isBarBtnUseCustomWidth = YES;
        
        config.barBtnWidth = [UIScreen mainScreen].bounds.size.width/3;
        
        config.barViewH = 50*UIRate;
        
        _pagesView=[CorePagesView viewWithOwnerVC:self pageModels:pageModels config:config];
        
    }
    
    return _pagesView;
}



@end
