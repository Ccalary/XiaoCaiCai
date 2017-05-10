//
//  PleaseNameVC.m
//  才标网
//
//  Created by baichun on 17/3/15.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "PleaseNameVC.h"
#import "masterDetailsCell_8.h"
#import "ReleaseVCell_1.h"
#import "ReleaseVCell_2.h"
#import "ReleaseVCell_3.h"
#import "ReleaseVCell_4.h"

#import "PleaseNameCell_1.h"
#import "PleaseNameCell_2.h"
#import "PleaseNameCell_3.h"
#import "PleaseNameCell_4.h"
#import "ReleaseVCell_5.h"
#import "PleaseNameCell_5.h"
#import "PleaseNameCell_6.h"
#import "PleaseNameCell_7.h"
#import "queryCell_2.h"
#import "PleaseNameCell_8.h"
#import "ZHDatePickerView.h"
#import "ToolsHelper.h"
#import "CBConnect.h"
#import "PleaseNameTableViewCell.h"
#import "TradeMarkCategoryModel.h"
#import "UserHelper.h"
#import "CNPPopupController.h"
#import "CategoryPopView.h"
//#import "listDictiionaryItemsModel.h"
#import "DashiPackageModel.h"
#import "PleaseNameFooterView.h"
#import "ClassificationVC.h"
#import "WXApi.h"
#import <AlipaySDK/AlipaySDK.h>

#import "NavigationView.h"
#import "ServiceVC.h"
#import "CompanyTypeModel.h"

@interface PleaseNameVC ()<UITableViewDelegate,UITableViewDataSource,LCActionSheetDelegate,ZHDatePickerViewDelegate,PleaseNameFooterViewDelegate>
{
    NSString *title; //标题
    NSString *bossName;//老板名字
    NSString *titleNum;//字数
    NSString *showDate;//出生日期
    double birthStmp; //生日时间戳
    NSString *priceStr; //金额
}
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) ZHDatePickerView *pickerView;
@property (nonatomic, strong) CNPPopupController *popupController;
@property (nonatomic, strong) CategoryPopView *catePopView;

@property (nonatomic, strong) CategoryPopView *companyPopView;

@property (nonatomic, strong) UIView *taoCanHeaderView;

@property (nonatomic, strong) CategoryPopView *timePopView;

@property (nonatomic, strong) NSString *row1MoreHieght; //row 1 行高

@property (nonatomic, assign) int namedCategory;//起名分类 取值如下：1-商标起名 2-公司起名
@property (nonatomic, strong) NSMutableArray *brandCateArray; //商标起名名称
@property (nonatomic, strong) NSMutableArray *brandCateIDArray; //id
@property (nonatomic, assign) int brandSelectRow; //选中行

@property (nonatomic, strong) NSMutableArray *companyCateArray; //公司起名名称
@property (nonatomic, strong) NSMutableArray *companyCateIDArray; //id
@property (nonatomic, assign) int companySelectRow; //选中行

@property (nonatomic, strong) NSString *birthHour;//出生时间点
@property (nonatomic, strong) NSString *requireDetail;//详情要求描述

@property (nonatomic, assign) int payMode; //付款方式，取值如下：1-支付宝   2-微信

@property (nonatomic, strong) NSMutableArray *dashiPackArray;

@property (nonatomic, assign) int selectPack;//选中套餐

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation PleaseNameVC
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (NSMutableArray *)brandCateArray
{
    if (!_brandCateArray){
        _brandCateArray = [[NSMutableArray alloc] init];
    }
    return _brandCateArray;
}

- (NSMutableArray *)cateIDArray
{
    if (!_brandCateIDArray){
        _brandCateIDArray = [[NSMutableArray alloc] init];
    }
    return _brandCateIDArray;
}

- (NSMutableArray *)companyCateArray
{
    if (!_companyCateArray){
        _companyCateArray = [NSMutableArray array];
    }
    return _companyCateArray;
}

- (NSMutableArray *)companyCateIDArray
{
    if (!_companyCateIDArray){
        _companyCateIDArray = [[NSMutableArray alloc] init];
    }
    return _companyCateIDArray;
}

