//
//  SelfhelpVC.m
//  才标网
//
//  Created by baichun on 17/3/18.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "SelfhelpVC.h"
#import "SelfhelpCell_1.h"
#import "SelfhelpCell_2.h"
#import "AccordingindustryVC.h"
#import "CBConnect.h"
#import "CompanyTypeModel.h"
#import "CNPPopupController.h"
#import "CategoryPopView.h"

@interface SelfhelpVC ()<UITableViewDelegate,UITableViewDataSource,LCActionSheetDelegate>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *industryArray;
@property (nonatomic, strong) NSMutableArray *idArray;
@property (nonatomic, strong) CNPPopupController *popupController;
@property (nonatomic, strong) CategoryPopView *companyPopView;

@property (nonatomic, strong) NSString *selectStr;

@property (nonatomic, strong) NSString *categoryId;

@property (nonatomic, strong) NSString *searchText;

@end

@implementation SelfhelpVC
-(NSMutableArray *)idArray{
    if (!_idArray) {
        _idArray = [NSMutableArray array];
    }
    return _idArray;
}
-(NSMutableArray *)industryArray{
    if (!_industryArray) {
        _industryArray = [NSMutableArray array];
    }
    return _industryArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"智能取名";
    
    [self drawView];
    [self requesData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


-(void)drawView{
    
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
    .topSpaceToView(self.view,0)
    .bottomSpaceToView(self.view,0);
}

//行业分类
- (CategoryPopView *)companyPopView
{
    if (!_companyPopView){
        
        _companyPopView = [[CategoryPopView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 240*UIRate) andArray:self.industryArray];
        __weak typeof (self) weakSelf = self;
        _companyPopView.block = ^(int row){ // -1为取消
            if (row >= 0){
                weakSelf.selectStr = weakSelf.industryArray[row];
                weakSelf.categoryId = weakSelf.idArray[row];
                NSArray *position = @[[NSIndexPath indexPathForRow:0 inSection:0]];
                [weakSelf.tableView reloadRowsAtIndexPaths:position withRowAnimation:UITableViewRowAnimationNone];
            }
            [weakSelf.popupController dismissPopupControllerAnimated:YES];
            
        };
    }
    return _companyPopView;
}


#pragma mark - ======== <UITableViewDelegate,UITableViewDataSource> =========
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0){
        SelfhelpCell_1 *cell = [SelfhelpCell_1 cellWithTableView:tableView];
        cell.industryLabel.text = self.selectStr ?: @"请选择行业";
        
        __weak typeof (self) weakSelf = self;
        cell.block0 = ^(){
            [weakSelf showBrandSheet];
        };
        
        //按行业起名
        cell.block1 = ^(){
            if (!weakSelf.categoryId.length){
                [LCProgressHUD showFailure:@"请选择行业"];
                return;
            }
            //跳转
            AccordingindustryVC *vc = [[AccordingindustryVC alloc]init];
            vc.companyId = [NSString stringWithFormat:@"%@",weakSelf.categoryId];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };

        return cell;
    }
    
    if (indexPath.section == 1) {
        __weak typeof (self) weakSelf = self;
        SelfhelpCell_2 *cell = [SelfhelpCell_2 cellWithTableView:tableView];
        
        [cell.textFd addTarget:self action:@selector(textFieldAction:) forControlEvents:UIControlEventEditingChanged];
        
        cell.block0 = ^(){
            
            if (!weakSelf.searchText.length){
                [LCProgressHUD showFailure:@"请输入关键字"];
                return;
            }
            
            [weakSelf.view endEditing:YES];
            //跳转
            AccordingindustryVC *vc = [[AccordingindustryVC alloc]init];
            vc.keyStr = weakSelf.searchText;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        return cell;
    }
    
    return [[UITableViewCell alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100*UIRate;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20*UIRate;
}

#pragma mark - Action

- (void)textFieldAction:(UITextField *)textField{
    
    self.searchText = textField.text;
}

//商标分类弹出窗
- (void)showBrandSheet{
    
    self.popupController = [[CNPPopupController alloc] initWithContents:@[self.companyPopView]];
    self.popupController.theme.popupStyle = CNPPopupStyleActionSheet;
    self.popupController.theme.cornerRadius = 0;
    [self.popupController presentPopupControllerAnimated:YES];
}


#pragma mark - ============网络请求=============
-(void)requesData{
    
    NSMutableDictionary *params3 = [[NSMutableDictionary alloc]init];
    [CBConnect getHomeTrademarkCompanyType:params3 success:^(id responseObject) {
        
        NSArray *array = [CompanyTypeModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
        for (CompanyTypeModel *model in array) {
            [self.idArray addObject:model.sid?:@""];
            [self.industryArray addObject:model.name?:@""];
        }
        
    } successBackfailError:^(id responseObject) {
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}

@end
