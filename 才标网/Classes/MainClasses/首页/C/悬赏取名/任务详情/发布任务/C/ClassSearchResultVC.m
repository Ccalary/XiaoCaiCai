//
//  ClassSearchResultVC.m
//  才标网
//
//  Created by caohouhong on 17/5/3.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "ClassSearchResultVC.h"
#import "CBConnect.h"
#import "TradeMarkCategoryModel.h"
#import "BaseTableView.h"

@interface ClassSearchResultVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) BaseTableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation ClassSearchResultVC

- (NSMutableArray *)dataArray
{
    if (!_dataArray){
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"搜索结果";
    [self drawView];
    [self requesData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)drawView{
    
    _tableView = [[BaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc] init];
    
    [self.view addSubview:_tableView];
    
    _tableView.sd_layout
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .topEqualToView(self.view)
    .bottomEqualToView(self.view);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = (UITableViewCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    TradeMarkCategoryModel *model = self.dataArray[indexPath.row];
    NSString *string = @"";
    if (model.category_trademark_code.length){
        string = [NSString stringWithFormat:@"%@ %@",model.category_trademark_code, model.category_name?:@""];
    }else if (model.category_group_number.length){
        string = [NSString stringWithFormat:@"%@ %@",model.category_group_number, model.category_name?:@""];
    }else {
        string = [NSString stringWithFormat:@"%@ %@",model.category_number?:@"", model.category_name?:@""];
    }
    
    cell.textLabel.text = string;
    
    return cell;
}

#pragma  mark ============网络请求===============
- (void)requesData{
    [LCProgressHUD showLoading:@"加载中..."];
    NSMutableDictionary *params = [CBConnect getBaseRequestParams];
    [params setValue:@"1" forKey:@"pageNo"];
    [params setValue:@"1000" forKey:@"pageSize"];
    [params setValue:self.searchText forKey:@"filter_name"];
    [CBConnect getHomeListCateTree:params success:^(id responseObject) {
        NSArray *array = [TradeMarkCategoryModel mj_objectArrayWithKeyValuesArray:responseObject];
        [self.dataArray addObjectsFromArray:array];
        [self.tableView reloadData];
    } successBackfailError:^(id responseObject) {
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}

@end