- (NSMutableArray *)dashiPackArray
{
    if (!_dashiPackArray){
        _dashiPackArray = [NSMutableArray array];
    }
    return _dashiPackArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationItem.title = @"请他起名";
    self.namedCategory = 1;//默认商标起名
    self.payMode = 2; //支付方式默认微信
    self.selectPack = -1 ; //默认套餐没有选中
    self.brandSelectRow = -1; //行业默认没有选中
    self.companySelectRow = -1; //公司起名默认没有选择
    NSString *specialStr = self.modelMember.memberExtend.teDian;
    NSArray *array = [specialStr componentsSeparatedByString:@"#"];
    if (array.count > 0){
        self.row1MoreHieght = [ToolsHelper tagHeightWithArray:array andWidht:ScreenWidth - 100*UIRate andCornerScale:0.2];
        DLog(@"row1MoreHieght:%@",_row1MoreHieght);
    }else {
        self.row1MoreHieght = @"0";
    }
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarBtnAction)];
    
    //支付成功通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationPaySuccess) name:NotificationAliPayResultSuccess object:nil];
    
   [self drawView];
    
   [self requestMasterProduct];

   [self requestPayNotifyUrl];
    
   [self requestCateListTree];
    
}

- (void)dealloc{
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.isDealNav){
         self.navigationController.navigationBar.hidden = YES;
    }
}

-(void)drawView{
    
    __weak typeof (self) weakSelf = self;
    if (self.isDealNav){
        //处理Nav
        NavigationView *nav = [[NavigationView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64) andTitle:@"请他起名" block:^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }];
        [self.view addSubview:nav];
    }
    
    PleaseNameFooterView *footerView = [[PleaseNameFooterView alloc] initWithFrame:CGRectZero];
    footerView.delegate = self;
    footerView.block = ^(int tag){
        weakSelf.payMode = tag;
    };
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableFooterView = footerView;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    tableView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,64)
    .bottomSpaceToView(self.view,0);
    
    footerView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .heightIs(180*UIRate)
    .bottomSpaceToView(self.view,0);


    UIButton *serviceBtn = [[UIButton alloc]initWithFrame:CGRectZero];
    [serviceBtn addTarget:self action:@selector(serviceBtn) forControlEvents:UIControlEventTouchUpInside];
    [serviceBtn setImage:[UIImage imageNamed:@"home_kefu"] forState:UIControlStateNormal];
    [self.view addSubview:serviceBtn];
    
    serviceBtn.sd_layout
    .rightSpaceToView(self.view,0)
    .bottomSpaceToView(self.view,85*UIRate)
    .widthIs(80*UIRate)
    .heightIs(80*UIRate);

}

//套餐头部
- (UIView *)taoCanHeaderView
{
    if (!_taoCanHeaderView){
        
        _taoCanHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 50*UIRate)];
        _taoCanHeaderView.backgroundColor = [UIColor whiteColor];
        
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(15*UIRate, 0, ScreenWidth, 50*UIRate)];
        textLabel.font = SYSTEM_FONT_(15*UIRate);
        textLabel.text = @"套餐选择";
        textLabel.textColor = COLOR_Black;
        [_taoCanHeaderView addSubview:textLabel];
    }
    return _taoCanHeaderView;
}

//行业分类
- (CategoryPopView *)catePopView
{
    if (!_catePopView){
        
        _catePopView = [[CategoryPopView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 240*UIRate) andArray:self.brandCateArray];
        __weak typeof (self) weakSelf = self;
        _catePopView.block = ^(int row){ // -1为取消
            if (row >= 0){
                weakSelf.brandSelectRow = row;
                NSArray *position = @[[NSIndexPath indexPathForRow:0 inSection:3]];
                [weakSelf.tableView reloadRowsAtIndexPaths:position withRowAnimation:UITableViewRowAnimationNone];
            }
             [weakSelf.popupController dismissPopupControllerAnimated:YES];
           
        };
    }
    return _catePopView;
}

///公司行业分类
- (CategoryPopView *)companyPopView
{
    if (!_companyPopView){
        _companyPopView = [[CategoryPopView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 240*UIRate) andArray:self.companyCateArray];
        __weak typeof (self) weakSelf = self;
        _companyPopView.block = ^(int row){ // -1为取消
            if (row >= 0){
                weakSelf.companySelectRow = row;
                NSArray *position = @[[NSIndexPath indexPathForRow:0 inSection:3]];
                [weakSelf.tableView reloadRowsAtIndexPaths:position withRowAnimation:UITableViewRowAnimationNone];
            }
            [weakSelf.popupController dismissPopupControllerAnimated:YES];
            
        };

    }
    return _companyPopView;
}


