//
//  MyOrderDetailVC.m
//  才标网
//
//  Created by caohouhong on 17/3/27.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "MyOrderDetailVC.h"
#import "MyOrderDetailCell1.h"
#import "MyOrderDetailCell2.h"
#import "MyOrderDetailCell3.h"
#import "CBConnect.h"
#import "OrderModel.h"
#import "OrderStateHistoryModel.h"
#import "NavigationView.h"

@interface MyOrderDetailVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *cellDataArray;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) OrderModel *model;

@property (nonatomic, assign) BOOL isExpend;//是否展开

@end

@implementation MyOrderDetailVC

- (NSMutableArray *)cellDataArray
{
    if (!_cellDataArray){
        _cellDataArray = [[NSMutableArray alloc] init];
    }
    return _cellDataArray;
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
    self.navigationController.navigationBar.translucent = YES;
    [self drawView];
    [self updateCell];
    
    [self requestData];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)drawView{
    
    __weak typeof (self) weakSelf = self;
    NavigationView *nav = [[NavigationView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64) andTitle:@"订单详情" block:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    [self.view addSubview:nav];
    
    self.view.backgroundColor = COLOR_BackgroundColor;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = COLOR_BackgroundColor;
    [self.view addSubview:_tableView];
    
    _tableView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,64)
    .bottomSpaceToView(self.view,0);
    
}

- (UIView *)headerView
{
    if (!_headerView){
        
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 50*UIRate)];
        _headerView.backgroundColor = [UIColor whiteColor];
        
        UIView *dividerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 10*UIRate)];
        dividerView.backgroundColor = COLOR_BackgroundColor;
        [_headerView addSubview:dividerView];
        
        UILabel *recordLabel = [[UILabel alloc] initWithFrame:CGRectMake(10*UIRate, 10*UIRate, 200*UIRate, 40*UIRate)];
        recordLabel.font = SYSTEM_FONT_(15*UIRate);
        recordLabel.textColor = COLOR_Gray;
        recordLabel.text = @"订单记录";
        [_headerView addSubview:recordLabel];
        
        UIView *dividerLine1 = [[UIView alloc] initWithFrame:CGRectMake(0, 49*UIRate, ScreenWidth, 1)];
        dividerLine1.backgroundColor = COLOR_BackgroundColor;
        [_headerView addSubview:dividerLine1];
    }
    return _headerView;
}

- (UIView *)footerView{
    if (!_footerView){
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 25*UIRate)];
        _footerView.backgroundColor = [UIColor whiteColor];
        
        UIButton *arrowButton = [[UIButton alloc] init];
        [arrowButton setImage:[UIImage imageNamed:@"m_arrow_down_22x22"] forState:UIControlStateNormal];
        [arrowButton setImage:[UIImage imageNamed:@"m_arrow_up_22x22"] forState:UIControlStateSelected];
        
        [arrowButton addTarget:self action:@selector(arrowBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_footerView addSubview:arrowButton];
        
        arrowButton.sd_layout
        .centerXEqualToView(_footerView)
        .centerYEqualToView(_footerView)
        .widthIs(22*UIRate)
        .heightIs(22*UIRate);
    }
    return _footerView;
}

- (void)updateCell{
    
    [self.cellDataArray removeAllObjects];
    
    NSMutableArray *array1 = [NSMutableArray array];
    NSDictionary *dic = @{kCell:@"MyOrderDetailCell1"};
    [array1 addObject:dic];
    
    NSMutableArray *array2 = [NSMutableArray array];
    NSDictionary *dic2 = @{kCell:@"MyOrderDetailCell2"};
    [array2 addObject:dic2];

    NSMutableArray *array3 = [NSMutableArray array];
    for (OrderStateHistoryModel *hisModel in self.model.histories)
    {
        NSDictionary *dic3 = @{kCell:@"MyOrderDetailCell3",kValue:hisModel};
        [array3 addObject:dic3];
        
        if (!self.isExpend){//如果是是不是展开，则加载一个
            break;
        }
    }
    
    [self.cellDataArray addObject:array1];
    [self.cellDataArray addObject:array2];
    [self.cellDataArray addObject:array3];
    
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.cellDataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = self.cellDataArray[section];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *array = self.cellDataArray[indexPath.section];
    NSDictionary *dic = array[indexPath.row];
    
    if ([dic[kCell] isEqualToString:@"MyOrderDetailCell1"]){
    
        NSString * const cellIdentifier = @"CellIdentifier1";
        MyOrderDetailCell1 *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (!cell) {
            cell = [[MyOrderDetailCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.model = self.model;
        return cell;
    }
    
    if ([dic[kCell] isEqualToString:@"MyOrderDetailCell2"]){
        
        NSString * const cellIdentifier = @"CellIdentifier2";
        MyOrderDetailCell2 *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (!cell) {
            cell = [[MyOrderDetailCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.model = self.model;
        
        return cell;
    }
    
    if ([dic[kCell] isEqualToString:@"MyOrderDetailCell3"]){
    
        NSString * const cellIdentifier = @"CellIdentifier3";
        MyOrderDetailCell3 *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (!cell) {
            cell = [[MyOrderDetailCell3 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        cell.hisModel = dic[kValue];
        
        return cell;
    }
    
    return [[UITableViewCell alloc] init];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *array = self.cellDataArray[indexPath.section];
    NSDictionary *dic = array[indexPath.row];
    
    if ([dic[kCell] isEqualToString:@"MyOrderDetailCell1"]){
        return 205*UIRate;
    }
    
    if ([dic[kCell] isEqualToString:@"MyOrderDetailCell2"]){
        return 145*UIRate;
    }
    
    if ([dic[kCell] isEqualToString:@"MyOrderDetailCell3"]){
        return 50*UIRate;
    }
    
    return 0*UIRate;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 2){
        return 60*UIRate;
    }
    
    return 10*UIRate;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 2){
        return 25*UIRate;
    }
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 2){
 
        return self.headerView;
    }
    
    return [[UIView alloc] init];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 2){
        return self.footerView;
    }
    
    return [[UIView alloc] init];
}


#pragma mark - Action
//下拉打开
- (void)arrowBtnAction:(UIButton *)button{
    
    if (self.model.histories.count <= 1){
        [LCProgressHUD showMessage:@"没有更多了"];
        return;
    }
    button.selected = !button.selected;
    
    self.isExpend = button.selected;
    
    [self updateCell];
}


#pragma mark - =================网络请求=================
- (void)requestData{
    [LCProgressHUD showLoading:@"正在加载..."];
    NSMutableDictionary *params = [CBConnect getBaseRequestParams];
    [params setValue:self.orderId forKey:@"order_id"];
    
    [CBConnect getUserCenterOrderViewOrder:params success:^(id responseObject) {
        
        self.model = [OrderModel mj_objectWithKeyValues:responseObject];
    
        [self updateCell];
        
    } successBackfailError:^(id responseObject) {
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}
@end
