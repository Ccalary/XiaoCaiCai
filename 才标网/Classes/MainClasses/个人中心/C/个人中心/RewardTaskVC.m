//
//  RewardTaskVC.m
//  才标网
//
//  Created by caohouhong on 17/3/14.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "RewardTaskVC.h"
#import "CorePagesView.h"
#import "RewardTaskListVC.h"


@interface RewardTaskVC ()
@property (nonatomic,strong) CorePagesView *pagesView;
@end

@implementation RewardTaskVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"悬赏任务";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)loadView{
    self.view = self.pagesView;
}

-(CorePagesView *)pagesView{
    
    if(_pagesView==nil){
        
        /**
         mode:任务模块 1-悬赏任务 2-大师任务
         state:查询状态：1-进行中 2-已结束 不传表示“全部”
         */
        RewardTaskListVC *tvc1 = [[RewardTaskListVC alloc] initWithTaskMode:1 andSearchState:0];
        RewardTaskListVC *tvc2 = [[RewardTaskListVC alloc] initWithTaskMode:1 andSearchState:1];
        RewardTaskListVC *tvc3 = [[RewardTaskListVC alloc] initWithTaskMode:1 andSearchState:2];
        
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
