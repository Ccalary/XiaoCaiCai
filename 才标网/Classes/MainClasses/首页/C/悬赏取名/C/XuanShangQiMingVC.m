//
//  XuanShangQiMingVC.m
//  才标网
//
//  Created by baichun on 17/3/8.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "XuanShangQiMingVC.h"
#import "XuanShangHeardview.h"
#import "MainTableViewCell_5.h"
#import "RenWuXiangQingVC.h"
#import "ReleaseVC.h"
#import "masterDetailsVC.h"
#import "XuanShangCell_1.h"
#import "XuanShangCell_2.h"
#import "myDetailsVC.h"
#import "IamMasterDetailsVC.h"
#import "CBConnect.h"
#import "TaskModel.h"
#import "UserHelper.h"
#import "LoginViewController.h"
#import "BaseTableView.h"

@interface XuanShangQiMingVC ()<UITableViewDelegate,UITableViewDataSource,XuanShangHeardviewDelegate>
{
    int orderBy;
    int namedCategory;
    int pageNo;
}
@property(nonatomic,strong)BaseTableView *tableView;
@property (nonatomic, strong) NSArray *titleA;
@property (nonatomic, strong) XuanShangHeardview *menu2;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation XuanShangQiMingVC
- (NSMutableArray *)dataArray
{
    if (!_dataArray){
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"任务广场";
    
    /**
     排序方式，取值如下：
     1---发布时间由远到近
     2---发布时间由近到远
     3---金额从低到高
     4---金额从高到低
     5---人气从低到高
     6---人气从高到低
     初始默认排序传值2
     */
    orderBy = 2;
    
    /**起名分类，取值如下：
    1-商标起名
    2-公司起名
     */
    namedCategory = 0;
    
    pageNo = 1;
    
    [self drawTabChooseView];

    [self drawView];
    
    [self requestData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)drawView{
    
    _tableView = [[BaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = COLOR_BackgroundColor;
    [self.view addSubview:self.tableView];
    
    _tableView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,50*UIRate)
    .bottomSpaceToView(self.view,50*UIRate);
   
    UIView *footView = [[[UIView alloc]init]init];
    footView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:footView];
    
    UIButton *releaseBtn = [[UIButton alloc]init];
    [releaseBtn setTitle:@"我要发布任务" forState:UIControlStateNormal];
    releaseBtn.titleLabel.font = SYSTEM_FONT_(18*UIRate);
    [releaseBtn setTitleColor:HEXCOLOR(0xff5c0b) forState:UIControlStateNormal];
    [releaseBtn addTarget:self action:@selector(footViewAction) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:releaseBtn];
    
    UIView *dividerLine1 = [[UIView alloc] init];
    dividerLine1.backgroundColor = COLOR_BackgroundColor;
    [footView addSubview:dividerLine1];
    
    footView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .bottomSpaceToView(self.view,0)
    .heightIs(50*UIRate);
    
    releaseBtn.sd_layout
    .leftSpaceToView(footView,0)
    .rightSpaceToView(footView,0)
    .bottomSpaceToView(footView,0)
    .topSpaceToView(footView,0);
    
    dividerLine1.sd_layout
    .leftEqualToView(footView)
    .rightEqualToView(footView)
    .topEqualToView(footView)
    .heightIs(1);
    
    //上拉加载，下拉刷新
    __weak typeof(self) weakSelf = self;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        pageNo = 1;
        [weakSelf requestData];
    }];
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        pageNo ++;
        [weakSelf requestData];
    }];
}
#pragma mark - ======== footView点击事件 =========
-(void)footViewAction{
    if (![UserHelper IsLogin]) {
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        BaseNavigationController *baseNav = [[BaseNavigationController alloc] initWithRootViewController:loginVC];
        [self presentViewController:baseNav animated:YES completion:nil];
        return;
    }
    ReleaseVC *vc = [[ReleaseVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)drawTabChooseView
{
    self.titleA = @[@[@"分类",@"商标起名",@"公司起名"],@[@"排序",@"金额从低到高",@"金额从高到低",@"按发布时间最早",@"按发布时间最晚",@"投稿人最少",@"投稿人最多"]];
    self.menu2 = [[XuanShangHeardview alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 50*UIRate) withTitle:self.titleA withSelectColor:HEXCOLOR(0x4fbbf6)];
    self.menu2.menuViewDelegate = self;
    [self.view addSubview:self.menu2];
    
    UIView *dividerLine1 = [[UIView alloc] init];
    dividerLine1.backgroundColor = COLOR_BackgroundColor;
    [self.view addSubview:dividerLine1];
    
    dividerLine1.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(self.view,5*UIRate)
    .widthIs(1)
    .heightIs(40*UIRate);
}

-(void)pullDownMenuView:(XuanShangHeardview *)menu didSelectedIndex:(NSIndexPath *)indexPath{
    NSString *str = [[self.titleA objectAtIndex:indexPath.row] objectAtIndex:indexPath.section];
    if ([str isEqualToString:@"分类"]) {
        namedCategory = 0;
    }
    
    if ([str isEqualToString:@"商标起名"]) {
        namedCategory = 1;
    }
    if ([str isEqualToString:@"公司起名"]) {
        namedCategory = 2;
    }
    
    if ([str isEqualToString:@"金额从低到高"]) {
        orderBy = 3;
    }
    if ([str isEqualToString:@"金额从高到低"]) {
        orderBy = 4;
    }
    if ([str isEqualToString:@"按发布时间最早"] || [str isEqualToString:@"排序"]) {
        orderBy = 2;
    }
    if ([str isEqualToString:@"按发布时间最晚"]) {
        orderBy = 1;
    }
    if ([str isEqualToString:@"投稿人最少"]) {
        orderBy = 5;
    }
    if ([str isEqualToString:@"投稿人最多"]) {
        orderBy = 6;
    }
    
    pageNo = 1;
    [self requestData];
}

#pragma mark - ======== <UITableViewDelegate,UITableViewDataSource> =========
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    XuanShangCell_1  *cell = [XuanShangCell_1 cellWithTableView:tableView];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90*UIRate;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10*UIRate;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TaskModel *model = self.dataArray[indexPath.row];
    RenWuXiangQingVC *vc = [[RenWuXiangQingVC alloc]init];
    vc.taskId = model.taskId;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - ============网络－任务广场===============
- (void)requestData {
    [LCProgressHUD showLoading:@"正在加载..."];
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    
    if (namedCategory == 1 || namedCategory == 2){
        [params setValue:@(namedCategory) forKey:@"namedCategory"];
    }
    [params setValue:@(orderBy) forKey:@"orderBy"];
    [params setValue:@(pageNo) forKey:@"pageNo"];
    [params setValue:@(10) forKey:@"pageSize"];
    
    [CBConnect getHomeTasksquareInfo:params success:^(id responseObject) {
        
        if (pageNo == 1)
        {
            [self.dataArray removeAllObjects];
        }
        
        NSArray *array = [TaskModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
        
        [self.dataArray addObjectsFromArray:array];
        
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
        if (array.count < 10)
        {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        
    } successBackfailError:^(id responseObject) {
        
        [self.dataArray removeAllObjects];
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];

}

@end
