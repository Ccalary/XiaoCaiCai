//
//  BrandMainVC.m
//  才标网
//
//  Created by caohouhong on 17/3/15.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "BrandMainVC.h"
#import "BrandMainTopView.h"
#import "BrandMainCollectionViewCell.h"
#import "SaleBrandVC.h"
#import "BrandSearchVC.h"
#import "BrandCategoryVC.h"
#import "BrandProductDetailVC.h"
#import "CBConnect.h"
#import "ProductModel.h"
#import "CNPPopupController.h"
#import "NamedSearchPopView.h"
#import "HomeAdsModel.h"
#import "ServiceVC.h"
#import "RenWuXiangQingVC.h"
#import "masterDetailsVC.h"
#import "BrandProductDetailVC.h"
#import "BaseWebViewController.h"
@interface BrandMainVC ()<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate, UICollectionViewDataSource,BrandMainTopViewDelegate>
@property (nonatomic, strong) UICollectionView *mCollectionView;
@property (nonatomic, strong) BrandMainTopView *headerView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSArray *imageArray;

@property (nonatomic, strong) CNPPopupController *popupController;
@property (nonatomic, strong) NamedSearchPopView *popView;
@end

@implementation BrandMainVC
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NamedSearchPopView *)popView{
    if (!_popView){
        _popView = [[NamedSearchPopView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth - 50*UIRate, 290*UIRate)];
        __weak typeof (self) weakSelf = self;
        _popView.closeBlock = ^(){
            [weakSelf.popupController dismissPopupControllerAnimated:YES];
        };
        
        _popView.searchBlock = ^(NSString *brandName, NSString *name, NSString *phoneNum){
            [weakSelf requestResultDataWithBrandName:brandName andName:name andPhone:phoneNum];
            [weakSelf.popupController dismissPopupControllerAnimated:YES];
        };
    }
    return _popView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = HEXCOLOR(0xf0f0f0);
    self.navigationItem.title = @"商标";
    [self drawView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self requestData];
}

- (void)drawView{
    

    CGFloat ItemWidth = ScreenWidth ;
    CGFloat ItemHeight = 140*UIRate;
    UICollectionViewFlowLayout * aLayOut = [[UICollectionViewFlowLayout alloc]init];
    aLayOut.itemSize = CGSizeMake(ItemWidth, ItemHeight);
    aLayOut.minimumLineSpacing = 10*UIRate;
    aLayOut.minimumInteritemSpacing = 1;
    aLayOut.scrollDirection = UICollectionViewScrollDirectionVertical;
    _mCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:aLayOut];
    [_mCollectionView registerClass:[BrandMainCollectionViewCell class] forCellWithReuseIdentifier:@"CellIdentifier"];
    [_mCollectionView registerClass:[BrandMainTopView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HEADER"];
    _mCollectionView.delegate = self;
    _mCollectionView.dataSource = self;
    _mCollectionView.showsVerticalScrollIndicator = NO;
    _mCollectionView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_mCollectionView];
    
    _mCollectionView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,0)
    .bottomSpaceToView(self.view,0);

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
    BrandMainCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CellIdentifier" forIndexPath:indexPath];
     cell.model = self.dataArray[indexPath.row];
    
    return cell;
}

//header、footer的加载
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqual:UICollectionElementKindSectionHeader] ) {
        self.headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HEADER" forIndexPath:indexPath];
        self.headerView.delegate = self;
        
        return self.headerView;
    }
    
    return nil;
}

//header的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(SCREEN_WIDTH, 115*UIRate);
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
   [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    HomeAdsModel *model = self.dataArray[indexPath.row];
    switch (model.adType) {
        case -8:
        {
          //无指向
        }
            break;
        case -9:
        {
         //外网连接
            if (model.adLink) {
                
                BaseWebViewController *webVC = [[BaseWebViewController alloc] initWithTitle:model.adName andUrl: model.adLink];
                
                [self.navigationController pushViewController:webVC animated:YES];
            }
           
        }
            break;
        case 1:
        {
          //悬赏任务详情
            RenWuXiangQingVC *vc = [[RenWuXiangQingVC alloc]init];
            vc.taskId = model.refEntityId;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:
        {
          //大师任务
            masterDetailsVC *vc = [[masterDetailsVC alloc]init];
            vc.taskId = model.refEntityId;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 6:
        {
            //商品
            BrandProductDetailVC *vc = [[BrandProductDetailVC alloc]init];
            vc.product_id = [NSString stringWithFormat:@"%d",model.refEntityId];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
}

#pragma mark - BrandMainTopViewDelegate
- (void)brandMainTopViewClickButtonWithTag:(BrandMainTopViewBtnType)tag
{
    switch (tag) {
        case BrandMainTopViewBtnTypeSearch: //商标购买
        {            
            self.popView.titleLabel.text = @"商标购买";
            self.popView.titleLabel.textAlignment = NSTextAlignmentCenter;
            [self.popView.btn setTitle:@"提交" forState:UIControlStateNormal];
            self.popupController = [[CNPPopupController alloc] initWithContents:@[self.popView]];
            self.popupController.theme.popupStyle = CNPPopupStyleCentered;
            self.popupController.theme.presentationStyle = CNPPopupPresentationStyleSlideInFromTop;
            self.popupController.theme.dismissesOppositeDirection = YES;
            [self.popupController presentPopupControllerAnimated:YES];

            
        }
            break;
        case BrandMainTopViewBtnTypeCategory://商品分类
        {
            BrandCategoryVC *vc = [[BrandCategoryVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case BrandMainTopViewBtnTypeSale://出售商标
        {   SaleBrandVC *vc = [[SaleBrandVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
}

#pragma mark ===========网络================
- (void)requestData{
    
    [LCProgressHUD showLoading:@"加载中..."];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setValue:@(3) forKey:@"adPosition"];
    
    [CBConnect getBrandAdListads:params success:^(id responseObject) {
             NSArray *array = [HomeAdsModel mj_objectArrayWithKeyValuesArray:responseObject ];
        [self.dataArray removeAllObjects];
        [self.dataArray addObjectsFromArray:array];
        [self.mCollectionView reloadData];
    } successBackfailError:^(id responseObject) {
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
    
//    [CBConnect getProutProducts:params success:^(id responseObject) {
//     NSArray *array = [ProductModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
//       
//        [self.dataArray removeAllObjects];
//        [self.dataArray addObjectsFromArray:array];
//        [self.mCollectionView reloadData];
//    } successBackfailError:^(id responseObject) {
//     
//    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
//     
//    }];
    
}
//结果查询
- (void)requestResultDataWithBrandName:(NSString *)brandName andName:(NSString *)name andPhone: (NSString *)phoneNum{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:brandName forKey:@"buy_remarks"];
    [params setValue:name forKey:@"buy_name"];
    [params setValue:phoneNum forKey:@"buy_phone"];
    
    [CBConnect getHomeBuyTradeMark:params success:^(id responseObject) {
        
        [LCProgressHUD showSuccess:@"提交成功"];
        
    } successBackfailError:^(id responseObject) {
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}
@end
