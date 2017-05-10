//
//  BrandDetailVC.m
//  才标网
//
//  Created by caohouhong on 17/3/15.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "BrandDetailVC.h"
#import "BrandDetailTableViewCell.h"
#import "BrandDetailTableViewCell2.h"
#import "CBConnect.h"
#import "BrandSearchModel.h"
#import "BrandGoodsModel.h"
#import "BrandFlowModel.h"

@interface BrandDetailVC ()<UITableViewDelegate, UITableViewDataSource>
{
    BrandSearchModel *model;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *brandImageView;
@property (nonatomic, strong) UILabel *brandNameLabel;
@property (nonatomic, strong) UIButton *favButton;

@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *cellsArray;

@property (nonatomic, strong) NSMutableArray *goodsArray;
@property (nonatomic, strong) NSMutableArray *flowArray;

@end

@implementation BrandDetailVC

- (NSMutableArray *)cellsArray
{
    if (!_cellsArray){
        _cellsArray = [[NSMutableArray alloc] init];
    }
    return _cellsArray;
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray){
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (NSMutableArray *)goodsArray
{
    if (!_goodsArray){
        _goodsArray = [[NSMutableArray alloc] init];
    }
    return _goodsArray;
}

- (NSMutableArray *)flowArray
{
    if (!_flowArray){
        _flowArray = [[NSMutableArray alloc] init];
    }
    return _flowArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"商标详情";
    
    _titleArray = @[@[@"注册号",@"国际分类",@"商标名称",@"初审公告期号",@"初审日期",@"注册日期",@"申请人名称",@"申请人地址",@"代理机构"],@[@"核定使用商品或服务"],@[@"商品流程"]];
    
    
    [self drawView];
    
    [self requestData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (void)drawView{
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 270*UIRate)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    _brandImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10*UIRate, 10*UIRate, ScreenWidth - 20*UIRate, 220*UIRate)];
    _brandImageView.layer.borderWidth = 1;
    _brandImageView.image = [UIImage imageNamed:@"brand_s_default_110x75"];
    _brandImageView.layer.borderColor = COLOR_BackgroundColor.CGColor;
    [headerView addSubview:_brandImageView];
    
    _brandNameLabel = [[UILabel alloc] init];
    _brandNameLabel.textColor = COLOR_Black;
    _brandNameLabel.font = SYSTEM_FONT_BOLD_(15*UIRate);
    [headerView addSubview:_brandNameLabel];
    
    _favButton = [[UIButton alloc] init];
    [_favButton setImage:[UIImage imageNamed:@"brand_s_fav_n_14x12"] forState:UIControlStateNormal];
    [_favButton setImage:[UIImage imageNamed:@"brand_s_fav_s_14x12"] forState:UIControlStateSelected];
    _favButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _favButton.userInteractionEnabled = NO;
    [headerView addSubview:_favButton];
    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = HEXCOLOR(0xeeeeee);
    _tableView.tableHeaderView = headerView;
    [self.view addSubview:_tableView];
   
    
    _tableView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,0)
    .bottomSpaceToView(self.view,0);
    
    _brandNameLabel.sd_layout
    .leftSpaceToView(headerView, 10*UIRate)
    .topSpaceToView(_brandImageView,10*UIRate)
    .widthIs(ScreenWidth/2.0 - 10*UIRate)
    .heightIs(30*UIRate);
    
    _favButton.sd_layout
    .leftSpaceToView(headerView, ScreenWidth/2.0)
    .centerYEqualToView(_brandNameLabel)
    .widthIs(30*UIRate)
    .heightIs(30*UIRate);
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.titleArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = self.titleArray[section];
    return array.count;
}


