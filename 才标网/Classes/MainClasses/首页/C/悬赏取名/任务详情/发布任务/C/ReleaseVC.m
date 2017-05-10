//
//  ReleaseVC.m
//  才标网
//
//  Created by baichun on 17/3/14.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "ReleaseVC.h"
#import "ReleaseVCell_1.h"
#import "ReleaseVCell_2.h"
#import "ReleaseVCell_3.h"
#import "ReleaseVCell_4.h"
#import "ReleaseVCell_5.h"
#import "ReleaseVCell_6.h"
#import "ReleaseVCell_7.h"
#import "ReleaseVCell_8.h"
#import "CBConnect.h"
#import "listDictiionaryItemsModel.h"
#import "ToolsHelper.h"
#import "ReleaseCell__1.h"
#import "CNPPopupController.h"
#import "CategoryPopView.h"
#import "TradeMarkCategoryModel.h"
#import "ClassificationVC.h"
#import "ServiceVC.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"
#import "CompanyTypeModel.h"

@interface ReleaseVC ()<UITableViewDelegate,UITableViewDataSource,LCActionSheetDelegate,TTGroupTagViewDelegate>
    
    {
        NSString *state;
        NSString *groupCode;
        NSString *taskTitle;
        NSString *requireDetail;
        NSString *expireDays;
        NSString *price;
        NSString *btnTitle;
        int payMode;
    }
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) LCActionSheet *bottomView;
@property(nonatomic,strong) NSMutableArray *dataArray;
@property(nonatomic,strong) NSString *showStr;
@property(nonatomic,strong) NSMutableArray *timeArray;
@property(nonatomic,strong) NSMutableArray *timeArray1;

@property(nonatomic,strong) NSMutableArray *princeArray;
@property(nonatomic,strong) NSMutableArray *princeArray1;


@property(nonatomic,strong) NSMutableArray *classificationArray;
@property(nonatomic,strong) NSMutableArray *selectTagArray;


@property (nonatomic, strong) CNPPopupController *popupController;
@property (nonatomic, strong) CategoryPopView *catePopView;
@property (nonatomic, strong) CategoryPopView *companyPopView;
@property (nonatomic, strong) NSMutableArray *cateArray;
@property (nonatomic, strong) NSMutableArray *cateIDArray;

@property (nonatomic, assign)int namedCategory;//起名分类
@property (nonatomic, strong)NSString *categoryId;//行业分类标识
@property (nonatomic, strong)NSString *categoryName;//行业分类名称
//公司
@property(nonatomic,strong) NSMutableArray *industryArray;
@property(nonatomic,strong) NSMutableArray *idArray;
@property(nonatomic, strong) NSString *companyId;
@property(nonatomic, strong) NSString *companyName;

//@property (nonatomic, strong)NSString *piceYuan;
//@property (nonatomic, strong)NSString *time;

@end

@implementation ReleaseVC
-(NSMutableArray *)classificationArray{
    if (!_classificationArray) {
        _classificationArray = [NSMutableArray array];
    }
    return _classificationArray;
}
- (NSMutableArray *)cateArray
{
    if (!_cateArray){
        _cateArray = [[NSMutableArray alloc] init];
    }
    return _cateArray;
}

