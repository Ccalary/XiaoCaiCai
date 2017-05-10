//
//  BrandSearchResultVC.m
//  才标网
//
//  Created by caohouhong on 17/3/24.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "BrandSearchResultVC.h"
#import "BrandSearchResultCollectCell.h"
#import "BrandCategoryVC.h"
#import "CBConnect.h"
#import "BrandDetailVC.h"
#import "UserHelper.h"
#import "LoginViewController.h"
#import "RegisterTrademarkVC.h"
#import "XuanShangHeardview.h"
#import "TradeCategoryVC.h"

@interface BrandSearchResultVC ()<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate, UICollectionViewDataSource,XuanShangHeardviewDelegate,BrandSearchResultCollectCellDelegate>
@property (nonatomic, strong) UICollectionView *mCollectionView;

@property (nonatomic, strong) UILabel *topLabel;

@property (nonatomic, assign) int pageNo;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) NSArray *titleA;

@property (nonatomic, strong) XuanShangHeardview *topMenu;

@property (nonatomic, assign) int pageSize;

@property (nonatomic, strong) NSString *cxclsType; //查询类别，先不传

@property (nonatomic, strong) NSString *cxtype;//查询类型
@end

@implementation BrandSearchResultVC

- (NSMutableArray *)dataArray
{
    if (!_dataArray){
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"检索结果";
    self.pageNo = 1;
    self.pageSize = 10;
    self.cxtype = 0;
    [self drawView];
    
    [LCProgressHUD showLoading:@"加载中..."];
    [self requestData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)drawView{
    
    [self drawTabChooseView];
    [self headerFooterView];
    
    CGFloat ItemWidth = (ScreenWidth)/2.0;
    CGFloat ItemHeight = 175*UIRate;
    UICollectionViewFlowLayout * aLayOut = [[UICollectionViewFlowLayout alloc]init];
    aLayOut.itemSize = CGSizeMake(ItemWidth, ItemHeight);
    aLayOut.minimumLineSpacing = 20*UIRate;
    aLayOut.minimumInteritemSpacing = 0;
    aLayOut.scrollDirection = UICollectionViewScrollDirectionVertical;
    _mCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:aLayOut];
    [_mCollectionView registerClass:[BrandSearchResultCollectCell class] forCellWithReuseIdentifier:@"CellIdentifier"];
    _mCollectionView.delegate = self;
    _mCollectionView.dataSource = self;
    _mCollectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_mCollectionView];
    
    _mCollectionView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,85*UIRate)
    .bottomSpaceToView(self.view,100*UIRate);
    
    //上拉加载，下拉刷新
    __weak typeof(self) weakSelf = self;
    _mCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.pageNo = 1;
        [weakSelf requestData];
    }];
    _mCollectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        weakSelf.pageNo ++;
        [weakSelf requestData];
    }];
}

