//
//  MessageViewController.m
//  才标网
//
//  Created by caohouhong on 17/3/14.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "MessageViewController.h"
#import "ReviewTableViewCell.h"
#import "CBConnect.h"
#import "UserHelper.h"
#import "MessageModel.h"
#import "myDetailsVC.h"
#import "masterDetailsVC.h"
#import "ReviewResultDetailVC.h"
#import "ServiceVC.h"
#import "BaseTableView.h"

@interface MessageViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) BaseTableView *mTableView;
@property (nonatomic, assign) int pageNo; //页码
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation MessageViewController

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
    [self requestModifyMsgRead];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)drawView{
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 10*UIRate)];
    headerView.backgroundColor = COLOR_BackgroundColor;
    
    _mTableView = [[BaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
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
    cell.messageModel = self.dataArray[indexPath.row];
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60*UIRate;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MessageModel *model = self.dataArray[indexPath.row];
    
    switch (model.linkType) {
        case 1: //悬赏任务
        {
            myDetailsVC *vc = [[myDetailsVC alloc]init];
            vc.taskId = model.linkParams.doubleValue;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2: //大师任务
        {
            masterDetailsVC *vc = [[masterDetailsVC alloc]init];
            vc.taskId = model.linkParams.doubleValue;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3: //商标复查
        {
            ReviewResultDetailVC *vc = [[ReviewResultDetailVC alloc]init];
            vc.recheckId = model.linkParams.doubleValue;
            [self.navigationController pushViewController:vc animated:YES];
            
        }
            break;
        case 11://外网链接
        {
            ServiceVC *vc = [[ServiceVC alloc]init];
            vc.uilString = model.linkParams;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default://无指向
            break;
    }
}

#pragma mark - ============网络－请求消息列表===============
- (void)requestData {
    
    [LCProgressHUD showLoading:@"正在加载..."];
    
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

#pragma mark - ========网络－标记消息已读=========
- (void)requestModifyMsgRead{
 
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:[UserHelper getMemberId] forKey:@"receiverId"];//就是用户id
    
    [CBConnect getUserCenterModifyMsgRead:params success:^(id responseObject) {
    
    } successBackfailError:^(id responseObject) {
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}
@end
