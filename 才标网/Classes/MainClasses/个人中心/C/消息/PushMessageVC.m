//
//  PushMessageVC.m
//  才标网
//
//  Created by baichun on 17/4/12.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "PushMessageVC.h"
#import "ReviewTableViewCell.h"
#import "CBConnect.h"
#import "UserHelper.h"
#import "MessageModel.h"
#import "myDetailsVC.h"
#import "masterDetailsVC.h"
#import "ReviewResultDetailVC.h"
#import "ServiceVC.h"
@interface PushMessageVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *mTableView;
@property (nonatomic, assign) int pageNo; //页码
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation PushMessageVC
- (NSMutableArray *)dataArray
{
    if (!_dataArray){
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"消息";
    self.pageNo = 1; //从1开始
    [self drawView];
    [self requestData];
}
- (void)drawView{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(leftBarBtnAction)];
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 10*UIRate)];
    headerView.backgroundColor = COLOR_BackgroundColor;
    
    _mTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _mTableView.delegate = self;
    _mTableView.dataSource = self;
    _mTableView.backgroundColor = COLOR_BackgroundColor;
    _mTableView.tableHeaderView = headerView;
    _mTableView.tableFooterView = [[UIView alloc] init];
    _mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_mTableView];
    
    _mTableView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,0)
    .bottomSpaceToView(self.view,0);
    
    __weak typeof(self) weakSelf = self;
    _mTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.pageNo = 1;
        [weakSelf requestData];
    }];
    _mTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        weakSelf.pageNo ++ ;
        [weakSelf requestData];
    }];
    
}
#pragma mark - UITabelViewDalegate&&DataSource

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
    ReviewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[ReviewTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.messageModel = self.dataArray[indexPath.row];
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60*UIRate;
}

#pragma mark ============leftBarBtnAction模态返回================
-(void)leftBarBtnAction{
    
    [self dismissViewControllerAnimated:YES completion:nil];
//    if (self.delegate){
//        [self.delegate exit];
//    }
//
    
}
#pragma mark - ============网络－请求消息列表===============
- (void)requestData {
    
    
    NSMutableDictionary *params = [CBConnect getBaseRequestParams];
    [params setValue:@(self.pageNo) forKey:@"pageNo"];
    [params setValue:@(10) forKey:@"pageSize"];
    
    [CBConnect getUserCenterMessageList:params success:^(id responseObject) {
        
        if (self.pageNo == 1)
        {
            [self.dataArray removeAllObjects];
        }
        
        NSArray *array = [MessageModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
        
        [self.dataArray addObjectsFromArray:array];
        
        [self.mTableView reloadData];
        [self.mTableView.mj_footer endRefreshing];
        [self.mTableView.mj_header endRefreshing];
        
        if (array.count < 10)
        {
            [self.mTableView.mj_footer endRefreshingWithNoMoreData];
        }
        
    } successBackfailError:^(id responseObject) {
        
        [self.mTableView.mj_footer endRefreshing];
        [self.mTableView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
