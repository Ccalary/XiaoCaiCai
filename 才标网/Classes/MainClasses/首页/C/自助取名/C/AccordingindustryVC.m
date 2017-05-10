//
//  AccordingindustryVC.m
//  才标网
//
//  Created by baichun on 17/3/20.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "AccordingindustryVC.h"
#import "AccordingindustryCell_1.h"
#import "CNPPopupController.h"
#import "NamedSearchPopView.h"
#import "CBConnect.h"
#import "SelfNameModel.h"

@interface AccordingindustryVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, assign) int pageNum;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) CNPPopupController *popupController;
@property (nonatomic, strong) NamedSearchPopView *popView;
@end

@implementation AccordingindustryVC

- (NSMutableArray *)dataArray
{
    if (!_dataArray){
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"智能取名";
    _pageNum = 1;
    [self drawView];
    
    [LCProgressHUD showLoading:@"正在加载..."];
    [self requestData];
}
-(void)drawView{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = HEXCOLOR(0xeeeeee);
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    tableView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,0)
    .bottomSpaceToView(self.view,0);

    __weak typeof (self) weakSelf = self;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.pageNum = 1;
        [weakSelf requestData];
        
    }];
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        weakSelf.pageNum ++;
        [weakSelf requestData];
    }];
}

- (NamedSearchPopView *)popView{
    if (!_popView){
        _popView = [[NamedSearchPopView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth - 50*UIRate, 290*UIRate)];
        __weak typeof (self) weakSelf = self;
        _popView.closeBlock = ^(){
             [weakSelf.popupController dismissPopupControllerAnimated:YES];
        };
        
        _popView.searchBlock = ^(NSString *brandName, NSString *name, NSString *phoneNum){
            [weakSelf requestResultDataWithBrandName:brandName andName:name andPhone:phoneNum];
            [weakSelf.popupController dismissPopupControllerAnimated:YES];
        };
    }
    return _popView;
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
    AccordingindustryCell_1 *cell = [AccordingindustryCell_1 cellWithTableView:tableView];
    cell.nameLabel.text = self.dataArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45*UIRate;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *str = self.dataArray[indexPath.row];
    self.popView.trademarkTF.text = str;
    
    self.popupController = [[CNPPopupController alloc] initWithContents:@[self.popView]];
    self.popupController.theme.popupStyle = CNPPopupStyleCentered;
    self.popupController.theme.presentationStyle = CNPPopupPresentationStyleSlideInFromTop;
    self.popupController.theme.dismissesOppositeDirection = YES;
    [self.popupController presentPopupControllerAnimated:YES];
}

#pragma mark - =================网络请求=================
- (void)requestData{
    
    if (self.companyId.length){
        [self requestHangYeData];
    }else if (self.keyStr.length){
        [self requestKeyWordData];
    }
}


//行业起名
- (void)requestHangYeData{

    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:@(10) forKey:@"pagenumber"];
    [params setValue:@(self.pageNum) forKey:@"page"];
    [params setValue:self.companyId forKey:@"company_type_id"];//行业id

    [CBConnect getTradeMarkNameByHangye:params success:^(id responseObject) {
        if (self.pageNum == 1)
        {
            [self.dataArray removeAllObjects];
        }
        NSArray *array = [SelfNameModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
        
        for (SelfNameModel *model in array){
            [self.dataArray addObject:model.name?:@""];
        }
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
        
        if (self.dataArray.count < 10)
        {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        
    } successBackfailError:^(id responseObject) {
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}


//关键字起名
- (void)requestKeyWordData{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:self.keyStr forKey:@"title"];//商标名称模糊查询
    [params setValue:@(self.pageNum) forKey:@"pageNo"];
    [params setValue:@(10) forKey:@"pageSize"];
    [CBConnect getTradeMarkNameByKeyWord:params success:^(id responseObject) {
        if (self.pageNum == 1)
        {
            [self.dataArray removeAllObjects];
        }
        NSArray *array = [responseObject objectForKey:@"data"];
        
        [self.dataArray addObjectsFromArray:array];
        
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
        
        if (self.dataArray.count < 10)
        {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
       
    } successBackfailError:^(id responseObject) {
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}

//结果查询
- (void)requestResultDataWithBrandName:(NSString *)brandName andName:(NSString *)name andPhone: (NSString *)phoneNum{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:brandName forKey:@"buy_remarks"];
    [params setValue:name forKey:@"buy_name"];
    [params setValue:phoneNum forKey:@"buy_phone"];
    
    [CBConnect getHomeBuyTradeMark:params success:^(id responseObject) {
        
        [LCProgressHUD showSuccess:@"提交成功"];
        
    } successBackfailError:^(id responseObject) {
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}


@end
