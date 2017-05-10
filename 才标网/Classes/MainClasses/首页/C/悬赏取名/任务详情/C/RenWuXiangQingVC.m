//
//  RenWuXiangQingVC.m
//  才标网
//
//  Created by baichun on 17/3/8.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "RenWuXiangQingVC.h"
#import "RenWuXiangQingCell_1.h"
#import "RenWuXiangQingCell_2.h"
#import "RenWuXiangQingCell_4.h"
#import "contributeVC.h"
#import "RenWuXiangQingCell_5.h"
#import "RenWuXiangQingCell_6.h"
#import "CBConnect.h"
#import "TaskModel.h"
#import "ToolsHelper.h"
#import "UserHelper.h"
#import "LoginViewController.h"
#import "reportVC.h"

@interface RenWuXiangQingVC ()<UITableViewDelegate,UITableViewDataSource>



@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSMutableArray *dataArray1;
@property(nonatomic,strong)NSString *showStr;

@property(nonatomic,strong)NSMutableArray *array;
@property(nonatomic,strong)NSArray *itemContentsArr;
@property(nonatomic,strong)NSString *ID;

@property(nonatomic,strong)UIButton  *releaseBtn;

//判断是否分钱截稿
@property (nonatomic,strong) NSString *isXuanShangFenQian;
//判断是否自己发的任务
@property (nonatomic,strong) NSString *selfName;
@end

@implementation RenWuXiangQingVC

-(NSMutableArray *)dataArray1{
    if (!_dataArray1) {
        _dataArray1 = [NSMutableArray array];
    }
    return _dataArray1;
}
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

-(NSMutableArray *)array{
    if (!_array) {
        _array = [NSMutableArray array];
    }
    return _array;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"任务详情";
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithTitle:@"举报" style:UIBarButtonItemStylePlain target:self action:@selector(reportAction)];
    self.navigationItem.rightBarButtonItem = barItem;
    [self drawView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestData];
}

-(void)drawView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.backgroundColor = COLOR_BackgroundColor;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    
    [self.view addSubview:tableView];
    self.tableView = tableView;
        
    tableView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,0)
    .bottomSpaceToView(self.view,0);

    UIView *footView = [[[UIView alloc]init]initWithFrame:CGRectZero];
    self.releaseBtn = [[UIButton alloc]init];
    [_releaseBtn setTitle:@"我要投稿" forState:UIControlStateNormal];
    [_releaseBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _releaseBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    
    _releaseBtn.backgroundColor = HEXCOLOR(0xff5c0b);
    [_releaseBtn addTarget:self action:@selector(footViewAction) forControlEvents:UIControlEventTouchUpInside];
    _releaseBtn.layer.cornerRadius = 10;
    _releaseBtn.clipsToBounds = YES;
    [footView addSubview:_releaseBtn];
    self.tableView.tableFooterView = footView;
//    [self.view addSubview:footView];
  
    //[self jubUser];
    
    footView.sd_layout
    .leftSpaceToView(self.view,20*UIRate)
    .rightSpaceToView(self.view,20*UIRate)
    .topSpaceToView(self.view,10*UIRate)
    .heightIs(60*UIRate);
    
    
    _releaseBtn.sd_layout
    .leftSpaceToView(footView,20*UIRate)
    .rightSpaceToView(footView,20*UIRate)
    .topSpaceToView(footView,10*UIRate)
    .heightIs(40*UIRate);
    __weak typeof(self) weakSelf = self;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [weakSelf requestData];
    }];
}

