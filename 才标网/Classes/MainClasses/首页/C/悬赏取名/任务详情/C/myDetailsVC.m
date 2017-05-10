//
//  myDetailsVC.m
//  才标网
//
//  Created by baichun on 17/3/18.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "myDetailsVC.h"
#import "RenWuXiangQingCell_1.h"
#import "RenWuXiangQingCell_2.h"
#import "RenWuXiangQingCell_3.h"
#import "RenWuXiangQingCell_4.h"
#import "contributeVC.h"
#import "RenWuXiangQingCell_5.h"
#import "CBConnect.h"
#import "TaskModel.h"
#import "ToolsHelper.h"
#import "RegisterTrademarkVC.h"
#import "reportVC.h"
@interface myDetailsVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *dataArray1;
@property(nonatomic,strong)NSString *showStr;
@property(nonatomic,strong)NSArray *itemContentsArr;

@end

@implementation myDetailsVC
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
-(NSMutableArray *)dataArray1{
    if (!_dataArray1) {
        _dataArray1 = [NSMutableArray array];
    }
    return _dataArray1;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"任务详情";
    
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithTitle:@"举报" style:UIBarButtonItemStylePlain target:self action:@selector(reportAction)];
    self.navigationItem.rightBarButtonItem = barItem;
    
    [self drawView];
    [self requesData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)drawView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
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
    UIButton *releaseBtn = [[UIButton alloc]init];
    [releaseBtn setTitle:@"我要投稿" forState:UIControlStateNormal];
    [releaseBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    releaseBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    
    releaseBtn.backgroundColor = HEXCOLOR(0xff5c0b);
    [releaseBtn addTarget:self action:@selector(footViewAction) forControlEvents:UIControlEventTouchUpInside];
    releaseBtn.layer.cornerRadius = 10;
    releaseBtn.clipsToBounds = YES;
    [footView addSubview:releaseBtn];
   // self.tableView.tableFooterView = footView;
    //    [self.view addSubview:footView];
    
    footView.sd_layout
    .leftSpaceToView(self.view,20*UIRate)
    .rightSpaceToView(self.view,20*UIRate)
    .topSpaceToView(self.view,10*UIRate)
    .heightIs(40*UIRate);
    
    
    releaseBtn.sd_layout
    .leftSpaceToView(footView,20*UIRate)
    .rightSpaceToView(footView,20*UIRate)
    .topSpaceToView(footView,10*UIRate)
    .heightIs(40*UIRate);
    
}

#pragma mark - ======== footView点击事件 =========
-(void)footViewAction{
    
    contributeVC *vc = [[contributeVC alloc]init];
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
        __weak myDetailsVC *weakSelf = self;
        RenWuXiangQingCell_3 *cell = [RenWuXiangQingCell_3 cellWithTableView:tableView];
        cell.trademarblock = ^(NSString *nameStr){
            //商标注册回调
            RegisterTrademarkVC *vc = [[RegisterTrademarkVC alloc]init];
            vc.nameStr = [nameStr copy];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        cell.adoptblock = ^(int TouGaoId){
             //采纳回调
            [weakSelf adoptData:TouGaoId];
        };
        
        cell.reporblock = ^(int TouGaoId,NSString *brandName){
          //举报回调
            reportVC *vc = [[reportVC alloc]init];
            vc.TouGaoId = TouGaoId;
            vc.brandName = brandName;
            vc.entityMode = @"3";
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        
        if (self.dataArray.count == 0) {
            
        }else{
        TaskTouGaoModel *model = self.dataArray[indexPath.row];
            TaskModel *model1 = self.dataArray1.firstObject;

            [cell setTaskTouGao:model isXuanShangFenQian:model1.isXuanShangFenQian];
    }
        return cell;
    }
    RenWuXiangQingCell_5 *cell = [RenWuXiangQingCell_5 cellWithTableView:tableView];
    cell.backgroundColor = COLOR_BackgroundColor;
    cell.nameLabel.text = [NSString stringWithFormat:@"所有投稿(%lu)",(unsigned long)self.dataArray.count];

    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        return (215*UIRate+self.showStr.doubleValue);
    }
    if (indexPath.section == 2) {
        return 30*UIRate;
    }
    if (indexPath.section == 3) {
        return 152*UIRate;
    }
    
    return 80*UIRate;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 20;
    }
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

#pragma mark - ======== 我的页面 悬赏任务 任务详情 =========
-(void)requesData{
    NSMutableDictionary *params = [CBConnect getBaseRequestParams];
    [params setValue:@(self.taskId) forKey:@"taskId"];
    
    [CBConnect getHomeTaskViewTask:params success:^(id responseObject) {
        TaskModel *model = [TaskModel mj_objectWithKeyValues:responseObject];
        [self.dataArray removeAllObjects];
        [self.dataArray1 removeAllObjects];
        [self.dataArray addObjectsFromArray:model.taskTouGaoList];
        [self.dataArray1 addObject:model];

        self.showStr = [ToolsHelper tagHeightWithArray: self.itemContentsArr andWidht:ScreenWidth andCornerScale:0.5];
        
        [self.tableView reloadData];
        
    } successBackfailError:^(id responseObject) {
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}

#pragma mark =======  点击采纳 ========
-(void)adoptData:(int)tougaoId{

    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setValue:@(tougaoId) forKey:@"touGaoId"];
    [CBConnect getHomeUseTouGao:params success:^(id responseObject) {
        [LCProgressHUD showSuccess:@"采纳成功"];
         // 采纳成功后
        [self requesData];
    } successBackfailError:^(id responseObject) {
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];

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
