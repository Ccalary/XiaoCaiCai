//
//  MainVC.m
//  才标网
//
//  Created by 李强 on 2017/2/15.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "MainVC.h"
#import "MainTableViewCell_1.h"
#import "MainTableViewCell_2.h"
#import "MainTableViewCell_3.h"
#import "MainTableViewCell_5.h"
#import "XuanShangQiMingVC.h"
#import "masterListVC.h"
#import "SelfhelpVC.h"
#import "CBConnect.h"
#import "informationVC.h"
#import "queryVC.h"
#import "MainHeaderView.h"
#import <ShareSDK/ShareSDK.h>
#import "HomeAdsModel.h"
#import "BaseWebViewController.h"
#import "ModelMember.h"
#import "TaskModel.h"
#import "RenWuXiangQingVC.h"
#import "MoveButton.h"
#import "ServiceVC.h"
#import "UserHelper.h"
#import "LoginViewController.h"
#import "masterDetailsVC.h"
#import "BrandProductDetailVC.h"

@interface MainVC ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,MainTableViewCell_2Delegate>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) UIView *navView;
@property (nonatomic, strong) NSMutableArray *cellsArray;

@property (nonatomic, strong) NSArray *adsArray;//广告列表
@property (nonatomic, strong) NSArray *xuanShangArray;//悬赏列表
@property (nonatomic, strong) NSArray *dashiArray;//大师列表

@end

@implementation MainVC

- (NSMutableArray *)cellsArray
{
    if (!_cellsArray)
    {
        _cellsArray = [NSMutableArray array];
    }
    
    return _cellsArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.adsArray = [[NSArray alloc] init];
    self.xuanShangArray = [[NSArray alloc] init];
    self.dashiArray = [[NSArray alloc] init];
    
    [self drawView];
    [self updataCells];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //禁止下沉
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
    [self requestHomeData];
}
- (void)drawView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.backgroundColor = HEXCOLOR(0xeeeeee);
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    tableView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,-20)
    .bottomSpaceToView(self.view,0);
    
    _navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    [self setNavBackgroundAlpha:0];
    [self.view addSubview:_navView];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = SYSTEM_FONT_BOLD_(18);
    titleLabel.text = @"起 名";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
    
    //可移动客服
    MoveButton *serviceBtn = [[MoveButton alloc]init];
    serviceBtn.dragEnable = YES;
    [serviceBtn setImage:[UIImage imageNamed:@"home_kefu"] forState:UIControlStateNormal];
    [self.view addSubview:serviceBtn];
    
    UITapGestureRecognizer *aTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(serviceBtnAction)];
    aTap.numberOfTapsRequired = 1;
    [serviceBtn addGestureRecognizer:aTap];
    
    titleLabel.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(self.view,20)
    .widthIs(100)
    .heightIs(44);
    
    serviceBtn.sd_layout
    .rightSpaceToView(self.view,0)
    .bottomSpaceToView(self.view,80*UIRate)
    .widthIs(65*UIRate)
    .heightIs(65*UIRate);
    
    __weak typeof (self) weakSelf = self;
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf requestHomeData];
    }];
}

- (void)updataCells
{
    [self.cellsArray removeAllObjects];
    
    NSMutableArray *array1 = [NSMutableArray array];
    NSDictionary *dic1 = @{kCell:@"MainTableViewCell_1"};
    [array1 addObject:dic1];
    [self.cellsArray addObject:array1];
    
    
    NSMutableArray *array2 = [NSMutableArray array];
    NSDictionary *dic2 = @{kCell:@"MainTableViewCell_2"};
    [array2 addObject:dic2];
    [self.cellsArray addObject:array2];
    
    NSMutableArray *array3 = [NSMutableArray array];
    NSDictionary *dic3 = @{kCell:@"MainTableViewCell_3"};
    [array3 addObject:dic3];
    [self.cellsArray addObject:array3];
   
    NSMutableArray *array4 = [NSMutableArray array];
    for (TaskModel *model in self.xuanShangArray){
        NSDictionary *dic4 = @{kCell:@"MainTableViewCell_5",kValue:model};
        [array4 addObject:dic4];
    }
   
    [self.cellsArray addObject:array4];
    
    [self.tableView reloadData];
}

