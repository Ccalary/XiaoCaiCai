//
//  SaleBrandVC.m
//  才标网
//
//  Created by caohouhong on 17/3/15.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "SaleBrandVC.h"
#import "WithdrawTableViewCell.h"
#import "CBConnect.h"
#import "ServiceVC.h"
@interface SaleBrandVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSArray *placeholderArray;

@property (nonatomic, strong) NSString *str;
@property (nonatomic, strong) NSString *str2;
@property (nonatomic, strong) NSString *str1;
@property (nonatomic, strong) NSString *str3;
@property (nonatomic, strong) NSString *str4;

@end

@implementation SaleBrandVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"出售商标";
    self.dataArray = @[@"商标名称",@"注册号",@"商标价格",@"您的姓名",@"手机号码"];
    self.placeholderArray = @[@"请输入商标名称",@"请输入注册号(非必填)",@"请输入商标价格",@"请输入您的姓名",@"请输入手机号码"];
    [self drawView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)drawView{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = HEXCOLOR(0xeeeeee);
    [self.view addSubview:tableView];
    
    tableView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,0)
    .bottomSpaceToView(self.view,65*UIRate);
    
    UIButton *changeBtn = [[UIButton alloc] init];
    [changeBtn setTitle:@"提交" forState:UIControlStateNormal];
    [changeBtn setBackgroundColor:COLOR_ButtonBackGround_Orange];
    changeBtn.titleLabel.font = SYSTEM_FONT_(18*UIRate);
    [changeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [changeBtn addTarget:self action:@selector(commitBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:changeBtn];
    
    UIButton *serviceBtn = [[UIButton alloc]initWithFrame:CGRectZero];
    [serviceBtn addTarget:self action:@selector(serviceBtn) forControlEvents:UIControlEventTouchUpInside];
    [serviceBtn setImage:[UIImage imageNamed:@"home_kefu"] forState:UIControlStateNormal];
    [self.view addSubview:serviceBtn];
    
    changeBtn.sd_layout
    .centerXEqualToView(self.view)
    .bottomSpaceToView(self.view, 10*UIRate)
    .widthIs(ScreenWidth - 70*UIRate)
    .heightIs(45*UIRate);
    [changeBtn setSd_cornerRadiusFromHeightRatio:@(0.1)];
    
    serviceBtn.sd_layout
    .rightSpaceToView(self.view,15*UIRate)
    .bottomSpaceToView(self.view,100*UIRate)
    .widthIs(80*UIRate)
    .heightIs(80*UIRate);
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
    cell.titleLabel.font = SYSTEM_FONT_(16*UIRate);
    cell.titleLabel.text = self.dataArray[indexPath.row];
    
    cell.rightTextField.font = SYSTEM_FONT_(16*UIRate);
    cell.rightTextField.placeholder = self.placeholderArray[indexPath.row];
    
    cell.rightTextField.tag = indexPath.row + 10000;
    
    [cell.rightTextField addTarget:self action:@selector(textFieldAction:) forControlEvents:UIControlEventEditingChanged];
    
    if (indexPath.row == 2 || indexPath.row == 4){
        cell.rightTextField.keyboardType = UIKeyboardTypeNumberPad;
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
    return 10*UIRate;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

#pragma mark - Action

- (void)textFieldAction:(UITextField *)textField
{
    int tag = (int)textField.tag;
    switch (tag) {
        case 10000:
        {
          
            self.str = textField.text;
        }
        break;
        
        case 10001:
        {
          
            self.str1 = textField.text;
        }
        break;
        case 10002:
        {
          
            self.str2 = textField.text;
        }
        break;
        case 10003:
        {
           
            self.str3 = textField.text;
        }
        break;
        case 10004:
        {
          
            self.str4 = textField.text;
        }
        break;
        
        default:
        break;
    }
    
}

//客服
- (void)serviceBtn{
    ServiceVC *vc = [[ServiceVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

//提交
- (void)commitBtnAction{
    if (self.str==nil) {
        [LCProgressHUD showMessage:@"请输入名称"];
        return;
    }
    if (self.str2==nil) {
        [LCProgressHUD showMessage:@"请输入价格"];
        return;
    }
    if (self.str3==nil) {
        [LCProgressHUD showMessage:@"请输入您的姓名"];
        return;
    }
    if (self.str4==nil) {
        [LCProgressHUD showMessage:@"请输入手机号码"];
        return;
    }

    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setValue:self.str forKey:@"transfer_product_name"];
    [params setValue:self.str2 forKey:@"transfer_product_price"];
    [params setValue:self.str3 forKey:@"transfer_name"];
    [params setValue:self.str4 forKey:@"transfer_phone"];
    
    [CBConnect getProutTrademark:params success:^(id responseObject) {
        [LCProgressHUD showSuccess:@"提交成功"];
        [self.navigationController popViewControllerAnimated:YES];
    } successBackfailError:^(id responseObject) {
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
    
    
}
@end
