//
//  IamMasterVC.m
//  才标网
//
//  Created by caohouhong on 17/3/14.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "IamMasterVC.h"
#import "RewardTaskTableViewCell.h"
#import "CBConnect.h"
#import "IamMasterDetailsVC.h"
#import "TaskModel.h"
#import "BaseTableView.h"

@interface IamMasterVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) BaseTableView *tableView;
@property (nonatomic, assign) int pageNo;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) TaskModel *model;
@end

@implementation IamMasterVC

- (NSMutableArray *)dataArray
{
    if (!_dataArray){
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我是大师";
    self.pageNo = 1;
    [self drawView];
    [LCProgressHUD showLoading:@"正在加载..."];
    [self requestData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)drawView{
    
    _tableView = [[BaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = HEXCOLOR(0xeeeeee);
    [self.view addSubview:_tableView];
    
    _tableView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,0)
    .bottomSpaceToView(self.view,0);
    
    //上拉加载，下拉刷新
    __weak typeof(self) weakSelf = self;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.pageNo = 1;
        [weakSelf requestData];
    }];
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        weakSelf.pageNo ++;
        [weakSelf requestData];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * const cellIdentifier = @"CellIdentifier";
    RewardTaskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[RewardTaskTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.amMasterModel = self.dataArray[indexPath.row];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90*UIRate;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.model = self.dataArray[indexPath.row];
     IamMasterDetailsVC *vc = [[IamMasterDetailsVC alloc]init];
    vc.taskId = _model.taskId;
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - ============网络－我的悬赏任务列表===============
- (void)requestData {
    
    NSMutableDictionary *params = [CBConnect getBaseRequestParams];
    [params setValue:@(self.pageNo) forKey:@"pageNo"];
    [params setValue:@(10) forKey:@"pageSize"];
    
    [CBConnect getUserCenterListMyReceivedTask:params success:^(id responseObject) {
        
        if (self.pageNo == 1)
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
        
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}

@end
