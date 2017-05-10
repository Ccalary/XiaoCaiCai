//
//  BrandFavourVC.m
//  才标网
//
//  Created by caohouhong on 17/3/14.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "BrandFavourVC.h"
#import "BrandFavTableViewCell.h"
#import "CBConnect.h"
#import "TrademarkFollowModel.h"
#import "BrandDetailVC.h"
#import "BaseTableView.h"
@interface BrandFavourVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UILabel *headerLabel;
@property (nonatomic, strong) BaseTableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation BrandFavourVC

- (NSMutableArray *)dataArray
{
    if (!_dataArray){
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"商标收藏";
    [self drawView];
    
    [LCProgressHUD showLoading:@"加载中..."];
    [self requestData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}
- (void)drawView{
    
    _headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 50*UIRate)];
    _headerLabel.backgroundColor = [UIColor whiteColor];
    _headerLabel.text = @"您已关注0/10个商标";
    _headerLabel.font = SYSTEM_FONT_(16*UIRate);
    _headerLabel.textColor = COLOR_Orange;
    _headerLabel.textAlignment = NSTextAlignmentCenter;
    
    _tableView = [[BaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = HEXCOLOR(0xeeeeee);
    _tableView.tableHeaderView = _headerLabel;
    [self.view addSubview:_tableView];
    
    _tableView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,0)
    .bottomSpaceToView(self.view,0);
    
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
    BrandFavTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[BrandFavTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.dataArray[indexPath.row];
    __weak typeof(self) weakSelf = self;

    cell.block = ^(TrademarkFollowModel *model){
        [weakSelf requestUncollectDataWithModel:model];
    };
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TrademarkFollowModel *model = self.dataArray[indexPath.row];
    BrandDetailVC *vc = [[BrandDetailVC alloc]init];
    vc.cxkeyNum = model.trademark_regno;
    vc.intcls = model.trademark_intcls;
    [self.navigationController pushViewController:vc animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100*UIRate;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10*UIRate;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

#pragma mark - =================网络请求=================
- (void)requestData{
    NSMutableDictionary *params = [CBConnect getBaseRequestParams];
    
    [CBConnect getUserCenterListMyCollectionTrademark:params success:^(id responseObject) {
        NSArray *array = [TrademarkFollowModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
        [self.dataArray removeAllObjects];
        [self.dataArray addObjectsFromArray:array];
        
        [self.tableView reloadData];
        
        self.headerLabel.text = [NSString stringWithFormat:@"您已关注%@/10个商标",[responseObject objectForKey:@"totalCount"]];
        
    } successBackfailError:^(id responseObject) {
        
       [self.dataArray removeAllObjects];
       [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
    }];
}

//取消收藏
- (void)requestUncollectDataWithModel:(TrademarkFollowModel *)model{
    [LCProgressHUD showLoading:@"正在取消收藏..."];
    
    NSMutableDictionary *params = [CBConnect getBaseRequestParams];
    [params setValue:model.trademark_regno?:@"" forKey:@"cxkey"];//商标注册号
    [params setValue:model.trademark_intcls?:@"" forKey:@"intcls"];//商标国际分类
    
    [CBConnect getBrandUncollectTradeMark:params success:^(id responseObject) {
        
        [LCProgressHUD showSuccess:@"取消收藏成功"];
        
        [self requestData];
        
    } successBackfailError:^(id responseObject) {
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}

@end