//生日时间选择器
- (ZHDatePickerView *)pickerView
{
    if (!_pickerView){
        _pickerView = [[ZHDatePickerView alloc] initDatePickerWithDefaultDate:[NSDate dateWithTimeIntervalInMilliSecondSince1970:0] andDatePickerMode:UIDatePickerModeDate];
        _pickerView.delegate = self;
    }
    return _pickerView;
}

//出生时间点
- (CategoryPopView *)timePopView
{
    if (!_timePopView){
        
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (int i = 0 ; i < 24 ; i ++ ){
            [array addObject:[NSString stringWithFormat:@"%d",i]];
        }
        
        _timePopView = [[CategoryPopView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 240*UIRate) andArray:array];
        __weak typeof (self) weakSelf = self;
        _timePopView.block = ^(int row){ // -1为取消
            if (row >= 0){
                weakSelf.birthHour = [NSString stringWithFormat:@"%d",row];
                NSArray *position = @[[NSIndexPath indexPathForRow:0 inSection:7]];
                [weakSelf.tableView reloadRowsAtIndexPaths:position withRowAnimation:UITableViewRowAnimationNone];
            }
            [weakSelf.popupController dismissPopupControllerAnimated:YES];
        };
    }
    return _timePopView;
}


#pragma mark - ======== <UITableViewDelegate,UITableViewDataSource> =========
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
    {
        if (self.dashiPackArray.count > 0){
            return 10;
        }
        return 9;
    }
    
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
    {
        if (section == 9)
        {
            return self.dashiPackArray.count;
        }
        return 1;
    }
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
    {
        if (indexPath.section == 0) {
            masterDetailsCell_8 *cell = [masterDetailsCell_8 cellWithTableView:tableView];
            cell.model = self.modelMember;
            return cell;
        }
        
        if (indexPath.section == 1) {
            ReleaseVCell_1 *cell = [ReleaseVCell_1 cellWithTableView:tableView];
            cell.rademarkBtn.selected =  (self.namedCategory == 1) ? YES : NO;
            cell.companyBtn.selected = !cell.rademarkBtn.selected;
            cell.block0 = ^{
                self.namedCategory = 1;
                [self.tableView reloadData];
            };
            cell.block1 = ^{
                self.namedCategory = 2;
                [self.tableView reloadData];
            };
            return cell;
        }
        if (indexPath.section == 2 || indexPath.section == 4 || indexPath.section == 5 || indexPath.section == 6 || indexPath.section == 7) {
            PleaseNameTableViewCell *cell = [PleaseNameTableViewCell cellWithTableView:tableView];
            cell.selectedButton.hidden = YES;
            cell.mTextField.hidden = NO;
            switch (indexPath.section) {
                case 2:
                    cell.titleLabel.text = @"标题";
                    cell.mTextField.placeholder = @"不超过20个字";
                    cell.mTextField.tag = 10000;
                    cell.mTextField.text = title;
                    [cell.mTextField addTarget:self action:@selector(textFieldAction:) forControlEvents:UIControlEventEditingChanged];
                    cell.mTextField.keyboardType = UIKeyboardTypeDefault;
                    break;
                case 4:
                    cell.titleLabel.text = @"老板名字";
                    cell.mTextField.placeholder = @"请输入老板名字";
                    cell.mTextField.tag = 10001;
                    cell.mTextField.text = bossName;
                    [cell.mTextField addTarget:self action:@selector(textFieldAction:) forControlEvents:UIControlEventEditingChanged];
                    cell.mTextField.keyboardType = UIKeyboardTypeDefault;
                    break;
                    
                case 5:
                    cell.titleLabel.text = @"字数";
                    cell.mTextField.placeholder = @"请输入理想字数";
                    cell.mTextField.tag = 10002;
                    cell.mTextField.text = titleNum;
                    [cell.mTextField addTarget:self action:@selector(textFieldAction:) forControlEvents:UIControlEventEditingChanged];
                    break;
                    
                case 6:
                    cell.titleLabel.text = @"生日";
                    [cell reloadButtonFrame:cell.selectedButton withTitle:showDate ? showDate : @"请选择" ];
                    cell.mTextField.hidden = YES;
                    cell.selectedButton.hidden = NO;
                    cell.selectedButton.tag = 20000;
                    [cell.selectedButton addTarget:self action:@selector(selectedButtonAction:) forControlEvents:UIControlEventTouchUpInside];
                    
                    break;
                    
                case 7:
                {
                    cell.titleLabel.text = @"出生时刻";
                    cell.mTextField.hidden = YES;
                    NSString *str = [NSString stringWithFormat:@"%@点",self.birthHour];
                    [cell reloadButtonFrame:cell.selectedButton withTitle: self.birthHour ? str : @"请选择"];
                    cell.selectedButton.hidden = NO;
                    cell.selectedButton.tag = 20001;
                    [cell.selectedButton addTarget:self action:@selector(selectedButtonAction:) forControlEvents:UIControlEventTouchUpInside];
                }
                    break;
                default:
                    break;
            }
            
            return cell;
        }
        if (indexPath.section == 3) {
            if (self.namedCategory == 1) {
                ReleaseVCell_3 *cell =  [ReleaseVCell_3 cellWithTableView:tableView];
                NSString *brandName = (self.brandCateArray.count > 0 && self.brandSelectRow >= 0) ? self.brandCateArray[self.brandSelectRow] : @"请选择";
                [cell reloadButtonFrame:cell.chooseBtn withTitle:brandName];
                __weak typeof (self) weakSelf = self;
                cell.block1 = ^(UIButton *btn){
                    [self.view endEditing:YES];
                    if (weakSelf.brandCateArray.count > 0){
                        [weakSelf showBrandSheet];
                    }
                };

                cell.block0 = ^(UIButton *btn){
                    [self.view endEditing:YES];
                
                    //分类查询
                    ClassificationVC *vc = [[ClassificationVC alloc]init];
                    vc.dataArray = self.dataArray;
                    vc.isDealNav = self.isDealNav;
                    [self.navigationController pushViewController:vc animated:YES];
                };
                
                return cell;
                
            }else{
                ReleaseVCell_4 *cell =  [ReleaseVCell_4 cellWithTableView:tableView];
                 NSString *companyName = (self.companyCateArray.count > 0 && self.companySelectRow >= 0) ? self.companyCateArray[self.companySelectRow] : @"请选择";
                 [cell reloadButtonFrame:cell.chooseBtn withTitle:companyName];
                __weak typeof (self) weakSelf = self;
                cell.block0 = ^(UIButton *btn){
                    [self.view endEditing:YES];
                    if (weakSelf.companyCateArray.count > 0){
                        [weakSelf showCompanySheet];
                    }else {
                        [weakSelf requestCompanyName];
                    }
                };
                return cell;
            }
        }

        if (indexPath.section == 8) {//描述
            ReleaseVCell_5 *cell = [ReleaseVCell_5 cellWithTableView:tableView];
            __weak typeof (self) weakSelf = self;
            cell.didHaveAttr1 = ^(NSString *str){
                weakSelf.requireDetail = str;
            };
            return cell;
        }
        if (indexPath.section == 9) {//大师套餐
            PleaseNameCell_6 *cell = [PleaseNameCell_6 cellWithTableView:tableView];
            
            if (indexPath.row == self.selectPack){
                cell.selectBtn.selected = YES;
            }else {
                cell.selectBtn.selected = NO;
            }
            
            cell.model = self.dashiPackArray[indexPath.row];
            
            return cell;
        }
                
        return [UITableViewCell new];
    }
    
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
    {
        if (indexPath.section == 0) {
            
            if ([self.row1MoreHieght isEqualToString:@"0"]){
                return 90*UIRate;
            }else {
                return 45*UIRate + self.row1MoreHieght.doubleValue;
            }
        }
        if (indexPath.section == 8) {
            return 150*UIRate;
        }
        if (indexPath.section == 9){
            return 120*UIRate;
        }
        
        return 45*UIRate;
    }

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 9){
    
        self.selectPack = (int)indexPath.row;
        NSIndexSet *position = [[NSIndexSet alloc] initWithIndex:indexPath.section]; //刷新第9个section
        [self.tableView reloadSections:position withRowAnimation:UITableViewRowAnimationNone];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 9){
        return 50*UIRate;
    }
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 9){
        return self.taoCanHeaderView;
    }
    return [[UIView alloc] init];
}