///代码莫动
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0){
        
        NSString * const cellIdentifier = @"CellIdentifier";
        BrandDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell){
            cell = [[BrandDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        cell.titleLabel.text = self.titleArray[indexPath.section][indexPath.row];
        
        if (indexPath.row == 0){
            cell.contenLabel.textColor = COLOR_Blue;
        }else {
             cell.contenLabel.textColor = COLOR_Gray;
        }
        
        if (self.dataArray.count>0){
             cell.contenLabel.text = self.dataArray[indexPath.row];
        }
        return cell;
    }
    
    if (indexPath.section == 1){
        
        NSString * const cellIdentifier = @"CellIdentifier";
        BrandDetailTableViewCell2 *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell){
            cell = [[BrandDetailTableViewCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        cell.titleLabel.text = self.titleArray[indexPath.section][indexPath.row];
        cell.goodsArray = self.goodsArray;
        return cell;
    }
    
    if (indexPath.section == 2){
        
        NSString * const cellIdentifier = @"Cell";
        BrandDetailTableViewCell2 *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell){
            cell = [[BrandDetailTableViewCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        cell.titleLabel.text = self.titleArray[indexPath.section][indexPath.row];
        cell.flowArray = self.flowArray;
        return cell;
    }

    
    return [[UITableViewCell alloc] init];
}
///代码莫动
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0){
        
        if (self.dataArray.count){
            NSString *str = self.dataArray[indexPath.row];
            CGFloat height = [NSString calculateStringHeightWithWidth:ScreenWidth/2.0 - 10*UIRate font:SYSTEM_FONT_(15*UIRate) string:str] ;
            
            return height + 25*UIRate;
        }
        
    }else if (indexPath.section == 1){
     
        if (self.goodsArray.count){
            CGFloat height = 0;
            for (NSDictionary *dic in self.goodsArray){
                NSString *str = [dic objectForKey:@"detailName"];
                height = height + [NSString calculateStringHeightWithWidth:ScreenWidth/2.0 - 40*UIRate - 10*UIRate font:SYSTEM_FONT_(15*UIRate) string:str] ;
            }
            return height + (self.goodsArray.count + 1)* 10*UIRate;
        }
    } else if (indexPath.section == 2){
        
        if (self.flowArray.count){
            CGFloat height = 0;
            for (NSDictionary *dic in self.flowArray){
                NSString *str = [dic objectForKey:@"detailName"];
                height = height + [NSString calculateStringHeightWithWidth:ScreenWidth/2.0 - 90*UIRate - 10*UIRate font:SYSTEM_FONT_(15*UIRate) string:str] ;
            }
            return height + (self.flowArray.count + 1) * 10*UIRate;
        }
    }
    
    return 40*UIRate;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

#pragma mark - ===============网络请求==============
- (void)requestData{
    
    [LCProgressHUD showLoading:@"加载中..."];
    
    NSMutableDictionary *params = [CBConnect getBaseRequestParams];
    [params setValue:self.cxkeyNum forKey:@"cxkey"]; //商标注册号
    [params setValue:self.intcls forKey:@"intcls"];//国际分类
    
    [CBConnect getBrandViewTradeMark:params success:^(id responseObject) {
        model = [BrandSearchModel mj_objectWithKeyValues:responseObject];
        
        [_brandImageView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage: [UIImage imageNamed:@"brand_s_default_110x75"]];
        _brandNameLabel.text = model.tmname?:@"";
        _favButton.selected = [model.follow isEqualToString:@"true"] ? YES : NO;
 
        NSArray *array = @[model.cxkey?:@"",        //注册号
                           model.intcls?:@"",       //国际分类
                           model.tmname?:@"",       //商标名称
                           model.csggqh?:@"",       //初审公告期号
                           model.csdate?:@"",       //初审日期
                           model.regdate?:@"",      //注册日期
                           model.appname?:@"",      //申请人中文名
                           model.appaddr?:@"",      //申请人地址
                           model.agentname?:@""];    //代理机构
        
        [self.dataArray addObjectsFromArray:array];
        
        for (BrandGoodsModel *goodModel in model.goods){
            
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            [dic setValue:goodModel.goodsCode?:@"" forKey:@"detailNum"];
            [dic setValue:goodModel.goodsName?:@"" forKey:@"detailName"];
            [self.goodsArray addObject:dic];
        }

        for (BrandFlowModel *flowModel in model.flow){
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            [dic setValue:flowModel.flowDate?:@"" forKey:@"detailNum"];
            [dic setValue:flowModel.flowName?:@"" forKey:@"detailName"];
            [self.flowArray addObject:dic];
        }
        
        [self.tableView reloadData];
        
    } successBackfailError:^(id responseObject) {
        
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}
@end
