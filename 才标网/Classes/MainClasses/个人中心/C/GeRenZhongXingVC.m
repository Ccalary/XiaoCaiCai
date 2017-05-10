//
//  GeRenZhongXingVC.m
//  才标网
//
//  Created by 李强 on 2017/2/17.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "GeRenZhongXingVC.h"
#import "GeRenZhongXingCell1.h"
#import "GeRenZhongXingCell2.h"
#import "GeRenZhongXingCell3.h"
#import "TouGaoRenRenZhengVC.h"

@interface GeRenZhongXingVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *cellsArray;

@end

@implementation GeRenZhongXingVC

- (NSMutableArray *)cellsArray
{
    if (!_cellsArray) {
        _cellsArray = [NSMutableArray array];
    }
    
    return _cellsArray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self drawView];
    [self updataCells];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)drawView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = HEXCOLOR(0xeeeeee);
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    tableView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,-20)
    .bottomSpaceToView(self.view,0);
}

- (void)updataCells
{
    self.cellsArray = [NSMutableArray array];
    
    NSMutableArray *array1 = [NSMutableArray array];
    NSDictionary *dic1_1 = @{kCell:@"GeRenZhongXingCell1"};
    [array1 addObject:dic1_1];
    NSDictionary *dic1_2 = @{kCell:@"GeRenZhongXingCell3"};
    [array1 addObject:dic1_2];
    
    NSMutableArray *array2 = [NSMutableArray array];
    NSDictionary *dic2_1 = @{kCell:@"GeRenZhongXingCell2",kTitle:@"我的订单"};
    [array2 addObject:dic2_1];
    NSDictionary *dic2_2 = @{kCell:@"GeRenZhongXingCell2",kTitle:@"复查结果"};
    [array2 addObject:dic2_2];
    NSDictionary *dic2_3 = @{kCell:@"GeRenZhongXingCell2",kTitle:@"商标收藏"};
    [array2 addObject:dic2_3];
    NSDictionary *dic2_4 = @{kCell:@"GeRenZhongXingCell2",kTitle:@"消息"};
    [array2 addObject:dic2_4];
    
    NSMutableArray *array3 = [NSMutableArray array];
    NSDictionary *dic3_1 = @{kCell:@"GeRenZhongXingCell2",kTitle:@"我的资料"};
    [array3 addObject:dic3_1];
    NSDictionary *dic3_2 = @{kCell:@"GeRenZhongXingCell2",kTitle:@"钱包"};
    [array3 addObject:dic3_2];
    NSDictionary *dic3_3 = @{kCell:@"GeRenZhongXingCell2",kTitle:@"投稿人认证"};
    [array3 addObject:dic3_3];
    NSDictionary *dic3_4 = @{kCell:@"GeRenZhongXingCell2",kTitle:@"设置"};
    [array3 addObject:dic3_4];
    
    
    [self.cellsArray addObject:array1];
    [self.cellsArray addObject:array2];
    [self.cellsArray addObject:array3];
}

#pragma mark -
#pragma mark ================= <UITableViewDelegate,UITableViewDataSource> =================
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.cellsArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSMutableArray *array = self.cellsArray[section];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *array = self.cellsArray[indexPath.section];
    NSDictionary *dic = array[indexPath.row];
    
    if ([dic[kCell] isEqualToString:@"GeRenZhongXingCell1"])
    {
        GeRenZhongXingCell1 *cell = [GeRenZhongXingCell1 cellWithTableView:tableView];
        return cell;
    }
    if ([dic[kCell] isEqualToString:@"GeRenZhongXingCell2"])
    {
        GeRenZhongXingCell2 *cell = [GeRenZhongXingCell2 cellWithTableView:tableView];
        cell.lblTitle.text = dic[kTitle];
        return cell;
    }
    if ([dic[kCell] isEqualToString:@"GeRenZhongXingCell3"])
    {
        GeRenZhongXingCell3 *cell = [GeRenZhongXingCell3 cellWithTableView:tableView];
        return cell;
    }
    
    return [UITableViewCell new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *array = self.cellsArray[indexPath.section];
    NSDictionary *dic = array[indexPath.row];
    
    if ([dic[kCell] isEqualToString:@"GeRenZhongXingCell1"])
    {
        return 150;
    }
    if ([dic[kCell] isEqualToString:@"GeRenZhongXingCell2"])
    {
        return 40;
    }
    if ([dic[kCell] isEqualToString:@"GeRenZhongXingCell3"])
    {
        return ScreenWidth/4 + 20;
    }
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *array = self.cellsArray[indexPath.section];
    NSDictionary *dic = array[indexPath.row];
    
    if ([dic[kCell] isEqualToString:@"GeRenZhongXingCell2"])
    {
        if ([dic[kTitle] isEqualToString:@"投稿人认证"])
        {
            [self requestMember];
        }
    }
}



#pragma mark -
#pragma mark ================= 网络 =================
- (void)requestMember
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:[ModelMember shareModelMember].memberId forKey:@"memberId"];
    
    [[LQHTTPSessionManager sharedManager] LQPost:@"member/viewMember" parameters:params showTips:@"正在获取信息..." success:^(id responseObject) {
        
        ModelMember *modelmember = [ModelMember shareModelMember];
        NSLog(@"%@",modelmember);
        modelmember = [ModelMember mj_objectWithKeyValues:responseObject];
        NSLog(@"%@",modelmember.memberId);
        
        WINDOW.rootViewController = [LQAppFrameTabBarController sharedMainTabBar];
        
        TouGaoRenRenZhengVC *vc = [TouGaoRenRenZhengVC new];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    } successBackfailError:^(id responseObject) {
        
    } failure:^(NSError *error) {
        
    }];
}

@end
