//
//  ChangePsdVC.m
//  才标网
//
//  Created by caohouhong on 17/3/13.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "ChangePsdVC.h"
#import "CBConnect.h"
#import "UserHelper.h"
@interface ChangePsdVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *mTableView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSString *passwordText;
@property (nonatomic, strong) NSString *passwordText1;
@property (nonatomic, strong) NSMutableArray *imageArray;

@end

@implementation ChangePsdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"修改密码";
    self.dataArray = @[@"请输入新密码",@"再次输入新密码"];
    
    [self drawView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

-  (void)drawView
{
    UIImage *ima = [UIImage imageNamed:@"icon_xiala2"];
    [self.imageArray addObject:ima];
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 65*UIRate)];
    bottomView.backgroundColor = [UIColor clearColor];
    
    UIButton *changeBtn = [[UIButton alloc] init];
    [changeBtn setTitle:@"修改" forState:UIControlStateNormal];
    changeBtn.backgroundColor = COLOR_OrangeRed;
    changeBtn.layer.cornerRadius = 4.0;
    [changeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [changeBtn addTarget:self action:@selector(changeBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:changeBtn];
    
    changeBtn.sd_layout
    .leftSpaceToView(bottomView, 15)
    .rightSpaceToView(bottomView, 15)
    .bottomEqualToView(bottomView)
    .heightIs(45*UIRate);
    
    _mTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _mTableView.delegate = self;
    _mTableView.dataSource = self;
    _mTableView.tableFooterView = bottomView;
    _mTableView.backgroundColor = HEXCOLOR(0xeeeeee);
    [self.view addSubview:_mTableView];
    
    _mTableView.sd_layout
    .leftEqualToView(self.view)
    .topEqualToView(self.view)
    .widthRatioToView(self.view, 1)
    .heightRatioToView(self.view, 1);
}

#pragma mark UITableViewDelegate&&DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    UITextField *passwordField = [[UITextField alloc] initWithFrame:CGRectMake(15*UIRate, 0, ScreenWidth - 30, 45*UIRate)];
    passwordField.textColor = COLOR_darkGray;
    passwordField.font = SYSTEM_FONT_(15);
    passwordField.placeholder = self.dataArray[indexPath.row];
    passwordField.tag = 10000+(int)indexPath.row;
    passwordField.secureTextEntry = YES;
    [passwordField addTarget:self action:@selector(textFieldChangeAction:) forControlEvents:UIControlEventEditingChanged];
    [cell.contentView addSubview:passwordField];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45*UIRate;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

//密码框
- (void)textFieldChangeAction:(UITextField *)textField{
    
    switch (textField.tag) {
        case 10000:
        {
            self.passwordText = textField.text;
        }
            break;
        case 10001:
        {
            self.passwordText1 = textField.text;
        }
            break;
        default:
            break;
    }
    
    
    
}

//修改
- (void)changeBtnAction{
    if (!self.passwordText) {
        [LCProgressHUD showMessage:@"请输入密码"];
        return;
    }
    if ([self.passwordText isEqualToString:self.passwordText1]) {
      
        [LCProgressHUD showLoading:@"正在修改"];
        NSMutableDictionary *parms = [[NSMutableDictionary alloc]init];
        [parms setValue:self.passwordText forKey:@"password"];
        [parms setValue:[UserHelper getMemberName] forKey:@"firstname"];
        [parms setValue:[UserHelper getMemberId] forKey:@"memberId"];
        [CBConnect getUserMemberModifyMeber:parms imageArray:self.imageArray isNone:YES success:^(id responseObject) {
            [LCProgressHUD showSuccess:@"修改成功"];
            [self.navigationController popViewControllerAnimated:YES];
        } successBackfailError:^(id responseObject) {
            
        } failure:^(NSURLSessionDataTask *operation, NSError *error) {
            
        }];

    }else{
        
        [LCProgressHUD showMessage:@"密码不一致"];
        return;

    
    }
    
}
@end
