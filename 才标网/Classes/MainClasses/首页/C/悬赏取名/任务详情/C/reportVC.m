//
//  reportVC.m
//  才标网
//
//  Created by baichun on 17/3/27.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "reportVC.h"
#import "reportCell.h"
#import "addedVC.h"
#import "CBConnect.h"
#import "UserHelper.h"
@interface reportVC ()<UITableViewDelegate,UITableViewDataSource>

{
    NSArray *dataArray;
}

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic, retain) NSIndexPath* checkedIndexPath;

@end

@implementation reportVC

-(void)viewDidAppear:(BOOL)animated

{   [super viewDidAppear:animated];
    
    [self.tableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    

    [self drawView];
}
-(void)drawView{
    
    dataArray = @[@[@"色情",@"诈骗",@"咒骂谩骂",@"政治敏感",@"垃圾广告"],@[@"补充说明"]];
    self.navigationItem.title = @"举报";
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    self.tableView.backgroundColor = COLOR_BackgroundColor;
    [self.view addSubview:_tableView];
    _tableView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,0)
    .bottomSpaceToView(self.view,0);
    UIView *footView = [[[UIView alloc]init]initWithFrame:CGRectZero];
    UIButton *releaseBtn = [[UIButton alloc]init];
    [releaseBtn setTitle:@"我要举报" forState:UIControlStateNormal];
    [releaseBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    releaseBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    
    releaseBtn.backgroundColor = HEXCOLOR(0xff5c0b);
    [releaseBtn addTarget:self action:@selector(footViewAction) forControlEvents:UIControlEventTouchUpInside];
    releaseBtn.layer.cornerRadius = 10;
    releaseBtn.clipsToBounds = YES;
    [footView addSubview:releaseBtn];
     _tableView.tableFooterView = footView;
   
    
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



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 5;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        reportCell *cell = [reportCell cellWithTableView:tableView];
        cell.titleLabel.text = dataArray[indexPath.section][indexPath.row];
        cell.imageV.hidden = YES;
        return cell;
        if([self.checkedIndexPath isEqual:indexPath])
        {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        else
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
   
    reportCell *cell = [reportCell cellWithTableView:tableView];
    if (self.str == nil) {
        cell.titleLabel.text = dataArray[indexPath.section][indexPath.row];
    }else{
        cell.titleLabel.text = self.str;
    }
    

    
    cell.imageV.hidden = YES;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 30;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *header = [[UIView alloc]init];
    UILabel *titleLabel = [[UILabel alloc]init];
    if (section == 0) {
        titleLabel.text = @"请选择举报原因";
    }else{
        titleLabel.text = @"请举证";
    }
    titleLabel.font = [UIFont systemFontOfSize:13*UIRate];
    titleLabel.textColor = COLOR_Gray;
    [header addSubview:titleLabel];
    
    titleLabel.sd_layout
    .leftSpaceToView(header,15*UIRate)
    .rightSpaceToView(header,15*UIRate)
    .centerYEqualToView(header)
    .heightIs(20*UIRate);
    return header;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if(self.checkedIndexPath)
        {
            reportCell* uncheckCell = [tableView
                                       cellForRowAtIndexPath:self.checkedIndexPath];
            uncheckCell.accessoryType = UITableViewCellAccessoryNone;
        }
        if([self.checkedIndexPath isEqual:indexPath])
        {
            self.checkedIndexPath = nil;
        }
        else
        {
            UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            self.checkedIndexPath = indexPath;
        }

    }
    
    if (indexPath.section == 1) {
        
        //  跳转到补充说明
        addedVC *vc = [[addedVC alloc]init];
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }
}

#pragma mark ======= 上传举报 ===========
-(void)footViewAction{
    
    DLog(@"%ld",(long)self.checkedIndexPath.row+1);
    NSMutableDictionary *params = [CBConnect getBaseRequestParams];
    [params setValue:[UserHelper getMemberName] forKey:@"nickName"];
    [params setValue:self.entityMode forKey:@"entityMode"];
    [params setValue:@(self.TouGaoId) forKey:@"entityId"];
    [params setValue:self.brandName forKey:@"entityName"];
    [params setValue:@(self.checkedIndexPath.row+1) forKey:@"impeachType"];
    if (self.str.length) {
        [params setValue:self.str forKey:@"additionalInfo"];
    }
    
    [CBConnect getHomeAddImpeach:params success:^(id responseObject) {
        [LCProgressHUD showSuccess:@"举报成功"];
        [self.navigationController popViewControllerAnimated:YES];
    } successBackfailError:^(id responseObject) {
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
