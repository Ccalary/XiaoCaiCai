//
//  ReviewResultListVC.m
//  才标网
//
//  Created by caohouhong on 17/3/14.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "ReviewResultListVC.h"
#import "ReviewTableViewCell.h"
#import "ReviewResultDetailVC.h"
#import "CBConnect.h"
#import "ReviewListModel.h"
#import "queryVC.h"
#import "BaseTableView.h"

@interface ReviewResultListVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) BaseTableView *tableView;
@property (nonatomic, assign) int pageNo;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) int searchState; //查询状态：1-进行中 2-已结束 不传表示“全部”
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton *searchButton;
@end

@implementation ReviewResultListVC

- (instancetype)initWithSearchState:(int)state
{
    self = [super init];
    if (self){
        self.searchState = state;
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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageNo = 1;
    [self drawView];
    [self requestData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (void)drawView{
    
    self.view.backgroundColor = COLOR_BackgroundColor;
    
    _tableView = [[BaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = COLOR_BackgroundColor;
    [self.view addSubview:_tableView];
    
    
    UIImageView *searchImageView = [[UIImageView alloc] init];
    searchImageView.image = [UIImage imageNamed:@"home_search"];// 280x37
    [self.view addSubview:searchImageView];
    self.textField = [[UITextField alloc] init];
    _textField.font = SYSTEM_FONT_(16*UIRate);
    _textField.textColor = COLOR_darkGray;
    _textField.placeholder = @"请输入商标名称";
    [self.view addSubview:_textField];
    self.searchButton = [[UIButton alloc] init];
    _searchButton.titleLabel.font = SYSTEM_FONT_(16*UIRate);
    [_searchButton setTitle:@"查询" forState:UIControlStateNormal];
    _searchButton.layer.cornerRadius = 4.0;
    [_searchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_searchButton setBackgroundColor:HEXCOLOR(0x397fff)];
    [_searchButton addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_searchButton];
    
    searchImageView.sd_layout
    .leftSpaceToView(self.view, 10*UIRate)
    .topSpaceToView(self.view,20*UIRate)
    .widthIs(ScreenWidth - 95*UIRate)
    .heightIs(37*UIRate);
    
    _textField.sd_layout
    .leftEqualToView(searchImageView).offset(50*UIRate)
    .centerYEqualToView(searchImageView)
    .widthIs(ScreenWidth - 150*UIRate)
    .heightRatioToView(searchImageView,1);
    
    _searchButton.sd_layout
    .leftSpaceToView(searchImageView,10*UIRate)
    .centerYEqualToView(searchImageView)
    .widthIs(65*UIRate)
    .heightRatioToView(searchImageView,1);

    
    _tableView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(searchImageView,10*UIRate)
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
//搜索
-(void)buttonAction{
    queryVC *vc = [[queryVC alloc]init];
    vc.nameString = self.textField.text;
    [self.navigationController pushViewController:vc animated:YES];
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
    ReviewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[ReviewTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.reviewModel = self.dataArray[indexPath.row];
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60*UIRate;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10*UIRate;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ReviewListModel *model = self.dataArray[indexPath.row];
    
    ReviewResultDetailVC *vc = [[ReviewResultDetailVC alloc] init];
    vc.recheckId = model.recheckId;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - ============网络－复查结果===============
- (void)requestData {
    [LCProgressHUD showLoading:@"正在加载..."];
    
    NSMutableDictionary *params = [CBConnect getBaseRequestParams];
    if (self.searchState == 1 || self.searchState == 2){
        [params setValue:@(self.searchState) forKey:@"state"]; //查询状态：1-进行中 2-已结束 不传表示“全部”
    }
    
    [params setValue:@(self.pageNo) forKey:@"pageNo"];
    [params setValue:@(10) forKey:@"pageSize"];
    
    [CBConnect getUserCenterListBrandRechecks:params success:^(id responseObject) {
        
        if (self.pageNo == 1)
        {
            [self.dataArray removeAllObjects];
        }
        
        NSArray *array = [ReviewListModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
        
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
