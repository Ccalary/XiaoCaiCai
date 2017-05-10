//
//  BrandCateListVC.m
//  才标网
//
//  Created by caohouhong on 17/3/15.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "BrandCateListVC.h"
#import "BrandCateCollectionViewCell.h"
#import "BrandProductDetailVC.h"
#import "CBConnect.h"
#import "ProductModel.h"
@interface BrandCateListVC ()<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *mCollectionView;
@property (nonatomic, assign) int pageNo;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) int type;// 0平台服务  1商标转让

@end

@implementation BrandCateListVC

- (instancetype)initWithProduct:(int)type
{
    self = [super init];
    if (self){
        self.type = type;
    }
    return self;
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray){
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_BackgroundColor;
    [self drawView];
    _pageNo = 1;
    [LCProgressHUD showLoading:@"加载中..."];
    [self requestData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)drawView{
    
    CGFloat ItemWidth = (ScreenWidth - 1)/2.0;
    CGFloat ItemHeight = 185*UIRate;
    UICollectionViewFlowLayout * aLayOut = [[UICollectionViewFlowLayout alloc]init];
    aLayOut.itemSize = CGSizeMake(ItemWidth, ItemHeight);
    aLayOut.minimumLineSpacing = 1*UIRate;
    aLayOut.minimumInteritemSpacing = 1;
    aLayOut.scrollDirection = UICollectionViewScrollDirectionVertical;
    _mCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:aLayOut];
    [_mCollectionView registerClass:[BrandCateCollectionViewCell class] forCellWithReuseIdentifier:@"CellIdentifier"];
    _mCollectionView.delegate = self;
    _mCollectionView.dataSource = self;
    _mCollectionView.backgroundColor = COLOR_BackgroundColor;
    [self.view addSubview:_mCollectionView];
    
    _mCollectionView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,10*UIRate)
    .bottomSpaceToView(self.view,0);
    
    __weak typeof (self) weakSelf = self;
    _mCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.pageNo = 1;
        [weakSelf requestData];
        
    }];
    _mCollectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        weakSelf.pageNo ++;
        [weakSelf requestData];
    }];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

//cell的记载
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BrandCateCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CellIdentifier" forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ProductModel *model = self.dataArray[indexPath.row];
    
    BrandProductDetailVC *vc = [[BrandProductDetailVC alloc] init];
    vc.product_id = model.product_id;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark ============网络=================

- (void)requestData{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setValue:@(self.type) forKey:@"category_buy"];
    [params setValue:@(_pageNo) forKey:@"pageNo"];
    [params setValue:@(10) forKey:@"pageSize"];
   [CBConnect getProutServices:params success:^(id responseObject) {
       
       if (self.pageNo == 1)
       {
           [self.dataArray removeAllObjects];
       }
        NSArray *array = [ProductModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
       
       [self.dataArray addObjectsFromArray:array];
       [self.mCollectionView reloadData];
       [self.mCollectionView.mj_footer endRefreshing];
       [self.mCollectionView.mj_header endRefreshing];
       
       if (array.count < 10)
       {
           [self.mCollectionView.mj_footer endRefreshingWithNoMoreData];
       }

   } successBackfailError:^(id responseObject) {
       [self.mCollectionView.mj_footer endRefreshing];
       [self.mCollectionView.mj_header endRefreshing];
   } failure:^(NSURLSessionDataTask *operation, NSError *error) {
       
   }];
}

@end
