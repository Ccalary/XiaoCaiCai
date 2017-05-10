//
//  TouGaoRenRenZhengVC.m
//  才标网
//
//  Created by 李强 on 2017/2/17.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "TouGaoRenRenZhengVC.h"
#import "TouGaoRenRenZhengCell1.h"
#import "TouGaoRenRenZhengCell2.h"
#import "TouGaoRenRenZhengCell3.h"
#import "TouGaoRenRenZhengCell4.h"
#import "TouGaoRenRenZhengCell5.h"
#import "TouGaoRenRenZhengCell6.h"
#import "AddressPickerView.h"
#import "UserHelper.h"
#import "CBConnect.h"
#import "TouGaoRenZhengModel.h"

@interface TouGaoRenRenZhengVC ()<UITableViewDelegate,UITableViewDataSource,AddressPickerViewDelegate>

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *cellsArray;
@property (nonatomic, strong)  UIButton *commitBtn;

@property (nonatomic, weak) AddressPickerView *districtFullNamePickView;

@property (nonatomic, assign) int provinceId;
@property (nonatomic, assign) int cityId;
@property (nonatomic, strong) NSString *photoImageStr;
@property (nonatomic, copy) NSString *provinceName;
@property (nonatomic, copy) NSString *cityName;
@property (nonatomic, copy) NSString *trueName;
@property (nonatomic, copy) NSString *attr1;

@property (nonatomic, assign) BOOL isCommited;//是否提交过

@property (nonatomic, strong) NSMutableArray *imageArray;

@property (nonatomic, strong) TouGaoRenZhengModel *model;

@end

@implementation TouGaoRenRenZhengVC

- (NSMutableArray *)imageArray
{
    if (!_imageArray){
        _imageArray = [[NSMutableArray alloc] init];
    }
    return _imageArray;
}

- (AddressPickerView *)districtFullNamePickView
{
    if (!_districtFullNamePickView)
    {
        AddressPickerView *pickView = [[AddressPickerView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight2)];
        pickView.delegate = self;
        [self.view.window addSubview: pickView];
        _districtFullNamePickView = pickView;
    }
    
    return _districtFullNamePickView;
}

- (NSMutableArray *)cellsArray
{
    if (!_cellsArray) {
        _cellsArray = [NSMutableArray array];
    }
    return _cellsArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"投稿人认证";
    
    [self drawView];
    [self updataCells];
    
    [self requestData];
}

- (void)drawView
{
    self.view.backgroundColor = HEXCOLOR(0xf5f5f5);  
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = HEXCOLOR(0xf5f5f5);
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    _commitBtn = [[UIButton alloc] init];
    [_commitBtn setTitle:@"提 交" forState:UIControlStateNormal];
    [_commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _commitBtn.backgroundColor = COLOR_LOGIN;
    _commitBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_commitBtn addTarget:self action:@selector(commitBtnAction) forControlEvents:UIControlEventTouchUpInside];
    _commitBtn.layer.cornerRadius = 7.0;
   [self.view addSubview:_commitBtn];
    
    _commitBtn.sd_layout
    .leftSpaceToView(self.view,15)
    .rightSpaceToView(self.view,15)
    .bottomSpaceToView(self.view,10)
    .heightIs(50*UIRate);
   
    tableView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,10)
    .bottomSpaceToView(_commitBtn,10);
}

