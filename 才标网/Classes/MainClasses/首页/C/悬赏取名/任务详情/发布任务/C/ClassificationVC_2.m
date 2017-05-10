//
//  ClassificationVC_2.m
//  才标网
//
//  Created by baichun on 17/3/28.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "ClassificationVC_2.h"
#import "ClassificationCell.h"
#import "TradeMarkCategoryModel.h"
#import "ClassificationCell_1.h"
#import "ClassificationVC_3.h"
#import "NavigationView.h"
#import "CBConnect.h"
#import "ClassificationCell_2.h"
@interface ClassificationVC_2 ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *classificationArray;
@end

@implementation ClassificationVC_2
-(NSMutableArray *)classificationArray{
    
    if (!_classificationArray) {
        _classificationArray = [NSMutableArray array];
    }
    return _classificationArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.title = self.titleText;
    [self drawView];
    [self requesData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.hidden = YES;
}

-(void)drawView{
    
    //处理Nav
//    __weak typeof (self) weakSelf = self;
//    NavigationView *nav = [[NavigationView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64) andTitle:self.titleText block:^{
//        [weakSelf.navigationController popViewControllerAnimated:YES];
//    }];
//    [self.view addSubview:nav];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.tableFooterView = [[UIView alloc] init];
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0 && self.category_title.length > 0) {
        return 1;
    }
    
    return self.classificationArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        ClassificationCell_2 *cell = [ClassificationCell_2 cellWithTableView:tableView];
        cell.titleLabel.text = self.category_title;
        
        return cell;
    }
    
    ClassificationCell_1 *cell = [ClassificationCell_1 cellWithTableView:tableView];
    TradeMarkCategoryModel *model = self.classificationArray[indexPath.row];
    cell.titleLabel.text = [NSString stringWithFormat:@"%@ %@",model.category_group_number?:@"", model.category_name?:@""];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
  
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
      CGFloat height = [NSString calculateStringHeightWithWidth:ScreenWidth - 30*UIRate font:SYSTEM_FONT_(15*UIRate) string:self.category_title];
        DLog(@"height%f",height);
        
        if (height == 0){
            return 0;
        }else {
             return height + 10*UIRate;
        }
    }
    return 44;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TradeMarkCategoryModel *model = self.classificationArray[indexPath.row];
    ClassificationVC_3 *vc = [[ClassificationVC_3 alloc]init];
    vc.titleText = model.category_name;
    vc.filter_parent_id = model.sid;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma  mark ============网络请求===============
- (void)requesData{
    [LCProgressHUD showLoading:@"加载中..."];
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