//头部筛选框
- (void)drawTabChooseView
{
    self.titleA = @[@[@""],@[@"全部",@"注册号码",@"商标名称",@"申请人"]];
    self.topMenu = [[XuanShangHeardview alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 50*UIRate) withTitle:self.titleA withSelectColor:HEXCOLOR(0x4fbbf6)];
    self.topMenu.menuViewDelegate = self;
    [self.view addSubview:self.topMenu];
    
     UIButton *cateButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/2.0, 50*UIRate)];
    cateButton.backgroundColor = [UIColor clearColor];
    [cateButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cateButton.titleLabel.font = SYSTEM_FONT_(15*UIRate);
    [cateButton setTitle:@"行业分类" forState:UIControlStateNormal];
    [cateButton setImage:[UIImage imageNamed:@"icon_xiala2"] forState:UIControlStateNormal];
    
    [cateButton addTarget:self action:@selector(cateButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [cateButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:15];
    [self.view addSubview:cateButton];
    
    UIView *dividerLine1 = [[UIView alloc] init];
    dividerLine1.backgroundColor = COLOR_BackgroundColor;
    [self.view addSubview:dividerLine1];
    
    dividerLine1.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(self.view,5*UIRate)
    .widthIs(1)
    .heightIs(40*UIRate);
}

- (void)headerFooterView{
    _topLabel = [[UILabel alloc] initWithFrame:CGRectMake(10*UIRate, 50*UIRate, 150*UIRate, 35*UIRate)];
    _topLabel.textColor = COLOR_Gray;
    _topLabel.font = SYSTEM_FONT_(15*UIRate);
    _topLabel.text = @"共0条";
    [self.view addSubview:_topLabel];
    
    UIButton *registerBtn = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth - 85*UIRate, CGRectGetMinY(_topLabel.frame), 75*UIRate, 35*UIRate)];
    [registerBtn setTitle:@"注册商标" forState:UIControlStateNormal];
    registerBtn.titleLabel.font = SYSTEM_FONT_(15*UIRate);
    [registerBtn setTitleColor:COLOR_Blue forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(registerBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerBtn];
    
    
    UILabel *bottomTextlabel = [[UILabel alloc] init];
    bottomTextlabel.text = @"搜不到想要的?不如来逛逛商城";
    bottomTextlabel.font = SYSTEM_FONT_(15*UIRate);
    bottomTextlabel.backgroundColor = COLOR_OrangeLight;
    bottomTextlabel.textAlignment = NSTextAlignmentCenter;
    bottomTextlabel.textColor = [UIColor whiteColor];
    [self.view addSubview:bottomTextlabel];
    
    UIButton *mallBtn = [[UIButton alloc] init];
    [mallBtn setImage:[UIImage imageNamed:@"brand_s_shop_77x77"] forState:UIControlStateNormal];
    mallBtn.backgroundColor = [UIColor clearColor];
    [mallBtn addTarget:self action:@selector(mallBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mallBtn];
    
    bottomTextlabel.sd_layout
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .bottomEqualToView(self.view)
    .heightIs(55*UIRate);
    
    mallBtn.sd_layout
    .rightSpaceToView(self.view,15*UIRate)
    .bottomSpaceToView(self.view,20*UIRate)
    .widthIs(77*UIRate)
    .heightIs(77*UIRate);


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
    BrandSearchResultCollectCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CellIdentifier" forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.row];
    cell.indexPath = indexPath;
    cell.dividerLine4.hidden = (indexPath.row % 2 == 0) ? NO : YES;
    cell.delegate = self;
    return cell;
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    BrandSearchModel *model = self.dataArray[indexPath.row];
    
    BrandDetailVC *vc = [[BrandDetailVC alloc] init];
    vc.cxkeyNum = model.cxkey;
    vc.intcls = model.intcls;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -
- (void)pullDownMenuView:(XuanShangHeardview *)menu didSelectedIndex:(NSIndexPath *)indexPath{
    //选择的

    self.cxtype = [NSString stringWithFormat:@"%li",(long)indexPath.section];
    _pageNo = 1;
    [LCProgressHUD showLoading:@"加载中..."];
    [self requestData];
}

#pragma mark - BrandSearchResultCollectCellDelegate cell代理
- (void)onFavourButtonClick:(BrandSearchResultCollectCell *)cell{
    
    // 是否收藏 优先判断是否登录
    if (![UserHelper IsLogin]){
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        BaseNavigationController *baseNav = [[BaseNavigationController alloc] initWithRootViewController:loginVC];
        [self presentViewController:baseNav animated:YES completion:nil];
        return;
    }
    
    if (cell.indexPath.row < [self.dataArray count]) {
        BrandSearchModel *model = self.dataArray[cell.indexPath.row];
        
        NSString *follow = [model.follow isEqualToString:@"false"] ? @"true" : @"false";
        model.follow = follow;//更改本地数据
        
        if ([model.follow isEqualToString:@"true"]){
            [self requestCollectDataWithModel:model andCell:cell];
        }else {
            [self requestUncollectDataWithModel:model andCell:cell];
        }
    }
}

#pragma mark - Action
//注册商标
- (void)registerBtnAction{
    
    RegisterTrademarkVC *vc = [[RegisterTrademarkVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

//商城
- (void)mallBtnAction{
    BrandCategoryVC *vc = [[BrandCategoryVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

//商标分类
- (void)cateButtonAction{
    
    TradeCategoryVC *vc = [[TradeCategoryVC alloc] init];
    vc.selectedStr = self.cxclsType;
    __weak typeof (self) weakSelf = self;
    vc.block = ^(NSString *str){
        weakSelf.cxclsType = str;
        _pageNo = 1;
        [LCProgressHUD showLoading:@"加载中..."];
        [weakSelf requestData];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - ===========网络请求============

- (void)requestData{
    if (self.mTextField.length){
        [self requestKeywordData];
    }else {
        [self requestImageData];
    }
}

//图形检索
- (void)requestImageData{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    if (self.cxclsType.length){
        [params setValue:self.cxclsType forKey:@"cxcls"];//查询类别（全类：空；单类：01；多类：02,12,22）
    }
    [params setValue:self.cxtype forKey:@"cxtype"];//查询类型（1：注册号码；2：商标名称；3：申请人此处传2
    [params setValue:@(_pageNo) forKey:@"pageNo"];
    [params setValue:@(self.pageSize) forKey:@"pageSize"];
    [CBConnect getBrandByImage:params imageArray:self.imageViewArray isNone:NO success:^(id responseObject) {
        
        if (self.pageNo == 1)
        {
            [self.dataArray removeAllObjects];
        }
        
        NSArray *array = [BrandSearchModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
        [self.dataArray addObjectsFromArray:array];
        _topLabel.text = [NSString stringWithFormat:@"共%ld条",(unsigned long)self.dataArray.count];
        [self.mCollectionView reloadData];
        [self.mCollectionView.mj_footer endRefreshing];
        [self.mCollectionView.mj_header endRefreshing];
        
        if (array.count < self.pageSize)
        {
            [self.mCollectionView.mj_footer endRefreshingWithNoMoreData];
        }
        
    } successBackfailError:^(id responseObject) {
        [self.mCollectionView.mj_footer endRefreshing];
        [self.mCollectionView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}

//关键字检索
- (void)requestKeywordData{
    
    NSMutableDictionary *params = [CBConnect getBaseRequestParams];
    if (self.cxclsType.length){
        [params setValue:self.cxclsType forKey:@"cxcls"];//查询类别（全类：空；单类：01；多类：02,12,22）
    }
    [params setValue:self.cxtype forKey:@"cxtype"];//查询类型（1：注册号码；2：商标名称；3：申请人此处传2
    [params setValue:self.mTextField forKey:@"key"];
    [params setValue:@(_pageNo) forKey:@"pageNo"];
    [params setValue:@(self.pageSize) forKey:@"pageSize"];
    
    [CBConnect getBrandByword:params success:^(id responseObject) {
        
    if (self.pageNo == 1)
    {
        [self.dataArray removeAllObjects];
    }
   
    NSArray *array = [BrandSearchModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
    [self.dataArray addObjectsFromArray:array];
    _topLabel.text = [NSString stringWithFormat:@"共%ld条",self.dataArray.count];

    [self.mCollectionView reloadData];
    [self.mCollectionView.mj_footer endRefreshing];
    [self.mCollectionView.mj_header endRefreshing];
    
    if (array.count < self.pageSize)
    {
        [self.mCollectionView.mj_footer endRefreshingWithNoMoreData];
    }

    } successBackfailError:^(id responseObject) {
        [self.mCollectionView.mj_footer endRefreshing];
        [self.mCollectionView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}

#pragma mark - =================是否收藏=================
//收藏
- (void)requestCollectDataWithModel:(BrandSearchModel *)model andCell:(BrandSearchResultCollectCell *)cell{

    NSMutableDictionary *params = [CBConnect getBaseRequestParams];
    [params setValue:model.cxkey forKey:@"cxkey"];//商标注册号
    [params setValue:model.intcls forKey:@"intcls"];//商标国际分类

    [CBConnect getBrandCollectTradeMark:params success:^(id responseObject) {
        
         [self.mCollectionView reloadItemsAtIndexPaths:@[cell.indexPath]];
    } successBackfailError:^(id responseObject) {
         model.follow = @"false";//失败的话则恢复原来的值
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}

//取消收藏
- (void)requestUncollectDataWithModel:(BrandSearchModel *)model andCell:(BrandSearchResultCollectCell *)cell{
    
    NSMutableDictionary *params = [CBConnect getBaseRequestParams];
    [params setValue:model.cxkey forKey:@"cxkey"];//商标注册号
    [params setValue:model.intcls forKey:@"intcls"];//商标国际分类
    
    [CBConnect getBrandUncollectTradeMark:params success:^(id responseObject) {
         [self.mCollectionView reloadItemsAtIndexPaths:@[cell.indexPath]];

    } successBackfailError:^(id responseObject) {
        model.follow = @"true";//失败的话则恢复原来的值
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}
@end