#pragma mark - Action

- (void)textFieldAction:(UITextField *)textField{
    
    switch (textField.tag) {
        case 10000://标题
            if (textField.text.length > 20){
                title = [textField.text substringToIndex:20];
            }else {
                title = textField.text;
            }
            break;
        case 10001://老板名字
            bossName = textField.text;
            break;
        case 10002://字数
            titleNum = textField.text;
            break;
        default:
            break;
    }
}

- (void)selectedButtonAction:(UIButton *)button{
    [self.view endEditing:YES];
    switch (button.tag) {
        case 20000:
            [self.pickerView show];
            break;
        case 20001:
        {
            self.popupController = [[CNPPopupController alloc] initWithContents:@[self.timePopView]];
            self.popupController.theme.popupStyle = CNPPopupStyleActionSheet;
            self.popupController.theme.cornerRadius = 0;
            [self.popupController presentPopupControllerAnimated:YES];
        }
            break;
        default:
            break;
    }
}

#pragma mark - ZHDatePickerViewDelegate
- (void)pickerView:(ZHDatePickerView *)pickerView didSelectDate:(NSDate *)date
{
    birthStmp = [date timeIntervalSince1970];
    showDate = [NSDate dateStringWithTimeDate:date dateFormat:@"yyyy年MM月dd日"];
    NSArray *position = @[[NSIndexPath indexPathForRow:0 inSection:6]];
    [self.tableView reloadRowsAtIndexPaths:position withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - PleaseNameFooterViewDelegate 提交按钮代理
- (void)commitBtnClick{
    [self commitAction];
}

#pragma mark 支付成功通知
- (void)notificationPaySuccess{
    [self.navigationController popViewControllerAnimated:YES];
}

//右侧按钮提交
- (void)rightBarBtnAction{
    
    [self commitAction];
}

//客服
-(void)serviceBtn{
    ServiceVC *vc = [[ServiceVC alloc]init];
    vc.isDealNav = self.isDealNav;
    [self.navigationController pushViewController:vc animated:YES];
}

//商标分类弹出窗
- (void)showBrandSheet{

    self.popupController = [[CNPPopupController alloc] initWithContents:@[self.catePopView]];
    self.popupController.theme.popupStyle = CNPPopupStyleActionSheet;
    self.popupController.theme.cornerRadius = 0;
    [self.popupController presentPopupControllerAnimated:YES];
}

//公司行业分类弹出窗
- (void)showCompanySheet{
    
    self.popupController = [[CNPPopupController alloc] initWithContents:@[self.companyPopView]];
    self.popupController.theme.popupStyle = CNPPopupStyleActionSheet;
    self.popupController.theme.cornerRadius = 0;
    [self.popupController presentPopupControllerAnimated:YES];
}

#pragma mark ========网络请求，请求行业=========

//商标起名行业列表
- (void)requestCateListTree{
    
     NSMutableDictionary *params = [CBConnect getBaseRequestParams];
    [CBConnect getHomeListCateTree:params success:^(id responseObject) {

        [self.brandCateArray removeAllObjects];
        [self.brandCateIDArray removeAllObjects];
        [self.dataArray removeAllObjects];
        
        NSArray *array = [TradeMarkCategoryModel mj_objectArrayWithKeyValuesArray:responseObject];
        for (TradeMarkCategoryModel *model in array){
            [self.brandCateArray addObject:model.category_name];
            [self.brandCateIDArray addObject:model.sid];
        }
        [self.dataArray addObjectsFromArray:array];
       
        
    } successBackfailError:^(id responseObject) {

    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}

//行业分类
- (void)requestCompanyName{
    
    [LCProgressHUD showLoading:@"加载中..."];
    
    NSMutableDictionary *params3 = [[NSMutableDictionary alloc]init];
    [CBConnect getHomeTrademarkCompanyType:params3 success:^(id responseObject) {
        
         NSArray *array = [CompanyTypeModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
        
        [self.companyCateIDArray removeAllObjects];
        [self.companyCateArray removeAllObjects];
        
        for (CompanyTypeModel *model in array){
            [self.companyCateIDArray addObject:model.sid];
            [self.companyCateArray addObject:model.name];
        }

        [self showCompanySheet];
        
    } successBackfailError:^(id responseObject) {
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}

//请求大师套餐
- (void)requestMasterProduct{
    
    [LCProgressHUD showLoading:@"加载中..."];
    
    NSMutableDictionary *params = [CBConnect getBaseRequestParams];
    [CBConnect getHomeListDashiPackages:params success:^(id responseObject) {
        
        NSArray *array = [DashiPackageModel mj_objectArrayWithKeyValuesArray:responseObject];
        
        [self.dashiPackArray addObjectsFromArray:array];
        
        [self.tableView reloadData];
        
    } successBackfailError:^(id responseObject) {
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}


#pragma mark - ============提交网络请求=============
//提交
-(void)commitAction{
  
    if (!title.length){
        [LCProgressHUD showFailure:@"请输入标题"];
        return;
    }
    if (!bossName.length){
        [LCProgressHUD showFailure:@"请输入老板名字"];
        return;
    }
    if (!titleNum.length){
        [LCProgressHUD showFailure:@"请输入字数"];
        return;
    }
    if (!showDate.length){
        [LCProgressHUD showFailure:@"请选择生日"];
        return;
    }
    if (!self.birthHour.length){
        [LCProgressHUD showFailure:@"请选择出生时刻"];
        return;
    }
    if (!self.requireDetail.length){
        [LCProgressHUD showFailure:@"请填写描述"];
        return;
    }

    
    
    NSMutableDictionary *params = [CBConnect getBaseRequestParams];
    [params setValue:@(2) forKey:@"taskMode"];//任务所属模块：1-悬赏起名 2-大师起名
    [params setValue:@(self.modelMember.memberExtend.memberId) forKey:@"dashiMemberId"];//大师会员标识
    [params setValue:@(self.namedCategory) forKey:@"namedCategory"];//起名分类，取值如下：1-商标起名 2-公司起名
    [params setValue:title forKey:@"taskTitle"]; //任务标题
    
    if (self.namedCategory == 1){
        
        if (self.brandSelectRow < 0){
            [LCProgressHUD showMessage:@"请选择行业分类"];
            return;
        }
        [params setValue:self.brandCateIDArray[self.brandSelectRow] forKey:@"categoryId"];//所属行业分类标识
        [params setValue:self.brandCateArray[self.brandSelectRow] forKey:@"categoryName"];//所属行业分类名称
    }else {
        
        if (self.companySelectRow < 0){
            [LCProgressHUD showMessage:@"请选择行业分类"];
            return;
        }
        [params setValue:self.companyCateIDArray[self.companySelectRow] forKey:@"categoryId"];//所属行业分类标识
        [params setValue:self.companyCateArray[self.companySelectRow] forKey:@"categoryName"];//所属行业分类名称
    }
    
    [params setValue:self.requireDetail forKey:@"requireDetail"];//详细要求描述
    
    if (self.dashiPackArray.count > 0){
        if (self.selectPack < 0){
            [LCProgressHUD showMessage:@"请选择大师套餐"];
            return;
        }else {
            DashiPackageModel *model = self.dashiPackArray[self.selectPack];
            priceStr = [NSString stringWithFormat:@"%.2f",model.priceYuan];
            [params setValue:@(model.price) forKey:@"price"]; //大师套餐金额
        }
    }
    //获取本机IP
    NSString *addressStr = [ToolsHelper getIPAddress];
    
    [params setValue:bossName forKey:@"bossName"];//老板名字
    [params setValue:titleNum forKey:@"wordsNum"];//起名字数 2个字或3个字
    
    [params setValue:@(birthStmp) forKey:@"birthday"];//生日时戳(距离1970年的秒数)
    [params setValue:self.birthHour forKey:@"birthhour"];//出生时刻
    if (self.payMode == 1) {
       [params setValue:@(self.payMode) forKey:@"payMode"]; //付款方式，取值如下：1-支付宝   2-微信
    }else{
        [params setValue:@(self.payMode) forKey:@"payMode"]; //付款方式，取值如下：1-支付宝   2-微信
         [params setValue:addressStr forKey:@"clientIp"];
    }
    
    [LCProgressHUD showLoading:@"支付请求中"];
    [CBConnect getHomeAddTask:params success:^(id responseObject) {
        
        if (self.payMode == 1){ //支付宝
            //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
            NSString *appScheme = ALIPAY_APP_URLSCHEME;
            [[AlipaySDK defaultService]payOrder:responseObject fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                
            }];
        }else if (self.payMode == 2) { //微信
            PayReq *request = [[PayReq alloc]init];
            request.partnerId = responseObject[@"partnerid"];//商户号
            request.prepayId = responseObject[@"prepayid"];//预支付交易会话ID
            request.nonceStr = responseObject[@"noncestr"];//随机字符串
            NSMutableString *timeStr = responseObject[@"timestamp"];
            request.timeStamp = timeStr.intValue;//时间戳
            request.package = @"Sign=WXPay";//扩展字段
            request.sign = responseObject[@"sign"];//签名
            [WXApi sendReq:request];
        }
        [self.navigationController popViewControllerAnimated:YES];
    } successBackfailError:^(id responseObject) {
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}

#pragma mark - 请求支付回调地址
- (void)requestPayNotifyUrl{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setValue:@"dg_task_alipay_notify_url" forKey:@"groupCode"];
    [CBConnect getVersionlistDictiionaryItems:params success:^(id responseObject) {
        
    } successBackfailError:^(id responseObject) {
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}
@end
