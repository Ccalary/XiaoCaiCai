//
//  SettingViewController.m
//  才标网
//
//  Created by caohouhong on 17/3/13.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "SettingViewController.h"
#import "PersonalInfoVC.h"
#import "ChangePsdVC.h"
#import "UserHelper.h"
#import "ServiceVC.h"
#import "enNameVC.h"
@interface SettingViewController()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UITableView *mTableView;
@property(nonatomic, strong) NSArray *dataArray;
//  分组编码，取值如下
//cfg_app_about_us：关于我们
//cfg_app_help：帮助
//cfg_app_call_us：联系我们
@property (nonatomic,strong) NSString *enName;

@end

@implementation SettingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"设置";
    _dataArray = @[@[@"个人资料",@"修改密码"],@[@"帮助",@"联系客服",@"联系我们",@"关于我们"]];
    
    [self drawView];
}

- (void)drawView
{
    _mTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _mTableView.delegate = self;
    _mTableView.dataSource = self;
    _mTableView.backgroundColor = HEXCOLOR(0xeeeeee);
    [self.view addSubview:_mTableView];
    
    _mTableView.sd_layout
    .leftEqualToView(self.view)
    .topEqualToView(self.view)
    .widthRatioToView(self.view, 1)
    .heightRatioToView(self.view, 1);
    
    UIButton *exitButton = [[UIButton alloc] initWithFrame:CGRectMake(15*UIRate, ScreenHeight - 65*UIRate, ScreenWidth - 30*UIRate, 45*UIRate)];
    [exitButton setTitle:@"退出当前账号" forState:UIControlStateNormal];
    exitButton.titleLabel.font = SYSTEM_FONT_(15*UIRate);
    exitButton.layer.cornerRadius = 4.0;
    [exitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [exitButton setBackgroundColor:[UIColor redColor]];
    [exitButton addTarget:self action:@selector(exitBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:exitButton];
}

#pragma mark UITableViewDelegate&&DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = self.dataArray[indexPath.section][indexPath.row];
    cell.textLabel.font = SYSTEM_FONT_(15*UIRate);
    cell.textLabel.textColor = COLOR_Black;
    
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0){
        
        switch (indexPath.row) {
            case 0://个人资料
            {
                PersonalInfoVC *personVC = [[PersonalInfoVC alloc] init];
                [self.navigationController pushViewController:personVC animated:YES];
            }
                break;
            case 1://修改密码
            {
                ChangePsdVC *changeVC = [[ChangePsdVC alloc] init];
                [self.navigationController pushViewController:changeVC animated:YES];
            }
                break;
            default:
                break;
        }
        
    }else {
        switch (indexPath.row) {
            case 0://帮助
            {
                enNameVC *vc = [[enNameVC alloc]init];
                vc.titleName = @"帮助";
                vc.enName = @"cfg_app_help";
                [self.navigationController pushViewController:vc animated:YES];
                
            }
                break;
            case 1://联系客服
            {
                ServiceVC *vc = [[ServiceVC alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
                           }
                break;
            case 2://联系我们
            {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"客服电话" message:@"400-838-0082" preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *done = [UIAlertAction actionWithTitle:@"呼叫" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10) {
                        NSString *phone = [NSString stringWithFormat:@"tel://4008380082"];
                        NSURL *url = [NSURL URLWithString:phone];
                        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
                            NSLog(@"phone success");
                        }];
                    }else{
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://4008380082"]];
                    }

                    
                }];
                [alertController addAction:done];
                
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                        
                    }];
                [alertController addAction:cancel];
                
                [self presentViewController:alertController animated:YES completion:nil];
                
            }
                break;
            case 3://关于我们
            {
                enNameVC *vc = [[enNameVC alloc]init];
                vc.titleName = @"关于我们";
                vc.enName = @"cfg_app_about_us";
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            default:
                break;
        }
    }
}

//退出登录
- (void)exitBtnAction{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确定退出?" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *done = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [UserHelper logout];
        self.tabBarController.selectedIndex = 0;
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }];
    [alertController addAction:done];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
    [alertController addAction:cancel];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}

@end
