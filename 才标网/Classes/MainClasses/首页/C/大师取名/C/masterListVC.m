//
//  masterListVC.m
//  才标网
//
//  Created by baichun on 17/3/13.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "masterListVC.h"
#import "masterListCell.h"
#import "informationVC.h"
#import "CBConnect.h"
#import "ModelMember.h"
#import "UserHelper.h"
#import "LoginViewController.h"
@interface masterListVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)UICollectionView *collectionView;

@property (nonatomic, assign) int pageNo;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation masterListVC

- (NSMutableArray *)dataArray
{
    if (!_dataArray){
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"大师列表";
    self.pageNo = 1;
    [self drawView];
    [self requestData];

}
-(void)drawView{

    //1.初始化layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    CGFloat itemWidth = (ScreenWidth - 20*UIRate)/2.0;
    
    //设置collectionView滚动方向
    //    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    //设置headerView的尺寸大小
//    layout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, 100);
    //该方法也可以设置itemSize
    layout.itemSize =CGSizeMake(itemWidth, 255*UIRate);
    layout.minimumLineSpacing = 10*UIRate;
    layout.minimumInteritemSpacing = 5*UIRate;

    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerClass:[masterListCell class]forCellWithReuseIdentifier:@"cell"];
    
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    self.collectionView.backgroundColor = COLOR_BackgroundColor;
 
    collectionView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,0)
    .bottomSpaceToView(self.view,0);
    
    //上拉加载，下拉刷新
    __weak typeof(self) weakSelf = self;
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.pageNo = 1;
        [weakSelf requestData];
    }];
    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        weakSelf.pageNo ++;
        [weakSelf requestData];
    }];

}

#pragma mark collectionView代理方法
//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5*UIRate, 5*UIRate, 5*UIRate, 5*UIRate);
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    masterListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.masterModel = self.dataArray[indexPath.row];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
  
    ModelMember *model = self.dataArray[indexPath.row];
    informationVC *vc = [[informationVC alloc]init];
    vc.memberId = model.memberId;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - ===========大师列表网络请求===========
- (void)requestData
{
    [LCProgressHUD showLoading:@"正在加载..."];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:@(self.pageNo) forKey:@"pageNo"];
    [params setValue:@(10) forKey:@"pageSize"];
    
    [CBConnect getHomeListDashiMember:params success:^(id responseObject) {
        
        if (self.pageNo == 1)
        {
            [self.dataArray removeAllObjects];
        }
        
        NSArray *array = [ModelMember mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"] ];
        
        [self.dataArray addObjectsFromArray:array];
        
        [self.collectionView reloadData];
        [self.collectionView.mj_footer endRefreshing];
        [self.collectionView.mj_header endRefreshing];
        
        if (array.count < 10)
        {
            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
        }
        
    } successBackfailError:^(id responseObject) {
        
        [self.collectionView.mj_footer endRefreshing];
        [self.collectionView.mj_header endRefreshing];

    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}

@end