- (NSMutableArray *)cateIDArray
{
    if (!_cateIDArray){
        _cateIDArray = [[NSMutableArray alloc] init];
    }
    return _cateIDArray;
}

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
-(NSMutableArray *)princeArray{
    
    if (!_princeArray) {
        _princeArray = [NSMutableArray array];
    }
    return _princeArray;
}
-(NSMutableArray *)princeArray1{
    
    if (!_princeArray1) {
        _princeArray1 = [NSMutableArray array];
    }
    return _princeArray1;
}
-(NSMutableArray *)timeArray{
    if (!_timeArray) {
        _timeArray = [NSMutableArray array];
    }
    return _timeArray;
}
-(NSMutableArray *)timeArray1{
    if (!_timeArray1) {
        _timeArray1 = [NSMutableArray array];
    }
    return _timeArray1;
}
-(NSMutableArray *)dataArray{
    
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSMutableArray *)selectTagArray
{
    if (!_selectTagArray){
        _selectTagArray = [NSMutableArray array];
        
    }
    return _selectTagArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"发布任务";
    
    //支付成功通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paySuccess) name:NotificationWexinPayResultSuccess object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paySuccess) name:NotificationAliPayResultSuccess object:nil];
    
    state = @"1";
    
    groupCode = @"dg_task_tag";
    [self drawView];
    [self requestData];
    [self requestCateListTree];

}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"移除了通知");
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

    
    UIButton *serviceBtn = [[UIButton alloc]initWithFrame:CGRectZero];
    [serviceBtn addTarget:self action:@selector(serviceBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [serviceBtn setImage:[UIImage imageNamed:@"home_kefu"] forState:UIControlStateNormal];
    [self.view addSubview:serviceBtn];
    
    serviceBtn.sd_layout
    .rightSpaceToView(self.view,15)
    .bottomSpaceToView(self.view,85)
    .widthIs(50*UIRate)
    .heightIs(50*UIRate);
}

- (CategoryPopView *)catePopView
{
    if (!_catePopView){
        
        _catePopView = [[CategoryPopView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 240*UIRate) andArray:self.cateArray];
        __weak typeof (self) weakSelf = self;
        _catePopView.block = ^(int row){ // -1为取消
            if (row >= 0){
                weakSelf.categoryName = weakSelf.cateArray[row];
                weakSelf.categoryId = weakSelf.cateIDArray[row];
                NSArray *position = @[[NSIndexPath indexPathForRow:0 inSection:2]];
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
        _companyPopView = [[CategoryPopView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 240*UIRate) andArray:self.industryArray];
        __weak typeof (self) weakSelf = self;
        _companyPopView.block = ^(int row){ // -1为取消
            if (row >= 0){
                weakSelf.companyName = weakSelf.industryArray[row];
                weakSelf.companyId = weakSelf.idArray[row];
                NSArray *position = @[[NSIndexPath indexPathForRow:0 inSection:2]];
                [weakSelf.tableView reloadRowsAtIndexPaths:position withRowAnimation:UITableViewRowAnimationNone];
            }
            [weakSelf.popupController dismissPopupControllerAnimated:YES];
            
        };
        
    }
    return _companyPopView;
}


#pragma mark - ======== 点击事件 ========
-(void)serviceBtnAction{
    ServiceVC *vc = [[ServiceVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - ======== <UITableViewDelegate,UITableViewDataSource> =========
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 7;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
       ReleaseCell__1 *cell =  [ReleaseCell__1 cellWithTableView:tableView];
        if ([state isEqualToString:@"1"]) {
            [cell.rademarkBtn setImage:[UIImage imageNamed:@"btn_weichaxun_n-1"] forState:UIControlStateNormal];
            [cell.companyBtn setImage:[UIImage imageNamed:@"btn_weichaxun_n"] forState:UIControlStateNormal];
        }else{
            [cell.rademarkBtn setImage:[UIImage imageNamed:@"btn_weichaxun_n"] forState:UIControlStateNormal];
            [cell.companyBtn setImage:[UIImage imageNamed:@"btn_weichaxun_n-1"] forState:UIControlStateNormal];
        }
        
        __weak typeof (self) weakSelf = self;
        cell.block0 = ^(UIButton *btn){
          
            state = @"1";
            [weakSelf.tableView reloadData];
        };
        cell.block1 = ^(UIButton *btn){
            
            state = @"2";
            [weakSelf.tableView reloadData];
        };
        return cell;
    }
    if (indexPath.section == 1) {
        ReleaseVCell_2 *cell =  [ReleaseVCell_2 cellWithTableView:tableView];
              return cell;
    }
    if (indexPath.section == 2) {
        
        if ([state isEqualToString:@"1"]) {
            ReleaseVCell_3 *cell =  [ReleaseVCell_3 cellWithTableView:tableView];
             [cell reloadButtonFrame:cell.chooseBtn withTitle:self.categoryName ? self.categoryName : @"请选择"];
            __weak typeof (self) weakSelf = self;
            btnTitle = cell.chooseBtn.titleLabel.text;
            cell.block1 = ^(UIButton *btn){
                [weakSelf.view endEditing:YES];
                weakSelf.popupController = [[CNPPopupController alloc] initWithContents:@[weakSelf.catePopView]];
                weakSelf.popupController.theme.popupStyle = CNPPopupStyleActionSheet;
                [weakSelf.popupController presentPopupControllerAnimated:YES];
            };
            cell.block0 = ^(UIButton *btn){
                [weakSelf.view endEditing:YES];
                //分类查询
                ClassificationVC *vc = [[ClassificationVC alloc]init];
                vc.dataArray = weakSelf.classificationArray;
                [weakSelf.navigationController pushViewController:vc animated:YES];
            };
            
            return cell;

        }else{
            ReleaseVCell_4 *cell =  [ReleaseVCell_4 cellWithTableView:tableView];
            [cell reloadButtonFrame:cell.chooseBtn withTitle:self.companyName ?: @"请选择"];
            btnTitle = cell.chooseBtn.titleLabel.text;
            __weak typeof (self) weakSelf = self;
            cell.block0 = ^(UIButton *btn){
                [weakSelf.view endEditing:YES];
                
                if (weakSelf.industryArray.count > 0){
                    [weakSelf showCompanySheet];
                }else {
                    [weakSelf requestCompanyList];
                }
                
//                weakSelf.bottomView = [[LCActionSheet alloc]initWithTitle:nil buttonTitles:weakSelf.industryArray redButtonIndex:-1 delegate:weakSelf];
//                [_bottomView show];
//                UIButton *myButton = (UIButton *)[weakSelf.view viewWithTag:1024];
//                btnTitle = myButton.titleLabel.text;
//                _bottomView.didClickedButtonAtIndex = ^(NSInteger buttonIndex,NSString *title){
//                    [myButton setTitle:title forState:UIControlStateNormal];
//                    [myButton setImage:[UIImage imageNamed:@"icon_xiala2"] forState:UIControlStateNormal];
//                    [myButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:5];
//                    categoryI = weakSelf.idArray[buttonIndex];
//                    categoryNam = title;
//                    btnTitle = myButton.titleLabel.text;
//
//                };
            };
        return cell;
        }
    }
    
    if (indexPath.section == 3) {
        ReleaseVCell_6 *cell =  [ReleaseVCell_6 cellWithTableView:tableView];
        cell.popview.delegate = self;
        [cell setDataArr:self.dataArray];
        return cell;
    }

    if (indexPath.section == 5) {
        ReleaseVCell_7 *cell =  [ReleaseVCell_7 cellWithTableView:tableView];
      __weak typeof (self) weakSelf = self;
        cell.block0 = ^(UIButton *btn){
          [weakSelf.view endEditing:YES];
            weakSelf.bottomView = [[LCActionSheet alloc]initWithTitle:nil buttonTitles:weakSelf.timeArray redButtonIndex:-1 delegate:weakSelf];
            [_bottomView show];
            UIButton *myButton = (UIButton *)[weakSelf.view viewWithTag:1025];

            _bottomView.didClickedButtonAtIndex = ^(NSInteger buttonIndex,NSString *title){
                
                [myButton setTitle:title forState:UIControlStateNormal];

                [myButton setImage:[UIImage imageNamed:@"icon_xiala2"] forState:UIControlStateNormal];
                [myButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:5];
                expireDays = weakSelf.timeArray1[buttonIndex];

            };

        };
        
        cell.block1 = ^(UIButton *btn){
            [weakSelf.view endEditing:YES];
            weakSelf.bottomView = [[LCActionSheet alloc]initWithTitle:nil buttonTitles:weakSelf.princeArray redButtonIndex:-1 delegate:weakSelf];
            [_bottomView show];
            UIButton *myButton = (UIButton *)[weakSelf.view viewWithTag:1026];
            
            _bottomView.didClickedButtonAtIndex = ^(NSInteger buttonIndex,NSString *title){
                [myButton setTitle:title forState:UIControlStateNormal];
                [myButton setImage:[UIImage imageNamed:@"icon_xiala2"] forState:UIControlStateNormal];
                [myButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:5];
                
                price = weakSelf.princeArray1[buttonIndex];
            };

        };

        return cell;
    }
    if (indexPath.section == 6) {
        ReleaseVCell_8 *cell =  [ReleaseVCell_8 cellWithTableView:tableView];
        UIButton *myButton = (UIButton *)[self.view viewWithTag:1028];
        [myButton addTarget:self action:@selector(release:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }

    ReleaseVCell_5 *cell =  [ReleaseVCell_5 cellWithTableView:tableView];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 4) {
        return 80*UIRate;
    }
    if (indexPath.section == 5) {
        return 230*UIRate;
    }
    if (indexPath.section == 6) {
        return 125*UIRate;
    }
    if (indexPath.section == 3) {
        return (self.showStr.doubleValue+25*UIRate);
    }
    return 40*UIRate;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}


- (void)buttonClick:(NSString *)string and:(BOOL)isDelete{

    bool __block isAdd = YES;
    
    for (NSString *str in self.selectTagArray){
        if ([string isEqualToString:str]){
            isAdd = NO;
            break;
        }else {
            isAdd = YES;
        }
    }
        if (isAdd) {
             [self.selectTagArray addObject:string];
        }else {
            [self.selectTagArray removeObject:string];
        }
    
    DLog(@"===数组%@===",self.selectTagArray);

}

//公司行业分类弹出窗
- (void)showCompanySheet{
    
    self.popupController = [[CNPPopupController alloc] initWithContents:@[self.companyPopView]];
    self.popupController.theme.popupStyle = CNPPopupStyleActionSheet;
    self.popupController.theme.cornerRadius = 0;
    [self.popupController presentPopupControllerAnimated:YES];
}


#pragma mark - ============网络－我要发布===============
- (void)requestData {
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    
    [params setObject:groupCode forKey:@"groupCode"];
    
    [CBConnect getVersionlistDictiionaryItems:params success:^(id responseObject) {
        listDictiionaryItemsModel *model = [[listDictiionaryItemsModel alloc]init];
        for (NSDictionary *dic in responseObject) {
            model.itemContent = dic[@"itemContent"];
            model.categoryId = dic[@"id"];
            [self.dataArray addObject:model.itemContent];

        }
        self.showStr = [self tagHeightWithArray: self.dataArray];
        [self.tableView reloadData];
    } successBackfailError:^(id responseObject) {
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
    
    NSMutableDictionary *params1 = [[NSMutableDictionary alloc]init];
    [params1 setObject:@"dg_task_days" forKey:@"groupCode"];
    [CBConnect getVersionlistDictiionaryItems:params1 success:^(id responseObject) {
    listDictiionaryItemsModel *model = [[listDictiionaryItemsModel alloc]init];
    for (NSDictionary *dic in responseObject) {
        model.itemContent = dic[@"itemContent"];
        [self.timeArray1 addObject:model.itemContent];
        model.itemContent = [NSString stringWithFormat:@"%@天",model.itemContent];
        [self.timeArray addObject:model.itemContent];

    }
    
   } successBackfailError:^(id responseObject) {
    
   } failure:^(NSURLSessionDataTask *operation, NSError *error) {
    
}];
    
    NSMutableDictionary *params2 = [[NSMutableDictionary alloc]init];
    [params2 setObject:@"dg_task_price" forKey:@"groupCode"];
    [CBConnect getVersionlistDictiionaryItems:params2 success:^(id responseObject) {
        listDictiionaryItemsModel *model = [[listDictiionaryItemsModel alloc]init];
        for (NSDictionary *dic in responseObject) {
            model.itemContent = dic[@"itemContent"];
            [self.princeArray1 addObject:model.itemContent];
            model.itemContent = [NSString stringWithFormat:@"%@元",model.itemContent];
            
            [self.princeArray addObject:model.itemContent];
           
        }
       
    } successBackfailError:^(id responseObject) {
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];

    
}

#pragma mark ========公司起名行业列表=========

- (void)requestCompanyList{
    //公司行业分类
    NSMutableDictionary *params3 = [[NSMutableDictionary alloc]init];
    [CBConnect getHomeTrademarkCompanyType:params3 success:^(id responseObject) {
        NSArray *array = [CompanyTypeModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
        for (CompanyTypeModel *model in array) {
            [self.idArray addObject:model.sid?:@""];
            [self.industryArray addObject:model.name?:@""];
            
        }
        [self showCompanySheet];
        
    } successBackfailError:^(id responseObject) {
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}


#pragma mark ========网络请求，请求行业列表树=========
- (void)requestCateListTree{
    
    NSMutableDictionary *params = [CBConnect getBaseRequestParams];
    [params setValue:@"1" forKey:@"filter_level	String"];
    [params setValue:@"1" forKey:@"pageNo"];
    [params setValue:@"1000" forKey:@"pageSize"];
    [CBConnect getHomeListCateTree:params success:^(id responseObject) {
        
        NSArray *array = [TradeMarkCategoryModel mj_objectArrayWithKeyValuesArray:responseObject];
        for (TradeMarkCategoryModel *model in array){
            [self.cateArray addObject:model.category_name];
            [self.cateIDArray addObject:model.sid];
            
        }
        [self.classificationArray addObjectsFromArray:array];
    } successBackfailError:^(id responseObject) {
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}


#pragma mark - ==========发布任务==========
-(void)release:(UIButton *)btn{
    UITextView *textView = (UITextView *)[self.view viewWithTag:2014];
    requireDetail = textView.text;
    DLog(@"%@",requireDetail);
    UITextField *text =(UITextField *)[self.view viewWithTag:1029];
    taskTitle = text.text;
    UIButton *wxbtn = (UIButton *)[self.view viewWithTag:8888];
    
    NSString *itemContents = [self.selectTagArray componentsJoinedByString:@"#"];
    DLog(@"%@",itemContents);
    
    if (text.text.length == 0) {
        [LCProgressHUD showFailure:@"请输入标题"];
        return;
    }
    if ([state isEqualToString:@"1"]) {
    if ([btnTitle isEqualToString:@"请选择"]) {
        [LCProgressHUD showFailure:@"请选择行业分类"];
        return;
      }
    }
    if ([btnTitle isEqualToString:@"请选择"]) {
        [LCProgressHUD showFailure:@"请选择行业分类"];
        return;
    }
    if (self.selectTagArray.count == 0) {
        [LCProgressHUD showFailure:@"请选择要求"];
        return;
        
    }
    if (textView.text.length == 0) {
        [LCProgressHUD showFailure:@"请输入具体描述"];
        return;
    }

    if (!expireDays.length) {
        [LCProgressHUD showFailure:@"请截稿周期"];
        return;
    }
    
    if (!price.length) {
        [LCProgressHUD showFailure:@"请选悬赏金额"];
        return;
    }
          //获取本机IP
    NSString *addressIp = [ToolsHelper getIPAddress];
    NSMutableDictionary *params = [CBConnect getBaseRequestParams];
    [params setValue:@"1" forKey:@"taskMode"];//任务所属模块 1-悬赏起名2-大师起名
    [params setValue:state forKey:@"namedCategory"];//起名分类，取值如下：1-商标起名2-公司起名
    [params setValue:taskTitle forKey:@"taskTitle"];//任务标题
    if ([state isEqualToString:@"1"]) {
        [params setValue:self.categoryId forKey:@"categoryId"];//所属行业分类标识
        [params setValue:self.categoryName forKey:@"categoryName"];//所属行业分类名称
    }else{
        [params setValue:self.companyId forKey:@"categoryId"];//所属行业分类标识
        [params setValue:self.companyName forKey:@"categoryName"];//所属行业分类名称
    }
    [params setValue:itemContents forKey:@"itemContents"];//任务要求数据项内容串
    [params setValue:requireDetail forKey:@"requireDetail"];//详细要求描述
    [params setValue:expireDays forKey:@"expireDays"];//截稿周期
    NSString *piceFen = [NSString stringWithFormat:@"%.0f",[price doubleValue]*100];
    [params setValue:piceFen forKey:@"price"];//金额
    if (wxbtn.selected == YES) {
        [params setValue:@(2) forKey:@"payMode"];
        payMode = 2;
        [params setValue:addressIp forKey:@"clientIp"];
    }else{
        [params setValue:@(1) forKey:@"payMode"];
        payMode = 1;
    }
    
    [LCProgressHUD showLoading:@"申请支付中..."];
    [CBConnect getHomeAddTask:params success:^(id responseObject) {
        if (payMode == 1){ //支付宝
            
            //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
            NSString *appScheme = ALIPAY_APP_URLSCHEME;
            [[AlipaySDK defaultService]payOrder:responseObject fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                
            }];
        }else if (payMode == 2) { //微信
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
    } successBackfailError:^(id responseObject) {
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
    
}

//通知
- (void)paySuccess{
    [self.navigationController popViewControllerAnimated:YES];
}

//计算tag高度
- (NSString *)tagHeightWithArray:(NSArray *)array {
    
    TTGroupTagView *taview = [[TTGroupTagView alloc] initWithFrame:CGRectMake(0, 122, ScreenWidth, 50)];
    taview.translatesAutoresizingMaskIntoConstraints = YES;
    [taview addTags:array withCornerScale:0.5];
    
    taview.tagHeight = 20*UIRate;
    
    NSMutableArray *heightArray = [[NSMutableArray alloc] init];
    NSString *height = @"0";
    
    [heightArray addObject:[NSString stringWithFormat:@"%f", taview.changeHeight]];
    if (heightArray.count > 0){
        height = [NSString stringWithFormat:@"%@",heightArray.firstObject];
    }
    return height;
}
@end
