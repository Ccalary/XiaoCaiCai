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

@interface TouGaoRenRenZhengVC ()<UITableViewDelegate,UITableViewDataSource,AddressPickerViewDelegate>

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *cellsArray;
@property (nonatomic, weak) AddressPickerView *districtFullNamePickView;

@property (nonatomic, weak) UIImage *shengFengZhengImage;
@property (nonatomic, assign) int provinceId;
@property (nonatomic, assign) int cityId;
@property (nonatomic, copy) NSString *provinceName;
@property (nonatomic, copy) NSString *cityName;
@property (nonatomic, copy) NSString *trueName;
@property (nonatomic, copy) NSString *attr1;

@end

@implementation TouGaoRenRenZhengVC

- (AddressPickerView *)districtFullNamePickView
{
    if (!_districtFullNamePickView)
    {
        AddressPickerView *pickView = [[AddressPickerView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight + 64)];
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
    // Do any additional setup after loading the view.
    
    self.title = @"投稿人认证";
    
    [self drawView];
    [self updataCells];
}

- (void)drawView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = HEXCOLOR(0xf5f5f5);
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    UIButton *commitBtn = [[UIButton alloc] init];
    [commitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    commitBtn.backgroundColor = HEXCOLOR(0x38afed);
    commitBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [commitBtn addTarget:self action:@selector(requestAddMemberAuthApply) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:commitBtn];
    
    commitBtn.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .bottomSpaceToView(self.view,0)
    .heightIs(40);
    
    if ([ModelMember shareModelMember].memberAuthApply)
    {
        commitBtn.hidden = YES;
        commitBtn.sd_layout
        .leftSpaceToView(self.view,0)
        .rightSpaceToView(self.view,0)
        .bottomSpaceToView(self.view,0)
        .heightIs(0);
    }
    else
    {
        commitBtn.sd_layout
        .leftSpaceToView(self.view,0)
        .rightSpaceToView(self.view,0)
        .bottomSpaceToView(self.view,0)
        .heightIs(40);
    }
    
    tableView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,0)
    .bottomSpaceToView(commitBtn,0);
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
    
    if ([ModelMember shareModelMember].memberAuthApply) {
        NSDictionary *dic4 = @{kCell:@"TouGaoRenRenZhengCell6"};
        [array3 addObject:dic4];
    }else{
        NSDictionary *dic4 = @{kCell:@"TouGaoRenRenZhengCell4"};
        [array3 addObject:dic4];
    }
    
    NSDictionary *dic5 = @{kCell:@"TouGaoRenRenZhengCell5"};
    [array3 addObject:dic5];
    
    [self.cellsArray addObject:array1];
    [self.cellsArray addObject:array2];
    [self.cellsArray addObject:array3];
    
    [self.tableView reloadData];
}

#pragma mark -
#pragma mark ================= 网络 =================
- (void)requestAddMemberAuthApply
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:[ModelMember shareModelMember].memberId forKey:@"memberId"];
    [params setValue:[ModelMember shareModelMember].memberName forKey:@"memberName"];
    [params setValue:@"1" forKey:@"authType"];
    
    if (self.trueName.length) {
        [params setValue:@"1" forKey:@"trueName"];
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
    
    
    NSMutableArray *fileInfos = [NSMutableArray array];
    if (self.shengFengZhengImage)
    {
        NSDictionary *dic = @{@"kFileData":UIImageJPEGRepresentation(self.shengFengZhengImage, 0.1),
                              @"kName":@"original1",
                              @"kFileName":@"original1.jpg",
                              @"kMimeType":@"image/png"};
        [fileInfos addObject:dic];
    }else{
        [LCProgressHUD showInfoMsg:@"请选取身份证照片"];
        return;
    }
    
    [[LQHTTPSessionManager sharedManager] LQPost:@"member/addMemberAuthApply" parameters:params fileInfo:fileInfos showTips:@"正在上传..." success:^(id responseObject) {
        
        [LCProgressHUD showSuccess:@"提交成功"];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [DCURLRouter popViewControllerAnimated:YES];
        });
        
    } successBackfailError:^(id responseObject) {
        
    } failure:^(NSError *error) {
        
    }];
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
        
        return cell;
    }
    
    if ([dic[kCell] isEqualToString:@"TouGaoRenRenZhengCell2"])
    {
        TouGaoRenRenZhengCell2 *cell = [TouGaoRenRenZhengCell2 cellWithTableView:tableView];
        cell.provinceName = self.provinceName;
        cell.cityName = self.cityName;
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
        
        return cell;
    }
    
    if ([dic[kCell] isEqualToString:@"TouGaoRenRenZhengCell5"])
    {
        TouGaoRenRenZhengCell5 *cell = [TouGaoRenRenZhengCell5 cellWithTableView:tableView];
        
        __weak typeof(self) weakSelf = self;
        cell.didChoosePtoto = ^(UIImage *image){
            weakSelf.shengFengZhengImage = image;
        };
        
        return cell;
    }
    
    if ([dic[kCell] isEqualToString:@"TouGaoRenRenZhengCell6"])
    {
        TouGaoRenRenZhengCell6 *cell = [TouGaoRenRenZhengCell6 cellWithTableView:tableView];
        cell.str = [ModelMember shareModelMember].memberAuthApply.attr1;
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
        return 40;
    }
    
    if ([dic[kCell] isEqualToString:@"TouGaoRenRenZhengCell2"])
    {
        return 40;
    }
    
    if ([dic[kCell] isEqualToString:@"TouGaoRenRenZhengCell3"])
    {
        return 30;
    }
    
    if ([dic[kCell] isEqualToString:@"TouGaoRenRenZhengCell4"])
    {
        return 140;
    }
    
    if ([dic[kCell] isEqualToString:@"TouGaoRenRenZhengCell5"])
    {
        return 339/2+60;
    }
    
    if ([dic[kCell] isEqualToString:@"TouGaoRenRenZhengCell6"])
    {
        return [tableView cellHeightForIndexPath:indexPath model:[ModelMember shareModelMember].memberAuthApply.attr1 keyPath:@"str" cellClass:[TouGaoRenRenZhengCell6 class] contentViewWidth:ScreenWidth];
    }
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([ModelMember shareModelMember].memberAuthApply)
    {
        return;
    }
    
    
    NSMutableArray *array = self.cellsArray[indexPath.section];
    NSDictionary *dic = array[indexPath.row];
    
    if ([dic[kCell] isEqualToString:@"TouGaoRenRenZhengCell2"])
    {
        [self.view endEditing:YES];
//        NSString *address =[NSString stringWithFormat:@"%@ %@ %@",self.provinceName,self.cityName,self.districtName];
        self.districtFullNamePickView.hidden = NO;
        [self.districtFullNamePickView showMyPickerWithAddress:nil];
        
    }
    
}

#pragma mark -
#pragma mark ================= AddressPickerViewDelegate =================
- (void)ensureWithAddress:(NSString *)address provinceId:(NSInteger)provinceId provinceName:(NSString *)provinceName cityId:(NSInteger)cityId  cityName:(NSString *)cityName locationDistrictId:(NSInteger)locationDistrictId locationDistrictName:(NSString *)locationDistrictName
{
    self.provinceId = (int)provinceId;
    self.cityId = (int)cityId;
    self.provinceName = provinceName;
    self.cityName = cityName;
    
    [self.tableView reloadData];
}

@end