- (void)updataCells
{
    self.cellsArray = [NSMutableArray array];
    
    NSMutableArray *array1 = [NSMutableArray array];
    NSDictionary *dic = @{kCell:@"TouGaoRenRenZhengCell1"};
    [array1 addObject:dic];
    
    NSMutableArray *array2 = [NSMutableArray array];
    NSDictionary *dic2 = @{kCell:@"TouGaoRenRenZhengCell2"};
    [array2 addObject:dic2];
    
    NSMutableArray *array3 = [NSMutableArray array];
    NSDictionary *dic3 = @{kCell:@"TouGaoRenRenZhengCell3"};
    [array3 addObject:dic3];
   
    NSDictionary *dic4 = @{kCell:@"TouGaoRenRenZhengCell4"};
    [array3 addObject:dic4];
    
    NSDictionary *dic5 = @{kCell:@"TouGaoRenRenZhengCell5"};
    [array3 addObject:dic5];
    
    [self.cellsArray addObject:array1];
    [self.cellsArray addObject:array2];
    [self.cellsArray addObject:array3];
    
    [self.tableView reloadData];
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
    
    if ([dic[kCell] isEqualToString:@"TouGaoRenRenZhengCell1"])
    {
        TouGaoRenRenZhengCell1 *cell = [TouGaoRenRenZhengCell1 cellWithTableView:tableView];
        
        __weak typeof(self) weakSelf = self;
        cell.didHaveTureName = ^(NSString *str){
            weakSelf.trueName = str;
        };
        
        if (self.isCommited){
            cell.textField.text = self.model.trueName;
            cell.textField.userInteractionEnabled = NO;
            
            if (self.model.checkResult == 2){//审核成功
                cell.sureBtn.hidden = NO;
                cell.checkingLabel.hidden = YES;
            }else{//审核中
                cell.checkingLabel.hidden = NO;
                cell.sureBtn.hidden = YES;
            }
        }
        return cell;
    }
    
    if ([dic[kCell] isEqualToString:@"TouGaoRenRenZhengCell2"])
    {
        TouGaoRenRenZhengCell2 *cell = [TouGaoRenRenZhengCell2 cellWithTableView:tableView];
        
        cell.provinceName = self.provinceName;
        cell.cityName = self.cityName;
        if (self.isCommited){
            [cell afterReZheng];
        }
        return cell;
    }
    
    if ([dic[kCell] isEqualToString:@"TouGaoRenRenZhengCell3"])
    {
        TouGaoRenRenZhengCell3 *cell = [TouGaoRenRenZhengCell3 cellWithTableView:tableView];
        return cell;
    }
    
    if ([dic[kCell] isEqualToString:@"TouGaoRenRenZhengCell4"])
    {
        TouGaoRenRenZhengCell4 *cell = [TouGaoRenRenZhengCell4 cellWithTableView:tableView];
        
        __weak typeof(self) weakSelf = self;
        cell.didHaveAttr1 = ^(NSString *str){
            weakSelf.attr1 = str;
        };
        if (self.isCommited){
            [cell afterRenZhengWith:self.attr1];
        }
        
        return cell;
    }
    
    if ([dic[kCell] isEqualToString:@"TouGaoRenRenZhengCell5"])
    {
        TouGaoRenRenZhengCell5 *cell = [TouGaoRenRenZhengCell5 cellWithTableView:tableView];
        
        __weak typeof(self) weakSelf = self;
        cell.didChoosePtoto = ^(UIImage *image){
            [weakSelf.imageArray removeAllObjects];
            [weakSelf.imageArray addObject:image];
        };
        if (_photoImageStr.length && self.isCommited){
            cell.uploadButton.hidden = YES;
            [cell.idImageView sd_setImageWithURL:IMAGE_URL(_photoImageStr)];
        }
        
        return cell;
    }
    
    if ([dic[kCell] isEqualToString:@"TouGaoRenRenZhengCell6"])
    {
        TouGaoRenRenZhengCell6 *cell = [TouGaoRenRenZhengCell6 cellWithTableView:tableView];
//        cell.str = [ModelMember shareModelMember].memberAuthApply.attr1;
        return cell;
    }
    
    return [UITableViewCell new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *array = self.cellsArray[indexPath.section];
    NSDictionary *dic = array[indexPath.row];
    
    if ([dic[kCell] isEqualToString:@"TouGaoRenRenZhengCell1"])
    {
        return 40*UIRate;
    }
    
    if ([dic[kCell] isEqualToString:@"TouGaoRenRenZhengCell2"])
    {
        return 40*UIRate;
    }
    
    if ([dic[kCell] isEqualToString:@"TouGaoRenRenZhengCell3"])
    {
        return 30*UIRate;
    }
    
    if ([dic[kCell] isEqualToString:@"TouGaoRenRenZhengCell4"])
    {
        if (self.isCommited){
             CGFloat height =  [NSString calculateStringHeightWithWidth:ScreenWidth - 30 font:SYSTEM_FONT_(14*UIRate) string:self.attr1];
            return height + 20*UIRate;
        }else {
             return 140*UIRate;
        }
    }
    
    if ([dic[kCell] isEqualToString:@"TouGaoRenRenZhengCell5"])
    {
        return 339/2+85;
    }
    
    if ([dic[kCell] isEqualToString:@"TouGaoRenRenZhengCell6"])
    {
    }
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.isCommited){
        return;
    }
    NSMutableArray *array = self.cellsArray[indexPath.section];
    NSDictionary *dic = array[indexPath.row];
    
    if ([dic[kCell] isEqualToString:@"TouGaoRenRenZhengCell2"])
    {
        [self.view endEditing:YES];
        self.districtFullNamePickView.hidden = NO;
        [self.districtFullNamePickView showMyPickerWithAddress:nil];
    }
}

