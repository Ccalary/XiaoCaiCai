//
//  ClassificationVC_3.m
//  才标网
//
//  Created by baichun on 17/3/28.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "ClassificationVC_3.h"
#import "ClassificationCell.h"
#import "TradeMarkCategoryModel.h"
#import "ClassificationCell_1.h"
#import "NavigationView.h"
#import "CBConnect.h"
#import "BaseTableView.h"
@interface ClassificationVC_3 ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) BaseTableView *tableView;
@property (nonatomic,strong) NSMutableArray *classificationArray;

@end

@implementation ClassificationVC_3
-(NSMutableArray *)classificationArray{
    if (!_classificationArray) {
        _classificationArray = [NSMutableArray array];
    }
    return _classificationArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.titleText;
    [self drawView];
    [self requesData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)drawView{
    
    self.tableView = [[BaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
    
    _tableView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,0)
    .bottomSpaceToView(self.view,0);
}

#pragma mark - ======== <UITableViewDelegate,UITableViewDataSource> =========
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.classificationArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ClassificationCell_1 *cell = [ClassificationCell_1 cellWithTableView:tableView];
    TradeMarkCategoryModel *model = self.classificationArray[indexPath.row];
    cell.titleLabel.text = [NSString stringWithFormat:@"%@ %@",model.category_name?:@"", model.category_trademark_code?:@""];
    cell.accessoryType = UITableViewCellAccessoryNone;
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma  mark ============网络请求===============
- (void)requesData{
    NSMutableDictionary *params = [CBConnect getBaseRequestParams];
    [params setValue:@"1" forKey:@"pageNo"];
    [params setValue:@"1000" forKey:@"pageSize"];
    [params setValue:_filter_parent_id forKey:@"filter_parent_id"];
    [CBConnect getHomeListCateTree:params success:^(id responseObject) {
        NSArray *array = [TradeMarkCategoryModel mj_objectArrayWithKeyValuesArray:responseObject];
        [self.classificationArray addObjectsFromArray:array];
        [self.tableView reloadData];
    } successBackfailError:^(id responseObject) {
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}

@end
