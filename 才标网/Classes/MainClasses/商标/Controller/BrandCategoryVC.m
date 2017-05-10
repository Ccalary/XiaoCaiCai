//
//  BrandCategoryVC.m
//  才标网
//
//  Created by caohouhong on 17/3/15.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "BrandCategoryVC.h"
#import "CorePagesView.h"
#import "BrandCateListVC.h"

@interface BrandCategoryVC ()
@property (nonatomic,strong) CorePagesView *pagesView;
@end

@implementation BrandCategoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"商品分类";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (void)loadView{
    self.view=self.pagesView;
}

-(CorePagesView *)pagesView{
    
    if(_pagesView==nil){
        
        BrandCateListVC *tvc1 = [[BrandCateListVC alloc] initWithProduct:0];
        BrandCateListVC *tvc2 = [[BrandCateListVC alloc] initWithProduct:1];
        
        
        CorePageModel *model1=[CorePageModel model:tvc1 pageBarName:@"平台服务"];
        CorePageModel *model2=[CorePageModel model:tvc2 pageBarName:@"商标转让"];
        
        
        NSArray *pageModels=@[model1,model2];
        
        
        //自定义配置
        CorePagesViewConfig *config = [[CorePagesViewConfig alloc] init];
        
        config.isBarBtnUseCustomWidth = YES;
        
        config.barBtnWidth = [UIScreen mainScreen].bounds.size.width/2;
        
        config.barViewH = 45*UIRate;
        
        _pagesView=[CorePagesView viewWithOwnerVC:self pageModels:pageModels config:config];
        
    }
    
    return _pagesView;
}





@end
