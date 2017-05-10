//
//  MyOrderListView.m
//  才标网
//
//  Created by caohouhong on 17/3/27.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "MyOrderListView.h"
#import "MyOrderTableViewCell.h"
#import "CBConnect.h"
#import "OrderModel.h"
#import "BaseTableView.h"

@interface MyOrderListView()<UITableViewDelegate, UITableViewDataSource,MyOrderTableViewCellDelegate>
@property (nonatomic, strong) BaseTableView *tableView;
@property (nonatomic, assign) int pageNo;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation MyOrderListView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        self.pageNo = 1;
        [self drawView];
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
- (void)drawView{
    
    self.backgroundColor = COLOR_BackgroundColor;
    
    _tableView = [[BaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = COLOR_BackgroundColor;
    [self addSubview:_tableView];
    
    _tableView.sd_layout
    .leftSpaceToView(self,0)
    .rightSpaceToView(self,0)
    .topSpaceToView(self,0)
    .bottomSpaceToView(self,0);
    
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
    
    [LCProgressHUD showLoading:@"正在加载..."];
    [self requestData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    return self.dataArray.count;
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * const cellIdentifier = @"CellIdentifier";
    MyOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
   
    
    if (!cell) {
        cell = [[MyOrderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegete = self;
    cell.model = self.dataArray[indexPath.section];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 180*UIRate;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10*UIRate;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

#pragma mark - MyOrderTableViewCellDelegate
- (void)clickButtonWithTag:(MyOrderTableViewCellType)tag andOrderId:(NSString *)orderId
{
    switch (tag) {
        case MyOrderTableViewCellTypeSee://查看
            
            if (self.block){
                self.block(10000,orderId);
            }
            break;
        case MyOrderTableViewCellTypePay://付款
            
            if (self.block){
                self.block(10001,orderId);
            }
            break;
        default:
            break;
    }
}

#pragma mark - =================网络请求=================
- (void)requestData{
    NSMutableDictionary *params = [CBConnect getBaseRequestParams];
    [params setValue:@(self.pageNo) forKey:@"pageNo"];
    
    [CBConnect getUserCenterOrderListOrders:params success:^(id responseObject) {
        if (self.pageNo == 1)
        {
            [self.dataArray removeAllObjects];
        }
        NSArray *array = [OrderModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
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