#pragma mark - Action
//提交
- (void)commitBtnAction{
    [self requestAddMemberAuthApply];
}


#pragma mark - ================= AddressPickerViewDelegate =================
- (void)ensureWithAddress:(NSString *)address provinceId:(NSInteger)provinceId provinceName:(NSString *)provinceName cityId:(NSInteger)cityId  cityName:(NSString *)cityName locationDistrictId:(NSInteger)locationDistrictId locationDistrictName:(NSString *)locationDistrictName
{
    self.provinceId = (int)provinceId;
    self.cityId = (int)cityId;
    self.provinceName = provinceName;
    self.cityName = cityName;
    
    [self.tableView reloadData];
}


#pragma mark - ================= 网络 =================
//数据请求
- (void)requestData{
    [LCProgressHUD showLoading:@"加载中..."];
    NSMutableDictionary *params = [CBConnect getBaseRequestParams];
    
    [CBConnect getUsercenterViewMemberAuthApply:params success:^(id responseObject) {
       
        self.model = [TouGaoRenZhengModel mj_objectWithKeyValues:responseObject];
        
        if (self.model.checkResult == 0 || self.model.checkResult == 3){//0未认证 3认证失败
            self.isCommited = NO;
        }else {
            
            self.isCommited = YES;
            self.trueName = self.model.trueName;
            self.provinceName = self.model.provinceName;
            self.cityName = self.model.cityName;
            self.attr1 = self.model.attr1;
            self.photoImageStr = self.model.original1;
            
            self.commitBtn.hidden = YES;
            
            [self.tableView reloadData];
        }

   } successBackfailError:^(id responseObject) {
       
   } failure:^(NSURLSessionDataTask *operation, NSError *error) {
       
   }];
}


- (void)requestAddMemberAuthApply
{
    NSMutableDictionary *params = [CBConnect getBaseRequestParams];
    [params setValue:[UserHelper getMemberName] forKey:@"memberName"];
    [params setValue:@"1" forKey:@"authType"];
    
    if (self.trueName.length) {
        [params setValue:self.trueName forKey:@"trueName"];
    }else{
        [LCProgressHUD showInfoMsg:@"请填写姓名"];
        return;
    }
    
    if (self.provinceName.length) {
        [params setValue:@(self.provinceId) forKey:@"provinceId"];
        [params setValue:self.provinceName forKey:@"provinceName"];
        [params setValue:@(self.cityId) forKey:@"cityId"];
        [params setValue:self.cityName forKey:@"cityName"];
    }else{
        [LCProgressHUD showInfoMsg:@"请选取地区"];
        return;
    }
    
    if (self.attr1.length) {
        [params setValue:self.attr1 forKey:@"attr1"];
    }

    if (!self.imageArray.count)
    {
        [LCProgressHUD showInfoMsg:@"请选取身份证照片"];
        return;
    }
    
    [LCProgressHUD showLoading:@"提交中..."];
    [CBConnect getUsercenterAddMemberAuthApply:params imageArray:self.imageArray isNone:NO success:^(id responseObject) {
        [LCProgressHUD showSuccess:@"提交成功"];
        
        //延时
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
        
    } successBackfailError:^(id responseObject) {
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}

@end
