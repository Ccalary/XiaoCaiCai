//
//  WithDrawViewController.m
//  才标网
//
//  Created by caohouhong on 17/3/14.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "WithDrawViewController.h"
#import "WithdrawTableViewCell.h"
#import "WithdrawRewardVC.h"
#import "CBConnect.h"
#import "ToolsHelper.h"

@interface WithDrawViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UILabel *balanceLabel, *tipsLabel;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSArray *placeholderArray;

@property (nonatomic, strong) NSString *moneyNum;
@property (nonatomic, strong) NSString *alipayAccount;
@property (nonatomic, strong) NSString *realName;

@end

@implementation WithDrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"提现";
    
    self.dataArray = @[@"提现金额",@"支付宝账号",@"真实姓名"];
    self.placeholderArray = @[@"请输入提现金额",@"请输入您本人名下的支付宝账号",@"请输入支付宝绑定的真实姓名"];
    
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"提现记录" style:UIBarButtonItemStylePlain target:self action:@selector(rithtWithdrawButton)];
    self.navigationItem.rightBarButtonItem = rightBarItem;

    [self drawView];
    
    [self requestLimitMoney];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self requestData];
}

- (void)drawView{
    
    [self initHeaderView];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 65*UIRate)];
    bottomView.backgroundColor = COLOR_BackgroundColor;
    
    UIButton *changeBtn = [[UIButton alloc] init];
    [changeBtn setTitle:@"提交" forState:UIControlStateNormal];
    changeBtn.backgroundColor = COLOR_ButtonBackGround_Orange;
    changeBtn.layer.cornerRadius = 4.0;
    [changeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [changeBtn addTarget:self action:@selector(commitBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:changeBtn];
    
    changeBtn.sd_layout
    .leftSpaceToView(bottomView, 15*UIRate)
    .rightSpaceToView(bottomView, 15*UIRate)
    .bottomEqualToView(bottomView)
    .heightIs(45*UIRate);
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = HEXCOLOR(0xeeeeee);
    tableView.tableHeaderView = self.headerView;
    tableView.tableFooterView = bottomView;
    [self.view addSubview:tableView];
    
    tableView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,0)
    .bottomSpaceToView(self.view,0);
}

- (void)initHeaderView{
    
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 55*UIRate)];
    _headerView.backgroundColor = COLOR_BackgroundColor;
    
    _balanceLabel = [[UILabel alloc] init];
   
    _balanceLabel.font = SYSTEM_FONT_(15*UIRate);
    _balanceLabel.textColor = COLOR_Black;
     NSString *str = @"可提现余额¥0.00";
    _balanceLabel.attributedText = [ToolsHelper changeSomeText:@"¥0.00" inText:str withColor:COLOR_OrangeRed];
    [_headerView addSubview:_balanceLabel];
    
    _tipsLabel = [[UILabel alloc] init];
    _tipsLabel.text = @"提现限额每次¥500，目前仅支持提现至支付宝帐户";
    _tipsLabel.font = SYSTEM_FONT_(13*UIRate);
    _tipsLabel.textColor = COLOR_Gray;
    [_headerView addSubview:_tipsLabel];

    _balanceLabel.sd_layout
    .leftSpaceToView(_headerView,15*UIRate)
    .topSpaceToView(_headerView,10*UIRate)
    .widthIs(ScreenWidth - 30*UIRate)
    .heightIs(15*UIRate);
    
    _tipsLabel.sd_layout
    .leftEqualToView(_balanceLabel)
    .topSpaceToView(_balanceLabel,6*UIRate)
    .widthIs(ScreenWidth - 30*UIRate)
    .heightIs(15*UIRate);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * const cellIdentifier = @"CellIdentifier";
    WithdrawTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[WithdrawTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.titleLabel.text = self.dataArray[indexPath.row];
    
    cell.rightTextField.placeholder = self.placeholderArray[indexPath.row];
    
    cell.rightTextField.tag = indexPath.row + 10000;
    
    [cell.rightTextField addTarget:self action:@selector(textFieldAction:) forControlEvents:UIControlEventEditingChanged];
    if (indexPath.row == 0){
        
       cell.rightTextField.keyboardType = UIKeyboardTypeDecimalPad;
    }else{
       cell.rightTextField.keyboardType = UIKeyboardTypeDefault;
    }
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50*UIRate;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

#pragma mark - Action

- (void)textFieldAction:(UITextField *)textField
{
    switch (textField.tag) {
        case 10000://金额
            self.moneyNum = textField.text;
            break;
        case 10001://账号
            self.alipayAccount = textField.text;
            break;
        case 10002://姓名
            self.realName = textField.text;
            break;
        default:
            break;
    }
    
    DLog(@"金额%@,账号%@,姓名%@",self.moneyNum,self.alipayAccount,self.realName);
}

//提现记录
- (void)rithtWithdrawButton{
    [self.view endEditing:YES];
    WithdrawRewardVC *vc = [[WithdrawRewardVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - ====提现网络请求=====
//提交
- (void)commitBtnAction{
    
    [self.view endEditing:YES];
    
    if (!self.moneyNum.length){
        [LCProgressHUD showFailure:@"请输入提现金额"];
        return;
    }
    if (!self.alipayAccount.length){
        [LCProgressHUD showFailure:@"请输入支付宝账号"];
        return;
    }

    if (!self.realName.length){
        [LCProgressHUD showFailure:@"请输入真实姓名"];
        return;
    }
    
    int money = [self.moneyNum intValue];
    
    NSMutableDictionary *params = [CBConnect getBaseRequestParams];
    [params setValue:@(money*100) forKey:@"applyAmount"];//提现金额，分
    [params setValue:self.alipayAccount forKey:@"alipayAccount"];//提现的支付宝账户
    [params setValue:self.realName forKey:@"ownerName"];//支付宝账户对应的姓名
    
    [CBConnect getUserCenterAddMemberWithdrawCashApply:params success:^(id responseObject) {
        
        [LCProgressHUD showSuccess:@"提交成功..."];
    
        WithdrawRewardVC *vc = [[WithdrawRewardVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
    } successBackfailError:^(id responseObject) {
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}

//帐户数据请求
- (void)requestData{
    
    [LCProgressHUD showLoading:@"正在加载..."];
    
    NSMutableDictionary *params = [CBConnect getBaseRequestParams];
    
    [CBConnect getUserCenterViewMemberAccount:params success:^(id responseObject) {
        
        if ([responseObject objectForKey:@"accountBalanceYuan"]){
            NSString *moneyStr = [NSString stringWithFormat:@"¥%.2f",[[responseObject objectForKey:@"accountBalanceYuan"] doubleValue]];
            NSString *resultStr = [NSString stringWithFormat:@"可提现余额 %@",moneyStr];
            _balanceLabel.attributedText = [ToolsHelper changeSomeText:moneyStr inText:resultStr withColor:COLOR_OrangeRed];
        }
        
    } successBackfailError:^(id responseObject) {
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}

//提现限额
- (void)requestLimitMoney{

    
    NSMutableDictionary *params3 = [[NSMutableDictionary alloc]init];
    [params3 setObject:@"dg_tixian_limit" forKey:@"groupCode"];
    [CBConnect getVersionlistDictiionaryItems:params3 success:^(id responseObject) {
        
        for (NSDictionary *dic in responseObject) {
           self.tipsLabel.text = [NSString stringWithFormat:@"提现限额每次¥%@，目前仅支持提现至支付宝帐户",[dic objectForKey:@"itemContent"]];
        }

    } successBackfailError:^(id responseObject) {
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}

@end