#pragma mark - ======== footView点击事件 =========
-(void)footViewAction{
    if (![UserHelper IsLogin]){
        
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        BaseNavigationController *baseNav = [[BaseNavigationController alloc] initWithRootViewController:loginVC];
        [self presentViewController:baseNav animated:YES completion:nil];
        return;
    }

    if ([self.selfName isEqualToString:@"自己不能给自己投稿"]) {
        [LCProgressHUD showMessage:@"不可以给自己投稿"];
        return;
    }
    if ([self.isXuanShangFenQian isEqualToString:@"1"]) {
        [LCProgressHUD showMessage:@"已经截稿"];
        return;
    }
    
    contributeVC *vc = [[contributeVC alloc]init];
      TaskModel *model = self.dataArray1.firstObject;
      vc.taskId = model.taskId;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - ======== <UITableViewDelegate,UITableViewDataSource> =========
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 3) {
        return self.dataArray.count;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        RenWuXiangQingCell_1  *cell = [RenWuXiangQingCell_1 cellWithTableView:tableView];
        if (self.dataArray1.count) {
            TaskModel *model = self.dataArray1.firstObject;
            [cell setTaskModel:model];
        }
        return cell;
    }else if (indexPath.section == 1){
    
        RenWuXiangQingCell_2  *cell = [RenWuXiangQingCell_2 cellWithTableView:tableView];
        if (self.dataArray1.count == 0) {
            
        }else{
            TaskModel *model = self.dataArray1.firstObject;
            self.itemContentsArr = [model.itemContents componentsSeparatedByString:@"#"];
            [cell setTaskModel:model itemContents:_itemContentsArr];
        }
        return cell;
    }else if (indexPath.section == 3){
        
        TaskTouGaoModel *model = self.dataArray[indexPath.row];
        NSString *ID = [NSString stringWithFormat:@"%d",model.creatorId];
        if ([ID isEqualToString:[UserHelper getMemberId]]) {
            RenWuXiangQingCell_4 *cell = [RenWuXiangQingCell_4 cellWithTableView:tableView];
            [cell setTaskTouGaoModel:model];

            return cell;

        }else{
            
            RenWuXiangQingCell_6 *cell = [RenWuXiangQingCell_6 cellWithTableView:tableView];
            [cell setTaskTouGaoModel:model];
            return cell;
        }
    }

    RenWuXiangQingCell_5 *cell = [RenWuXiangQingCell_5 cellWithTableView:tableView];
    cell.backgroundColor = COLOR_BackgroundColor;
    cell.nameLabel.text = [NSString stringWithFormat:@"所有投稿(%lu)",(unsigned long)self.dataArray.count];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0){
        
        TaskModel *model = self.dataArray1.firstObject;
        
        CGFloat height  = [NSString calculateStringHeightWithWidth:(200*UIRate) font:SYSTEM_FONT_(14*UIRate) string:model.taskTitle?:@"标题"];
        
        return 65*UIRate + height;
    }
    
    if (indexPath.section == 1) {
        TaskModel *model = self.dataArray1.firstObject;
        CGFloat height = [NSString calculateStringHeightWithWidth:(ScreenWidth-11*UIRate) font:SYSTEM_FONT_(14*UIRate) string:model.requireDetail];

        return (180*UIRate+self.showStr.doubleValue+height);
    }
    if (indexPath.section == 2) {
        return 30*UIRate;
    }
    if (indexPath.section == 3) {
        TaskTouGaoModel *model = self.dataArray[indexPath.row];
        NSString *ID = [NSString stringWithFormat:@"%d",model.creatorId];
        if ([ID isEqualToString:[UserHelper getMemberId]]) {
        return 115*UIRate;
        }else{
        return 60*UIRate;
        }
    }
    return 80*UIRate;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 20;
    }
    
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

-(void)jubUser{
    
    TaskModel *model = self.dataArray1.firstObject;
    NSString *creatorId = [NSString stringWithFormat:@"%d",model.creatorId];
    NSString *userCreat = [UserHelper getMemberId];
    DLog(@"creatorId+%@ userCreat+%@",creatorId,userCreat);
    if ([creatorId isEqualToString:userCreat]) {
        self.selfName = @"自己不能给自己投稿";
    }else{
        //self.releaseBtn.hidden = NO;
    }
    self.isXuanShangFenQian = [NSString stringWithFormat:@"%d",model.isXuanShangFenQian];
    
}



#pragma mark - ============网络－任务广场任务详情===============
- (void)requestData {
    
    [LCProgressHUD showLoading:@"正在加载..."];
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setValue:@(self.taskId) forKey:@"taskId"];
   [CBConnect getHomeTaskViewTask:params success:^(id responseObject) {
      
       TaskModel *model = [TaskModel mj_objectWithKeyValues:responseObject];
       [self.dataArray removeAllObjects];
       [self.dataArray1 removeAllObjects];
       [self.dataArray addObjectsFromArray:model.taskTouGaoList];
       [self.dataArray1 addObject:model];
       
      NSArray *array = [model.itemContents componentsSeparatedByString:@"#"];
       
       self.showStr = [ToolsHelper tagHeightWithArray:array andWidht:ScreenWidth andCornerScale:0.5];
         [self jubUser];
       
       [self.tableView.mj_header endRefreshing];
       [self.tableView reloadData];
      
   } successBackfailError:^(id responseObject) {
       [self.tableView.mj_header endRefreshing];

   } failure:^(NSURLSessionDataTask *operation, NSError *error) {
    
   }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

//举报
- (void)reportAction{
    if (self.dataArray1.count) {
        TaskModel *model = self.dataArray1.firstObject;
        reportVC *vc = [[reportVC alloc]init];
        vc.TouGaoId = model.taskId;
        vc.brandName = model.taskTitle;
        vc.entityMode = @"1";
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
