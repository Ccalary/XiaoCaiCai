//
//  WalletViewController.m
//  才标网
//
//  Created by caohouhong on 17/3/14.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "WalletViewController.h"
#import "WalletTableViewCell.h"
#import "WithDrawViewController.h"
#import "CBConnect.h"
#import "AccountModel.h"
#import "BaseTableView.h"

@interface WalletViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UILabel *balanceLabel;
@property (nonatomic, strong) BaseTableView *tableView;
@property (nonatomic, assign) int pageNo;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation WalletViewController

- (NSMutableArray *)dataArray
{
    if (!_dataArray){
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"钱包";
    self.pageNo = 1;
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"提现" style:UIBarButtonItemStylePlain target:self action:@selector(rithtWithdrawButton)];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    
    [self drawView];
    [self requestData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)drawView{
    
    [self initHeaderView];
    
    self.tableView = [[BaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = HEXCOLOR(0xeeeeee);
    _tableView.tableHeaderView = self.headerView;
    [self.view addSubview:_tableView];
    
    _tableView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,0)
    .bottomSpaceToView(self.view,0);
    
    //上拉加载，下拉刷新
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.pageNo = 1;
        [weakSelf requestData];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        weakSelf.pageNo ++ ;
        [weakSelf requestData];
    }];
    
}

- (void)initHeaderView{
    
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 140*UIRate)];
    _headerView.backgroundColor = COLOR_BackgroundColor;
    
    UIView *holdView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 130*UIRate)];
    holdView.backgroundColor = [UIColor whiteColor];
    [_headerView addSubview:holdView];
    
    UIImageView *moneyImageView = [[UIImageView alloc] init];
    moneyImageView.image = [UIImage imageNamed:@"uc_interest_57x57"];
    [holdView addSubview:moneyImageView];
    
    UILabel *textlabel = [[UILabel alloc] init];
    textlabel.text = @"余额";
    textlabel.font = SYSTEM_FONT_(15*UIRate);
    textlabel.textAlignment = NSTextAlignmentCenter;
    textlabel.textColor = COLOR_Black;
    [holdView addSubview:textlabel];
    
    _balanceLabel = [[UILabel alloc] init];
    _balanceLabel.text = @"¥0.00";
    _balanceLabel.font = SYSTEM_FONT_BOLD_(18*UIRate);
    _balanceLabel.textAlignment = NSTextAlignmentCenter;
    _balanceLabel.textColor = COLOR_OrangeRed;
    [holdView addSubview:_balanceLabel];
    
    moneyImageView.sd_layout
    .centerXEqualToView(holdView)
    .topSpaceToView(holdView,10*UIRate)
    .widthIs(57*UIRate)
    .heightIs(57*UIRate);
    
    textlabel.sd_layout
    .centerXEqualToView(holdView)
    .topSpaceToView(moneyImageView,5*UIRate)
    .widthIs(100*UIRate)
    .heightIs(15*UIRate);
    
    _balanceLabel.sd_layout
    .centerXEqualToView(holdView)
    .topSpaceToView(textlabel,5*UIRate)
    .widthIs(ScreenWidth)
    .heightIs(20*UIRate);
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
    WalletTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[WalletTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.accountModel = self.dataArray[indexPath.row];
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60*UIRate;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

#pragma mark - ============网络－帐户流水历史===============
- (void)requestData {
    
    [LCProgressHUD showLoading:@"正在加载..."];
    
    NSMutableDictionary *params = [CBConnect getBaseRequestParams];
    [params setValue:@(self.pageNo) forKey:@"pageNo"];
    [params setValue:@(10) forKey:@"pageSize"];
    
    [CBConnect getUserCenterMemberAccountListFlows:params success:^(id responseObject) {
        
        if (self.pageNo == 1)
        {
            [self.dataArray removeAllObjects];
        }
        
        NSArray *array = [AccountModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
        //帐户余额
//        self.balanceLabel.text = [NSString stringWithFormat:@"¥%.2f",[[responseObject objectForKey:@"totalCount"] doubleValue]];
        
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
    
    
#pragma mark ===============账户余额===================
    NSMutableDictionary *params1 = [CBConnect getBaseRequestParams];

    [CBConnect getUserCenterViewMemberAccount:params1 success:^(id responseObject) {
        
        if ([responseObject objectForKey:@"accountBalanceYuan"]){
            NSString *moneyStr = [NSString stringWithFormat:@"¥%.2f",[[responseObject objectForKey:@"accountBalanceYuan"] doubleValue]];
            NSString *resultStr = [NSString stringWithFormat:@"%@",moneyStr];
            self.balanceLabel.text = resultStr;
            
        }
        
    } successBackfailError:^(id responseObject) {
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
    
}


#pragma mark - Action
//提现
- (void)rithtWithdrawButton{
    WithDrawViewController *vc = [[WithDrawViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}



@end