#pragma mark -
#pragma mark ================= <UITableViewDelegate,UITableViewDataSource> =================
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.cellsArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSMutableArray *array = self.cellsArray[section];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *array = self.cellsArray[indexPath.section];
    NSDictionary *dic = array[indexPath.row];
    
    if ([dic[kCell] isEqualToString:@"MainTableViewCell_1"])
    {
        MainTableViewCell_1 *cell = [MainTableViewCell_1 cellWithTableView:tableView];
        __weak typeof (self) weakSelf = self;
        //外链跳转
        cell.block = ^(HomeAdsModel *adModel){
            
            [weakSelf jumpWithAdsModel:adModel];
            

        };
        cell.adsArray = self.adsArray;
        
        return cell;
    }
    if ([dic[kCell] isEqualToString:@"MainTableViewCell_2"])//三个btn和搜索列表
    {
        MainTableViewCell_2 *cell = [MainTableViewCell_2 cellWithTableView:tableView];
        cell.delegate = self;
        return cell;
    }
    if ([dic[kCell] isEqualToString:@"MainTableViewCell_3"]){//大师推荐
        MainTableViewCell_3 *cell = [MainTableViewCell_3 cellWithTableView:tableView];
        cell.dataArray = self.dashiArray;
        __weak typeof (self) weakSelf = self;
        cell.block = ^(ModelMember *model){
            informationVC *vc = [[informationVC alloc]init];
            vc.memberId = model.memberId;
            vc.isFromMain = YES;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        return cell;
    }
    
    if ([dic[kCell] isEqualToString:@"MainTableViewCell_5"])//起名列表
    {
        MainTableViewCell_5 *cell = [MainTableViewCell_5 cellWithTableView:tableView];
        
        cell.model = dic[kValue];
        
        return cell;
    }
    
    return [UITableViewCell new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *array = self.cellsArray[indexPath.section];
    NSDictionary *dic = array[indexPath.row];
    
    if ([dic[kCell] isEqualToString:@"MainTableViewCell_1"])
    {
        return 210*UIRate;
    }
    if ([dic[kCell] isEqualToString:@"MainTableViewCell_2"])
    {
        return 120*UIRate;
    }
    if ([dic[kCell] isEqualToString:@"MainTableViewCell_3"])
    {
        return 345*UIRate;
    }
    if ([dic[kCell] isEqualToString:@"MainTableViewCell_5"])
    {
        return 85*UIRate;
    }
    
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *array = self.cellsArray[indexPath.section];
    NSDictionary *dic = array[indexPath.row];
    
    if ([dic[kCell] isEqualToString:@"MainTableViewCell_5"])
    {
        TaskModel *model = dic[kValue];
        
        RenWuXiangQingVC *vc = [[RenWuXiangQingVC alloc] init];
        vc.taskId = model.taskId;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    NSMutableArray *array = self.cellsArray[section];
    if (array.count > 0){
        NSDictionary *dic = array.firstObject;
        if ([dic[kCell] isEqualToString:@"MainTableViewCell_3"] || [dic[kCell] isEqualToString:@"MainTableViewCell_5"] ){
            return 40*UIRate;
        }
    }
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

    NSMutableArray *array = self.cellsArray[section];
    if (array.count > 0){
       MainHeaderView *headerView = [[MainHeaderView alloc ]initWithFrame:CGRectMake(0, 0, ScreenWidth, 40*UIRate)];
        NSDictionary *dic = array.firstObject;
        __weak typeof (self) weakSelf = self;
        if ([dic[kCell] isEqualToString:@"MainTableViewCell_3"]){
           
            headerView.topView.backgroundColor = HEXCOLOR(0xff6464);
            headerView.titleLabel.text = @"大师推荐";
            headerView.block = ^{
                masterListVC *vc = [[masterListVC alloc]init];
                [weakSelf.navigationController pushViewController:vc animated:YES];
            };
            return headerView;
        }
        
        if ([dic[kCell] isEqualToString:@"MainTableViewCell_5"]){
            headerView.topView.backgroundColor = HEXCOLOR(0xffa70e);
            headerView.titleLabel.text = @"悬赏起名";
            headerView.block = ^{
                XuanShangQiMingVC *vc = [[XuanShangQiMingVC alloc]init];
                [weakSelf.navigationController pushViewController:vc animated:YES];
            };
            return headerView;
        }
    }
   
    return [[UIView alloc] init];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
  
    [self.view endEditing:YES];
    
    CGFloat offsetY = scrollView.contentOffset.y + 20;
    if (offsetY > 64){
        [self setNavBackgroundAlpha:0.9];
    }else {
        [self setNavBackgroundAlpha:offsetY/64.0 - 0.1];
    }
}

//改变nav背景色
- (void)setNavBackgroundAlpha:(double)alpha{
    _navView.backgroundColor = RGBCOLOR(33, 150, 255, alpha);
}

#pragma mark - MainTableViewCell_2Delegate按钮点击跳转
- (void)cell_2ClickButtonWithTag:(MainTableViewCell_2BtnType)tag andStr:(NSString *)str
{
    switch (tag) {
        case MainTableViewCell_2BtnTypeSelf:// 自助起名
        {
            SelfhelpVC *vc = [[SelfhelpVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case MainTableViewCell_2BtnTypeReward://悬赏起名
        {
          
                XuanShangQiMingVC *vc = [[XuanShangQiMingVC alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
          
        }
            break;
        case MainTableViewCell_2BtnTypeMaster://大师起名
        {
            masterListVC *vc = [[masterListVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - Action
-(void)serviceBtnAction{
    
    ServiceVC *vc = [[ServiceVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)jumpWithAdsModel:(HomeAdsModel *)model{
    
    switch (model.adType) {
        case -8:
        {
            //无指向
            DLog(@"无指向的广告链接");
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

#pragma mark - ============网络请求===========
- (void)requestHomeData{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:@(10) forKey:@"numDashi"];
    [params setValue:@(10) forKey:@"numTask"];
    
    [CBConnect getHomeListHomeAll:params success:^(id responseObject){
        self.adsArray = [HomeAdsModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"listAds"]];
        
        self.dashiArray = [ModelMember mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"listDaShi"]];
        
        self.xuanShangArray = [TaskModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"listXuanShangTasks"]];
        
        [self updataCells];
        
        [self.tableView.mj_header endRefreshing];
        
    } successBackfailError:^(id responseObject) {
   
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}

@end
