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
#import "SettingViewController.h"
#import "PersonalInfoVC.h"
#import "RewardTaskVC.h"
#import "MasterTaskVC.h"
#import "IamMasterVC.h"
#import "ReviewResultVC.h"
#import "MessageViewController.h"
#import "WalletViewController.h"
#import "BrandFavourVC.h"
#import "MyContributeVC.h"

@interface GeRenZhongXingVC ()<UITableViewDelegate,UITableViewDataSource,GeRenZhongXingCell3Delegate>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *cellsArray;
@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, strong) NSMutableArray *imageArray1;

@end

@implementation GeRenZhongXingVC

- (NSMutableArray *)cellsArray
{
    if (!_cellsArray) {
        _cellsArray = [NSMutableArray array];
    }
    
    return _cellsArray;
}
-(NSMutableArray *)imageArray{
    
    if (!_imageArray) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}
-(NSMutableArray *)imageArray1{
        
        if (!_imageArray1) {
            _imageArray1 = [NSMutableArray array];
    }
        return _imageArray1;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self drawView];
    [self updataCells];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
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
    self.imageArray = [NSMutableArray array];
    self.imageArray1 = [NSMutableArray array];

    self.imageArray = [@[@"icon-dingdan",@"icon-fucha",@"icon-shoucang",@"icon-xiaoxi"]mutableCopy];
    
    self.imageArray1 = [@[@"icon-zilaio",@"icon-qianbao",@"icon-renzheng",@"icon-shezhi"]mutableCopy];
    

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
    NSDictionary *dic3_1 = @{kCell:@"GeRenZhongXingCell2",kTitle:@"个人资料"};
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
        cell.backgroundColor = COLOR_BackgroundColor;
        return cell;
    }
    if ([dic[kCell] isEqualToString:@"GeRenZhongXingCell2"])
    {
        GeRenZhongXingCell2 *cell = [GeRenZhongXingCell2 cellWithTableView:tableView];
        cell.lblTitle.text = dic[kTitle];
        if (indexPath.section == 2) {
            cell.imgvHeader.image = [UIImage imageNamed:self.imageArray1[indexPath.row]];
        }else{
            
            cell.imgvHeader.image = [UIImage imageNamed:self.imageArray[indexPath.row]];
        }

        return cell;
    }
    if ([dic[kCell] isEqualToString:@"GeRenZhongXingCell3"])
    {
        GeRenZhongXingCell3 *cell = [GeRenZhongXingCell3 cellWithTableView:tableView];
        cell.delegate = self;
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
        return 200*UIRate;
    }
    if ([dic[kCell] isEqualToString:@"GeRenZhongXingCell2"])
    {
        return 40*UIRate;
    }
    if ([dic[kCell] isEqualToString:@"GeRenZhongXingCell3"])
    {
        return 90*UIRate;
    }
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 3) {
        return 0;
    }
    
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    DLog(@"%ld %ld",indexPath.section,indexPath.row);
    NSMutableArray *array = self.cellsArray[indexPath.section];
    NSDictionary *dic = array[indexPath.row];
    
    //点击顶部头像
    if ([dic[kCell] isEqualToString:@"GeRenZhongXingCell1"])
    {
        PersonalInfoVC *personalVC = [[PersonalInfoVC alloc] init];
        [self.navigationController pushViewController:personalVC animated:YES];
    }
    
    if (indexPath.section == 1){
        switch (indexPath.row) {
            case 0://我的订单
            {
               
            }
                break;
            case 1://复查结果
            {
                ReviewResultVC *vc = [[ReviewResultVC alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 2://商标收藏
            {
                BrandFavourVC *vc = [[BrandFavourVC alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 3://消息
            {
                MessageViewController *vc = [[MessageViewController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            default:
                break;
        }
    }
   
    if (indexPath.section == 2){
        
        switch (indexPath.row) {
            case 0://个人资料
            {
                PersonalInfoVC *personalVC = [[PersonalInfoVC alloc] init];
                [self.navigationController pushViewController:personalVC animated:YES];
                
            }
                break;
            case 1://钱包
            {
                WalletViewController *vc = [[WalletViewController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 2://投稿人认证
            {
                TouGaoRenRenZhengVC *vc = [[TouGaoRenRenZhengVC alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
                
                break;
            case 3://设置
            {
                SettingViewController *settingVC = [[SettingViewController alloc] init];
                [self.navigationController pushViewController:settingVC animated:YES];
            }
                break;
                
            default:
                break;
        }

    }
}

#pragma mark - GeRenZhongXingCell3Delegate
- (void)GeRenZhongXingCell3ClickButtonWithTag:(int)tag
{
    switch (tag) {
        case 60000://悬赏任务
        {
            RewardTaskVC *vc = [[RewardTaskVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 60001://我的投稿
        {
            MyContributeVC *vc = [[MyContributeVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 60002://大师任务
        {
            MasterTaskVC *vc = [[MasterTaskVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 60003://我是大师
        {
            IamMasterVC *vc = [[IamMasterVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
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
        
//        WINDOW.rootViewController = [LQAppFrameTabBarController sharedMainTabBar];
        
        TouGaoRenRenZhengVC *vc = [TouGaoRenRenZhengVC new];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    } successBackfailError:^(id responseObject) {
        
    } failure:^(NSError *error) {
        
    }];
}

@end
