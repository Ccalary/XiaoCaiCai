//
//  informationVC.m
//  才标网
//
//  Created by baichun on 17/3/14.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "informationVC.h"
#import "GeRenZhongXingCell1.h"
#import "informationCell_2.h"
#import "informationCell_3.h"
#import "InformationCell_4.h"
#import "PleaseNameVC.h"
#import "informationCell_1.h"
#import "TTGroupTagView.h"
#import "ToolsHelper.h"
#import "ShowMoreTextVC.h"
#import "CBConnect.h"
#import "ModelMember.h"
#import "LoginViewController.h"
#import "UserHelper.h"
@interface informationVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSString *cell2Height;
@property (nonatomic, strong) NSString *cell4Height;

@property (nonatomic, strong)ModelMember *model;

@end

@implementation informationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self drawView];
    [self requestData];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //如果从首页来隐藏navigationBar 解决侧滑navigation显示Bug
    if (_isFromMain){
        self.navigationController.navigationBar.hidden = YES;
    }else {
        [self.navigationController setNavigationBarHidden:YES animated:animated];
    }
}

- (void)drawView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    self.tableView.backgroundColor = [UIColor whiteColor];
    tableView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,-20)
    .bottomSpaceToView(self.view,50*UIRate);
    
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10*UIRate, 30*UIRate, 30*UIRate, 30*UIRate)];
    [backBtn setImage:[UIImage imageNamed:@"nav_back_white_12x22"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    UIView *footView = [[UIView alloc] init];
    footView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:footView];
    
    UIButton *releaseBtn = [[UIButton alloc]init];
    [releaseBtn setTitle:@"请他取名" forState:UIControlStateNormal];
    [releaseBtn setTitleColor:COLOR_OrangeRed forState:UIControlStateNormal];
    releaseBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [releaseBtn addTarget:self action:@selector(footViewAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view  addSubview:releaseBtn];
    
    UIView *dividerLine = [[UIView alloc] init];
    dividerLine.backgroundColor = COLOR_LineViewColor;
    [self.view addSubview:dividerLine];
    
    footView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .bottomSpaceToView(self.view,0)
    .heightIs(50*UIRate);
    
    releaseBtn.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .bottomSpaceToView(self.view,0)
    .heightIs(50*UIRate);
    
    dividerLine.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topEqualToView(footView)
    .heightIs(1);
}


#pragma mark ================= <UITableViewDelegate,UITableViewDataSource> =================
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 1) {
        informationCell_2 *cell = [informationCell_2 cellWithTableView:tableView];
        cell.model = self.model;
        return cell;
    }
    if (indexPath.section == 2) {
        informationCell_3 *cell = [informationCell_3 cellWithTableView:tableView];
        cell.model = self.model;
        __weak typeof (self) weakSelf = self;
        cell.block = ^(NSString *str){
            ShowMoreTextVC *vc = [[ShowMoreTextVC alloc] init];
            vc.titleStr = @"大师简介";
            vc.textStr = str;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        return cell;
    }
    if (indexPath.section == 3) {
        
        static NSString *idenifier = @"InformationCell_4";
        InformationCell_4 *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
        cell = [[InformationCell_4 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier andNum:(int)self.model.caseList.count];
        cell.model = self.model;
         
        return cell;
    }

    informationCell_1 *cell = [informationCell_1 cellWithTableView:tableView];
    cell.model = self.model;
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        
        //cell2标签高度
        NSString *specialStr = self.model.memberExtend.teDian;
        NSArray *array = [specialStr componentsSeparatedByString:@"#"];
        self.cell2Height = [ToolsHelper tagHeightWithArray:array andWidht:ScreenWidth andCornerScale:0.2];
        
        return 40*UIRate + self.cell2Height.doubleValue;
    }
    if (indexPath.section == 2) {
        return 120*UIRate;
    }
    if (indexPath.section == 3) {
        
        //图片的行数
        
        int i = ((int)self.model.caseList.count - 1)/3;
        
        CGFloat rowHeight = (ScreenWidth - 40*UIRate)/3.0 + 10*UIRate;
        
        return 45*UIRate + (i+1)*rowHeight;
    }
    return 170*UIRate;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

#pragma mark - Action
//返回
- (void)backBtnAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)footViewAction{
    if (![UserHelper IsLogin]) {
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        BaseNavigationController *baseNav = [[BaseNavigationController alloc] initWithRootViewController:loginVC];
        [self presentViewController:baseNav animated:YES completion:nil];
        return;
    }
    PleaseNameVC *vc = [[PleaseNameVC alloc]init];
    vc.modelMember = self.model;
    vc.isDealNav = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - =================网络请求=================
- (void)requestData{
    
    [LCProgressHUD showLoading:@"正在加载..."];
    
    NSMutableDictionary *params = [CBConnect getBaseRequestParams];
    [params setValue:self.memberId forKey:@"memberId"];
    
    [CBConnect getHomeMemberViewMember:params success:^(id responseObject) {
        self.model = [ModelMember mj_objectWithKeyValues:responseObject];
        [self.tableView reloadData];
        
    } successBackfailError:^(id responseObject) {
     
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}

@end
