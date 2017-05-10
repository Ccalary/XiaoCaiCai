//
//  queryVC.m
//  才标网
//
//  Created by baichun on 17/3/14.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "queryVC.h"
#import "queryCell_1.h"
#import "queryCell_2.h"
#import "CBConnect.h"
#import "UserHelper.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"
#import "ToolsHelper.h"


@interface queryVC ()<UITableViewDelegate,UITableViewDataSource>
{
    int payMode;
}
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSString *itemContent;

@property(nonatomic,strong) UITextField *text;
@end

@implementation queryVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"查询中心";
    
    //支付成功通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paySuccess) name:NotificationWexinPayResultSuccess object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paySuccess) name:NotificationAliPayResultSuccess object:nil];
    
    [self drawView];
    [self requData];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)drawView{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.view.backgroundColor = COLOR_BackgroundColor;
    self.tableView = tableView;
    
    tableView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,0)
    .bottomSpaceToView(self.view,0);
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
    if (indexPath.section == 0) {
        queryCell_1 *cell =  [queryCell_1 cellWithTableView:tableView];
        
        return cell;
    }
    queryCell_2 *cell = [queryCell_2 cellWithTableView:tableView];
    self.text = (UITextField *)[self.view viewWithTag:1314];
    self.text.text = self.nameString;
    cell.priceLable.text = [NSString stringWithFormat:@"￥%.2f",[self.itemContent doubleValue]];
    __weak typeof (self) weakSelf = self;
    cell.block0 = ^(UIButton *btn){
        
        [weakSelf requestData];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        return 278*UIRate;
    }
    return 40*UIRate;
}

#pragma mark ======== 复查费用  ========
-(void)requData{
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setValue:@"dg_recheck_price" forKey:@"groupCode"];
    [CBConnect getVersionlistDictiionaryItems:params success:^(id responseObject) {
        for (NSDictionary *dic in responseObject) {
            self.itemContent = dic[@"itemContent"];
        }
        [self.tableView reloadData];
    } successBackfailError:^(id responseObject) {
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}

#pragma mark ========网络请求，查询中心(提交)=========
- (void)requestData{
    
    if (_text.text.length == 0) {
        [LCProgressHUD showFailure:@"请输入商标名称"];
        return;
    }
    UIButton *payBtn = (UIButton *)[self.view viewWithTag:2223];
    //获取本机IP
    NSString *addressIp = [ToolsHelper getIPAddress];
    NSMutableDictionary *params = [CBConnect getBaseRequestParams];
    [params setValue:_text.text forKey:@"brandName"];
    [params setValue:[UserHelper getMemberName] forKey:@"memberName"];
    int price = self.itemContent.doubleValue * 100;
    [params setValue:@(price) forKey:@"price"];
    if (payBtn.selected) {
        [params setValue:@(1) forKey:@"payMode"];
        payMode = 1;
    }else{
        [params setValue:@(2) forKey:@"payMode"];
        payMode = 2;
        [params setValue:addressIp forKey:@"clientIp"];

    }
  
    [LCProgressHUD showLoading:@"支付请求中"];
    [CBConnect getUserCenterAddBrandRechecks:params success:^(id responseObject) {
        if (payMode == 1){ //支付宝
            DLog(@"responseObject%@",responseObject);
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//通知
- (void)paySuccess{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
