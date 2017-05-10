//
//  ReviewResultDetailVC.m
//  才标网
//
//  Created by caohouhong on 17/3/14.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "ReviewResultDetailVC.h"
#import "ReviewResultDetailCell.h"
#import "RegisterTrademarkVC.h"
#import "CBConnect.h"
#import "ReviewListModel.h"

@interface ReviewResultDetailVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSArray *titleArray;

@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) UILabel *reportLabel;
@property (nonatomic, strong) UIImageView *reportImageView;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation ReviewResultDetailVC

- (NSMutableArray *)dataArray
{
    if (!_dataArray){
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"复查结果";
    self.titleArray = @[@"商标名称",@"复查员"];
    [self drawView];
    
    [self requestData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)drawView{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = HEXCOLOR(0xeeeeee);
    _tableView.tableFooterView = self.footerView;
    [self.view addSubview:_tableView];
    
    _tableView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,0)
    .bottomSpaceToView(self.view,0);
}

- (UIView *)footerView
{
    if (_footerView == nil){
        
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 110*UIRate)];
        _footerView.backgroundColor = [UIColor whiteColor];
        
        UILabel *textlabel = [[UILabel alloc] init];
        textlabel.text = @"检索报告";
        textlabel.font = SYSTEM_FONT_(15*UIRate);
        textlabel.textColor = COLOR_Gray;
        [_footerView addSubview:textlabel];
        
        _reportLabel = [[UILabel alloc] init];
        _reportLabel.text = @"";
        _reportLabel.font = SYSTEM_FONT_(15*UIRate);
        _reportLabel.textColor = COLOR_darkGray;
        [_footerView addSubview:_reportLabel];
        
        _reportImageView = [[UIImageView alloc] init];
        _reportImageView.backgroundColor = COLOR_LightGray;
        [_footerView addSubview:_reportImageView];
        
        textlabel.sd_layout
        .leftSpaceToView(_footerView,15*UIRate)
        .topSpaceToView(_footerView,10*UIRate)
        .widthRatioToView(_footerView,0.8)
        .heightIs(20*UIRate);
        
        _reportLabel.sd_layout
        .leftSpaceToView(_footerView,15*UIRate)
        .topEqualToView(_footerView).offset(40*UIRate)
        .widthIs(ScreenWidth - 30*UIRate)
        .autoHeightRatio(0);
        
        _reportImageView.sd_layout
        .leftSpaceToView(_footerView,15*UIRate)
        .topSpaceToView(_reportLabel,15*UIRate)
        .widthIs(ScreenWidth - 30*UIRate)
        .heightIs(195*UIRate);
    }

    return _footerView;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.dataArray.count >= 2){
        return 2;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * const cellIdentifier = @"CellIdentifier";
    ReviewResultDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[ReviewResultDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.topTitleLabel.text = self.titleArray[indexPath.row];
    cell.rightButton.hidden = YES;
    __weak typeof(self) weakSelf = self;
    cell.block = ^{
        RegisterTrademarkVC *vc = [[RegisterTrademarkVC alloc] init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    if (indexPath.row == 0){
        cell.rightButton.hidden = NO;
    }
    
    cell.leftNameLabel.text = self.dataArray[indexPath.row];
    
    
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

#pragma mark - ============网络－复查结果===============
- (void)requestData {
    [LCProgressHUD showLoading:@"正在加载..."];
    
    NSMutableDictionary *params = [CBConnect getBaseRequestParams];
    [params setValue:@(self.recheckId) forKey:@"recheckId"];
    
    [CBConnect getUserCenterViewBrandRechecks:params success:^(id responseObject) {
        
        ReviewListModel *model = [ReviewListModel mj_objectWithKeyValues:responseObject];
        
        [self.dataArray removeAllObjects];
        
        [self.dataArray addObject:model.brandName?model.brandName:@""];
        [self.dataArray addObject:model.creatorName?model.creatorName:@""];
        
        self.reportLabel.text = model.resultText?model.resultText:@"无";
        //H 测试 默认图
        if (model.resultPic) {
           [self.reportImageView sd_setImageWithURL:IMAGE_URL(model.resultPic) placeholderImage:[UIImage imageNamed:@""]];
        }else{
            self.reportImageView.hidden = YES;
        }
        [self.tableView reloadData];
        
        
    } successBackfailError:^(id responseObject) {
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}


@end
